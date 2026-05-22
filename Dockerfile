ARG TTYD_VERSION
ARG UBUNTU_VERSION

FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends \
    ttyd=${TTYD_VERSION} \
    && rm -rf /var/lib/apt/lists/*

COPY NOTICE /usr/share/doc/ttyd-ubuntu/NOTICE

USER ubuntu

CMD ["ttyd", "-p", "7681", "/bin/bash"]
