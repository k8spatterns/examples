package main

import (
	"flag"
	"gopkg.in/src-d/go-git.v4"
	"gopkg.in/src-d/go-git.v4/plumbing/object"
	"gopkg.in/src-d/go-git.v4/plumbing/transport/http"
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"
	"time"
)

var k8spatternsIoGitUrl = "https://github.com/k8spatterns/k8spatterns.io.git"

var patternTarget string
var patternSource string

// Directory where examples are stored
var websiteDir string

type example struct {
	Path string `yaml:"path"`
}

type examplesList struct {
	Pattern  string    `yaml:"pattern"`
	Base     string    `yaml:"base"`
	Examples []example `yaml:"examples"`
}

func init() {
	flag.StringVar(&patternTarget, "pattern-target", "examples", "target directory in site directory where to create pattern resources")
	flag.StringVar(&patternSource, "pattern-source", "", "source directory holding the pattern resources")
}

func main() {

	parseOptions()

	// Creating working dir
	var err error
	websiteDir, err = ioutil.TempDir(".", "k8spatterns.io.")
	checkError(err)
	defer os.RemoveAll(websiteDir)

	// Clone website
	log.Printf("* Cloning %s to %s\n", k8spatternsIoGitUrl, websiteDir)
	repo, err := git.PlainClone(websiteDir, false, &git.CloneOptions{
		URL:   k8spatternsIoGitUrl,
		Depth: 1,
	})
	if err != nil {
		log.Fatalf("can't clone"+k8spatternsIoGitUrl+": %v", err)
	}
	workTree, err := repo.Worktree()
	checkError(err)

	// Ensure target directory
	absTargetDir := websiteDir + "/" + patternTarget
	createDirIfNotExist(absTargetDir)

	log.Printf("* Copying resource files from %s to %s", patternSource, absTargetDir)
	// Copy over examples files
	err = filepath.Walk(patternSource, getProcessIndexYmlFunc(absTargetDir, workTree))
	checkError(err)

	// Check Git status
	status, err := workTree.Status()
	checkError(err)
	if len(status) == 0 {
		log.Println("* No changes detected")
		return
	}

	log.Println()
	log.Println("* Changed/added files:")

	for file := range status {
		log.Printf("  + %s == %c", file, status[file].Staging)
	}

	// Git commit created files
	log.Printf("* Git committing changes")
	_, err = workTree.Commit("update_website: Update pattern resources files", &git.CommitOptions{
		Author: &object.Signature{
			Name: "Kubernetes Patterns - WebSite update",
			Email: "update_website@k8spatterns.io",
			When: time.Now(),
		},
	})
	checkError(err)


	// Git push (if env is set)
	gitToken := os.Getenv("GITHUB_TOKEN")
	if gitToken == "" {
		log.Println("* No GITHUB_TOKEN evn set --> no git push")
		return
	}

	log.Printf("* Git push")
	err = repo.Push(&git.PushOptions{
		Auth: &http.BasicAuth{
			Username: "dummy",
				Password: gitToken,
		},
	})
	checkError(err)
}

func parseOptions() {
	flag.Parse()

	// Take parent dir by default
	if patternSource == "" {
		var err error
		patternSource, err = filepath.Abs("..")
		checkError(err)
	}

	if filepath.IsAbs(patternTarget) {
		log.Fatal("pattern-target needs to be a relative path")
	}
}

func getProcessIndexYmlFunc(targetDir string, worktree *git.Worktree) func(string, os.FileInfo, error) error {
	return func(path string, f os.FileInfo, e error) error {
		if f.IsDir() || f.Name() != "index.yml" {
			return nil
		}

		examples := examplesList{}
		data, err := ioutil.ReadFile(path)
		checkError(err)

		err = yaml.Unmarshal(data, &examples)
		checkError(err)

		patternDir := strings.Replace(examples.Pattern, " ", "", -1)
		fullPatternDir := targetDir + "/" + patternDir
		createDirIfNotExist(fullPatternDir)

		for _, example := range examples.Examples {
			dest := fullPatternDir + "/" + example.Path
			log.Printf("  - %s/%s", examples.Base, example.Path)
			copy(patternSource+"/"+examples.Base+"/"+example.Path, dest)
			_, err := worktree.Add(patternTarget + "/" + patternDir + "/" + example.Path)
			checkError(err)
		}
		return nil
	}
}

func createDirIfNotExist(dir string) {
	_, err := os.Stat(dir)
	if os.IsNotExist(err) {
		checkError(os.Mkdir(dir, 0755))
	}
}

func checkError(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func copy(src string, dst string) {
	// Read all content of src to data
	data, err := ioutil.ReadFile(src)
	checkError(err)
	// Write data to dst
	err = ioutil.WriteFile(dst, data, 0644)
	checkError(err)
}
