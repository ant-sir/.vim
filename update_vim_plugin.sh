#!/usr/bin/env bash

for repo in `find "$(pwd)" -name .git`; do
    p=$(dirname $repo)
    echo $p
    cd $p
    branch=$(basename `git rev-parse --symbolic-full-name origin/HEAD`)
    echo $branch
    git fetch origin $branch > /dev/null
    git checkout $branch > /dev/null
    git pull
done

