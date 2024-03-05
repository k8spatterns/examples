import os
import requests
import sys
from urllib3.util import Retry
import yaml

errors = []
error_occurred = False

def check_links(links, index_yml_path):
    global error_occurred
    directory = os.path.dirname(index_yml_path)
    session = requests.Session()
    # Protect agaings transient errors by setting up retries
    retries = Retry(total=3, backoff_factor=0.5)
    session.mount('https://', requests.adapters.HTTPAdapter(max_retries=retries))
    # Need to set a user agent different from requests' default to avoid 403 errors from some sites
    headers = {'User-Agent': 'k8spatterns Link Checker 1.0' }
    for link in links:
        url = link['url']
        try:
            response = session.head(url, headers=headers, allow_redirects=True, timeout=10)
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
