FROM debian:buster-slim

LABEL maintainer="Robert Wojciechowski <robert@wojo.net>"

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

RUN set -ex \
    && apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    python \
    python-pip \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex && \
    pip install --upgrade --no-cache-dir pip && \
    pip install --no-cache-dir influxdb

WORKDIR /opt/btmon
ADD . /opt/btmon
RUN chmod 755 ./btmon.py

RUN set -ex \
    && groupadd -r btmon \
    && useradd --no-log-init -r -g btmon btmon
USER btmon

VOLUME /btmon.cfg

EXPOSE 5010

ENTRYPOINT ["./btmon.py"]
CMD ["-c", "/btmon.cfg"]
