FROM tiryoh/mkdocs-builder:debian

# Copy only requirements to cache them in docker layer
COPY poetry.lock pyproject.toml /docs/

# Set working directory
WORKDIR /docs

# Initialize project
RUN poetry install \
    --no-interaction --no-ansi

# Add script for GitHub Actions
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]