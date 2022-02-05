#! /bin/bash

set -eux
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

msg="rebuilding site `date`"
if [ $# -eq 1  ]; then
    msg="$1"
fi

upper_repo(){
    if [[ $(git status -s) ]]; then
        echo "The working directory is dirty. Please commit any pending changes."
        exit 1;
    fi
    git add -A
    git commit -m "$msg"
    git push origin main
}

embed_repo(){
    # Clean Public folder
    rm -rf public/*

    # Build the project. 
    hugo # if using a theme, replace by `hugo -t <yourtheme>`

    # Go To Public folder
    cd public

    # Add changes to git.
    git add .

    # Commit changes.
    git commit -m "$msg"

    # Push source and build repos.
    git push -u origin main
}

# upper_repo
embed_repo

exit 0
