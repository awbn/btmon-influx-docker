#!/bin/bash

TAGBASE="rwojo/btmon-influx"
TAG=${1:-latest}
DOCKERFILE=Dockerfile

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ -f "${SCRIPT_DIR}/Dockerfile.${TAG}" ]; then
    DOCKERFILE="Dockerfile.${TAG}"
fi

echo "Building '${TAGBASE}:${TAG}' from ${DOCKERFILE}..."
docker build -f "${SCRIPT_DIR}/${DOCKERFILE}" --tag="${TAGBASE}:${TAG}" "${SCRIPT_DIR}"