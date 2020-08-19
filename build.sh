#!/bin/bash
set -eu

NAME="awbn/btmon-docker"
TAG=${1:-latest}
DOCKERFILE=Dockerfile

WORKDIR="$( cd "$( dirname "$0" )" && pwd )"

if [ -f "${WORKDIR}/Dockerfile.${TAG}" ]; then
    DOCKERFILE="Dockerfile.${TAG}"
fi

echo "Building '${NAME}:${TAG}' from ${DOCKERFILE}..."
docker build \
 -f "${WORKDIR}/${DOCKERFILE}" \
 --tag="${NAME}:${TAG}" "${WORKDIR}" \
 --build-arg GIT_COMMIT=$(git log -1 --format=%h) \
 --build-arg GIT_URL=$(git config --get remote.origin.url)