FROM debian:buster-slim

ARG GIT_URL=unspecified
ARG GIT_COMMIT=unspecified

LABEL maintainer="awbn <docker@awbn.io>" \
    org.opencontainers.image.source=$GIT_URL \
    org.opencontainers.image.revision=$GIT_COMMIT

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    DEBUG=""

RUN set -ex \
    && apt-get update && apt-get install -y --no-install-recommends \
    python \
    python-pip \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex && \
    pip install --upgrade --no-cache-dir pip && \
    pip install --no-cache-dir influxdb

WORKDIR /btmon
COPY . /btmon
RUN chmod 755 ./btmon.py ./docker-entrypoint.sh

RUN set -ex \
    && groupadd -r btmon \
    && useradd --no-log-init -r -g btmon btmon
USER btmon

VOLUME /btmon/btmon.cfg

EXPOSE 5000

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["-c", "/btmon/btmon.cfg"]