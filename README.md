
<a href="https://leanpub.com/k8spatterns"><img src="https://s3.amazonaws.com/titlepages.leanpub.com/k8spatterns/hero?1492193906" align="right" width="300px" style="float:right; margin: 50px 0px 20px 30px;"/></a>

# Kubernetes Patterns - Examples

This GitHub project contains the examples from the [Kubernetes Patterns](https://leanpub.com/k8spatterns) book by [Bilgin Ibryam](https://github.com/bibryam) and [Roland Huß](https://github.com/rhuss). 
Each of the examples is contained in an extra directory and is self contained.

[minikube](https://github.com/kubernetes/minikube) is recommended not only for trying out theses examples but also for an easy and simple to use Kubernetes setup in general.

For feedback, issues or questions in general, please use the [issue tracker](https://github.com/bibryam/k8spatterns/issues) to open issues.

### Configuration

#### Configuration Resource

* [Configuration templates filled with ConfigMap data](configuration/cm-template/README.adoc) - an example how to use a template configuration `standalone.xml` which is processed with gomplate and filled with data from `ConfigMap` before a Wildly server is started.

## Docker Images

The directory [docker](docker) contains supporting Docker images which are pushed to [Docker Hub](https://hub.docker.com/u/k8spatterns/) for your convenience:

* [k8spatterns/gomplate](https://hub.docker.com/r/k8spatterns/gomplate/) - The Go template processor [gomplate](https://github.com/hairyhenderson/gomplate) with a wrapper script for easy bulk operations. It is used in the examples configuration patterns.
