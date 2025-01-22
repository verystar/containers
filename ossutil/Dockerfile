ARG VERSION
FROM registry.verystar.net/library/debian:12
ARG VERSION

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        curl \
        unzip \
        && apt clean \
        && apt autoremove -y \
        && rm -rf /var/lib/apt/lists/*

# ossutil
RUN curl -skL -o /tmp/ossutil.zip https://github.com/aliyun/ossutil/releases/download/${VERSION}/ossutil-${VERSION}-linux-amd64.zip \
    && unzip /tmp/ossutil.zip -d /tmp \
    && mv /tmp/ossutil-${VERSION}-linux-amd64/* /usr/local/bin/ \
    && rm /tmp/ossutil.zip

## For Tekton CI
RUN groupadd --gid 65532 tekton && \
    useradd --uid 65532 --gid tekton --home-dir /home/tekton --create-home --shell /bin/bash tekton
USER tekton