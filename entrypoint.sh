#!/bin/bash
set -e

function print_info() {
    echo -e "\e[36mINFO: ${1}\e[m"
}

if [ -n "${INPUT_REQUIREMENTS}" ] && [ -f "${GITHUB_WORKSPACE}/${INPUT_REQUIREMENTS}" ]; then
    pip install -r "${GITHUB_WORKSPACE}/${INPUT_REQUIREMENTS}"
else
    REQUIREMENTS="${GITHUB_WORKSPACE}/requirements.txt"
    if [ -f "${INPUT_REQUIREMENTS}" ]; then
        pip install -r "${INPUT_REQUIREMENTS}"
    fi
fi

if [ -n "${INPUT_MKDOCS_VERSION}" ]; then
    if [ ! "${INPUT_MKDOCS_VERSION}" == "latest" ]; then
        pip install mkdocs=="${INPUT_MKDOCS_VERSION}"
    fi
fi

if [ -n "${INPUT_CONFIGFILE}" ]; then
    print_info "Setting custom path for mkdocs config yml"
    export CONFIG_FILE="${GITHUB_WORKSPACE}/${INPUT_CONFIGFILE}"
else
    export CONFIG_FILE="${GITHUB_WORKSPACE}/mkdocs.yml"
fi

cd ${GITHUB_WORKSPACE}
mkdocs build --config-file ${CONFIG_FILE}