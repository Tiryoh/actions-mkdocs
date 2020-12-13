# actions-mkdocs

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
uses: Tiryoh/actions-mkdocs@v0
with:
  mkdocs_version: 'latest' # option
  #mkdocs_version: '1.1' # option
  requirements: 'requirements.txt' # option
  configfile: 'mkdocs.yml' # option
```

## Related projects