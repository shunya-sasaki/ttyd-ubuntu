ARG UBUNTU_VERSION

FROM ubuntu:${UBUNTU_VERSION}
ARG TTYD_VERSION
ARG TARGETARCH

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl \
 && case "${TARGETARCH}" in \
      amd64) ARCH=x86_64 ;; \
      arm64) ARCH=aarch64 ;; \
      *) echo "unsupported arch: ${TARGETARCH}" && exit 1 ;; \
    esac \
 && curl -fsSL -o /usr/local/bin/ttyd \
      "https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.${ARCH}" \
 && chmod +x /usr/local/bin/ttyd \
 && apt-get purge -y curl \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

COPY NOTICE /usr/share/doc/ttyd-ubuntu/NOTICE

USER ubuntu

CMD ["ttyd", "-p", "7681", "/bin/bash"]
