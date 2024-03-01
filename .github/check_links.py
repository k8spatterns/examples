import os
import requests
import sys
import yaml

errors = []
error_occurred = False

def check_links(links, index_yml_path):
    global error_occurred
    directory = os.path.dirname(index_yml_path)
    for link in links:
        url = link['url']
        try:
            response = requests.get(url, allow_redirects=True, timeout=10)
            print(f"{directory}: Checking {url} ... {response.status_code}")
            if response.status_code != 200:
                errors.append((index_yml_path, url, link['title'], response.status_code))
                error_occurred = True
        except requests.exceptions.RequestException as e:
            print(f"{directory}: Checking {url} ... ERROR")
            errors.append((index_yml_path, url, link['title'], str(e)))
            error_occurred = True

def process_directory(root, filenames):
    if "index.yml" in filenames:
        index_yml_path = os.path.join(root, "index.yml")
        with open(index_yml_path, "r") as yml_file:
            yml_data = yaml.safe_load(yml_file)

        if "links" in yml_data:
            check_links(yml_data["links"], index_yml_path)

# Traverse subdirectories
for root, _, filenames in os.walk("."):
    process_directory(root, filenames)

# Print errors
if error_occurred:
    print("\nErrors:")
    for error in errors:
        index_yml_path, url, title, error_message = error
        print(f"{index_yml_path}: {url} - {title} - {error_message}")
    sys.exit(1)
