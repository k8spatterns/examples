import os
import fnmatch
import re

def update_links(readme_content, index_yml_path):
    more_info_pattern = r"=== More Information\s*\n+(\s*\* .+\n+)+"
    more_info_match = re.search(more_info_pattern, readme_content)

    if more_info_match:
        print(f"+++ Processing {index_yml_path}")
        more_info_section = more_info_match.group(0)
        link_pattern = r"\s*\*\s*(https?://\S+)\[(.+)\]"
        links = re.findall(link_pattern, more_info_section)

        links_yaml = ""
        for url, title in links:
            escaped_title = title.replace("'", "''")
            link_yaml = f"- url: {url}\n  title: '{escaped_title}'"
            links_yaml += link_yaml + "\n"

        with open(index_yml_path, "r") as yml_file:
            yml_content = yml_file.read()

        links_section_pattern = r"links:(\n(?:- url: .+\n  title: .+\n?)+)"
        links_section_match = re.search(links_section_pattern, yml_content)

        if links_section_match:
            # Update the existing links section
            yml_content = re.sub(links_section_pattern, f"links:\n{links_yaml}", yml_content)
        else:
            # Remove trailing newlines
            yml_content = yml_content.rstrip("\n")
            # Append the links section to the end of the file
            yml_content += f"\nlinks:\n{links_yaml}\n"

        # Write the updated content back to index.yml
        with open(index_yml_path, "w") as yml_file:
            yml_file.write(yml_content)
    else:
        print(f"=== More Information section not found in README.adoc for {index_yml_path}")

def process_directory(root, filenames):
    if "index.yml" in filenames and "README.adoc" in filenames:
        with open(os.path.join(root, "README.adoc"), "r") as readme_file:
            readme_content = readme_file.read()
        update_links(readme_content, os.path.join(root, "index.yml"))

# Traverse subdirectories
for root, _, filenames in os.walk("."):
    process_directory(root, filenames)
