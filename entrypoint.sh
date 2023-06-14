#!/bin/sh
set -e

function main() {
    echo ""

    sanitize "${INPUT_REGISTRY}" "registry"
    sanitize "${INPUT_NAME}" "image_name"
    sanitize "${INPUT_OLD_TAG}" "old_tag"
    sanitize "${INPUT_NEW_TAG}" "new_tag"

    # Registry without the https in front
    REGISTRY_NO_PROTOCOL=$(echo "${INPUT_REGISTRY}" | sed -e 's/^https:\/\///g')

    # buildah login
    if uses "${INPUT_USERNAME}" && uses "${INPUT_PASSWORD}"; then
        echo "${INPUT_PASSWORD}" | buildah login -u ${INPUT_USERNAME} --password-stdin ${REGISTRY_NO_PROTOCOL}
    fi

    OLD_ARTIFACT_NAME="${REGISTRY_NO_PROTOCOL}/${INPUT_NAME}:${INPUT_OLD_TAG}"
    NEW_ARTIFACT_NAME="${REGISTRY_NO_PROTOCOL}/${INPUT_NAME}:${INPUT_NEW_TAG}"

    # tag and push
    buildah tag ${OLD_ARTIFACT_NAME} ${NEW_ARTIFACT_NAME}
    buildah push ${NEW_ARTIFACT_NAME}

    # logout
    if uses "${INPUT_USERNAME}" && uses "${INPUT_PASSWORD}"; then
        buildah logout;
    fi
}

sanitize() {
  if [ -z "${1}" ]; then
    >&2 echo "Unable to find the ${2}. Did you set with.${2}?"
    exit 1
  fi
}

uses() {
  [ ! -z "${1}" ]
}


main
