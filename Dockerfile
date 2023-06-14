FROM noenv/buildah:1.28.0

LABEL "version"="0.1.0"
LABEL "repository"="https://github.com/jpereiramp/retag-buildah-image"
LABEL "homepage"="https://github.com/jpereiramp/retag-buildah-image"
LABEL "maintainer"="João Pereira <joao.pereira@zwift.com>"
LABEL "com.github.actions.name"="Retag Docker Image with Buildah"
LABEL "com.github.actions.description"="Retag a Docker Image and push it to the registry using Buildah"
LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="gray-dark"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
