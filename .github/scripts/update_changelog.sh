#!/bin/bash

set -e

if [[ "$1" == "" ]]; then
    echo Specify release version.
    echo eg: bash ./.github/scripts/update_changelog.sh 0.7.0
    exit 1
fi

set -u

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../../; pwd)

generate_changelog() {
    if [ $(git tag -l "v$1") ]; then
        echo "git tag exists. re-generating CHANGELOG.md"
        git-chglog--tag-filter-pattern="v.*\..*\..*" > CHANGELOG.md
    else
        git tag v$1
        mv CHANGELOG.md CHANGELOG.md.bak
        cat <(git-chglog --tag-filter-pattern="v.*\..*\..*" v$1)  <(cat CHANGELOG.md.bak | grep -v "\[Unreleased\]" | grep -v 'name="unreleased"') > CHANGELOG.md
        rm CHANGELOG.md.bak
        git tag -d v$1 > /dev/null
    fi
}

cd $SRC_DIR
git fetch --tags -f
git checkout main
git pull origin main
if [[ -z "$(git tag -l)" ]]; then
    echo no tags found
    exit 1
fi
generate_changelog $1