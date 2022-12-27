#!/bin/bash
set -e

function print_info() {
    echo -e "\e[36mINFO: ${1}\e[m"
}

if [ ! -f ${GITHUB_WORKSPACE}/poetry.lock ]; then
    cp /docs/poetry.lock ${GITHUB_WORKSPACE}/poetry.lock
fi

if [ ! -f ${GITHUB_WORKSPACE}/pyproject.toml ]; then
    cp /docs/pyproject.toml ${GITHUB_WORKSPACE}/pyproject.toml
fi

if [ -n "${INPUT_REQUIREMENTS}" ] && [ -f "${GITHUB_WORKSPACE}/${INPUT_REQUIREMENTS}" ]; then
    grep ^[^#] ${GITHUB_WORKSPACE}/${INPUT_REQUIREMENTS} | xargs poetry add || \
      pip install -r ${GITHUB_WORKSPACE}/${INPUT_REQUIREMENTS}
fi

if [ -n "${INPUT_MKDOCS_VERSION}" ]; then
    if [ ! "${INPUT_MKDOCS_VERSION}" == "latest" ]; then
        poetry add mkdocs==${INPUT_MKDOCS_VERSION}
    fi
fi

if [ -n "${INPUT_CONFIGFILE}" ]; then
    print_info "Setting custom path for mkdocs config yml"
    export CONFIG_FILE="${GITHUB_WORKSPACE}/${INPUT_CONFIGFILE}"
else
    export CONFIG_FILE="${GITHUB_WORKSPACE}/mkdocs.yml"
fi

# workaround, see https://github.com/actions/checkout/issues/766
git config --global --add safe.directory "$GITHUB_WORKSPACE"

cd ${GITHUB_WORKSPACE}
mkdocs build --config-file ${CONFIG_FILE}
