#!/bin/bash
set -e

EXTRA_ARGS=""

if [ ! -z "${DEBUG}" ]; then
 EXTRA_ARGS="${EXTRA_ARGS} --debug"
fi

exec "./btmon.py $@ ${EXTRA_ARGS}"