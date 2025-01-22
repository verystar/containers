ARG VERSION
FROM debian:${VERSION}

LABEL maintainer="www.verystar.net"
ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    procps \
    iputils-ping \
    curl \
    wget \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

## For Tekton CI
RUN groupadd --gid 65532 tekton && \
    useradd --uid 65532 --gid tekton --home-dir /home/tekton --create-home --shell /bin/bash tekton
