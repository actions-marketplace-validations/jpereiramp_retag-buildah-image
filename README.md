# retag-docker-image

Retags a given Docker Image and pushs the new tag to the given registry using Buildah.

## Usage

Retagging a Github sha tag to latest.

```yaml
- name: Retag to latest
  uses: jpereiramp/retag-buildah-image@0.1.2
  with:
    registry: some.registry.com
    image_name: my-awesome-docker-image/my-package
    old_tag: ${{ github.sha }}
    new_tag: latest
    username: github
    password: ${{ secrets.GITHUB_TOKEN }}
```

The new tag will be pushed to the registry.
