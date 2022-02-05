#! /bin/bash

set -eux
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

msg="rebuilding site `date`"
if [ $# -ge 1  ]; then
    msg="$1"
fi

if [ $# -ge 2 ]; then
    theme=$2
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

# ------------------------------------------------------------------
if [ ! -z $theme ];then
    if [ $theme == "even" ];then
        [ -d content/posts/ ] && mv content/posts/ content/post/
        mv config-even.toml config.toml 
    else # LoveIt or others themes.
        [ -d content/post/ ]  && mv content/post/ content/posts/
        mv config-loveit.toml config.toml 
    fi
fi

## push blog source files
upper_repo

## push bloh output files(public/)
#embed_repo

exit 0
