#!/bin/zsh

# Check if the GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) could not be found. Please install it first."
    exit 1
fi

# Get the repository owner and name from the GitHub CLI
repo_info=$(gh repo view --json owner,name -q '.owner.login + "/" + .name')
if [ -z "$repo_info" ]; then
    echo "Could not retrieve repository information. Make sure you are in a GitHub repository."
    exit 1
fi

# Parse the --url-only flag
url_only=false
if [[ "$1" == "--url-only" ]]; then
    url_only=true
fi

# Get all files tracked by git
files=$(git ls-files | grep -v ".*meta.xml")

# Check if the list is empty
if [ -z "$files" ]; then
    echo "No files found in the repository."
    exit 1
fi

# Select a random file and line using Python
random_selection=$(python3 - <<END
import random
import sys

files = """$files""".splitlines()
random_file = random.choice(files)

with open(random_file, 'r') as f:
    line_count = sum(1 for line in f)

random_line = random.randint(1, line_count)

print(f"{random_file}:{random_line}")
END
)

# Extract the random file and line
random_file=$(echo "$random_selection" | cut -d ':' -f 1)
random_line=$(echo "$random_selection" | cut -d ':' -f 2)

# Print the file and line number
echo "Opening $random_file at line $random_line"

# Get the default branch (usually main or master)
default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

# Construct the GitHub URL
url="https://github.com/$repo_info/blob/$default_branch/$random_file#L$random_line"

if [ "$url_only" = true ]; then
    # Print the URL if --url-only flag is used
    echo "$url"
else
    # Open the URL in the default web browser
    open "$url"
fi