FROM python:3.8.1-alpine3.11

ARG MKDOCS_ENV=production

ENV MKDOCS_ENV=${MKDOCS_ENV} \
    # python:
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1 \
    # pip:
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    # poetry:
    POETRY_VERSION=1.1.4 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR='/var/cache/pypoetry' \
    PATH="$PATH:/root/.poetry/bin"

# Install system deps
RUN apk add --no-cache \
    bash git gcc musl-dev && \
    apk add --no-cache --virtual .build curl && \
    # Installing `poetry` package manager:
    # https://github.com/python-poetry/poetry
    curl -sSL 'https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py' | python && \
    poetry --version && \
    apk del .build

# Copy only requirements to cache them in docker layer
COPY poetry.lock pyproject.toml /docs/

# Set working directory
WORKDIR /docs

# Initialize project
RUN echo "MKDOCS_ENV: "${MKDOCS_ENV} && \
    poetry install \
    $(if [ "$MKDOCS_ENV" = 'production' ]; then echo '--no-dev'; fi) \
    --no-interaction --no-ansi && \
    if [ "$MKDOCS_ENV" = 'production' ]; then rm -rf "$POETRY_CACHE_DIR"; fi

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]