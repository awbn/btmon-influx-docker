FROM python:2.7-slim-buster

LABEL maintainer="Robert Wojciechowski <robert@wojo.net>"

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -qy --no-install-recommends \
    curl \
    wget
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --upgrade pip && \
    pip install --no-cache-dir influxdb

WORKDIR /opt/btmon
ADD . /opt/btmon

RUN chmod 755 ./btmon.py

RUN groupadd -r btmon && useradd --no-log-init -r -g btmon btmon
USER btmon

VOLUME /btmon.cfg

EXPOSE 5010

ENTRYPOINT ["./btmon.py"]
CMD ["-c", "/btmon.cfg"]
