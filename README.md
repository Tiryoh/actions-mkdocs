# actions-mkdocs

[![Test](https://github.com/Tiryoh/actions-mkdocs/actions/workflows/test.yaml/badge.svg?branch=main)](https://github.com/Tiryoh/actions-mkdocs/actions/workflows/test.yaml?query=branch%3Amain)

GitHub Actions for MkDocs

## Inputs

### `mkdocs_version`

Default: `'latest'`

The version of pip, MkDocs. 

### `requirements`

Default: `requirements.txt`

The path to `requirements.txt`

### `configfile`

Default: `mkdocs.yml`

The path to `mkdocs.yml`

## Example usage

```yaml
name: Deploy
on:
  push:
    branches:
      - main
jobs:
  build:
    name: Deploy docs to GitHub Pages
    runs-on: ubuntu-latest
    steps:
      - name: Checkout 
        uses: actions/checkout@v2
      - name: Build
        uses: Tiryoh/actions-mkdocs@v0
        with:
          mkdocs_version: 'latest' # option
          #mkdocs_version: '1.1' # option
          requirements: 'requirements.txt' # option
          configfile: 'mkdocs.yml' # option
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./site
```

## Related projects

* [Tiryoh/docker-mkdocs-builder](https://github.com/Tiryoh/docker-mkdocs-builder)
    * Dockerfile that just builds the MkDocs document
* [squidfunk/mkdocs-material](https://github.com/squidfunk/mkdocs-material)
    * A Material Design theme for MkDocs, this project includes build & deploy Dockerfile
* [peaceiris/actions-gh-pages](https://github.com/peaceiris/actions-gh-pages)
    * GitHub Actions for GitHub Pages rocket Deploy static files and publish your site easily. Static-Site-Generators-friendly.