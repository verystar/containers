ARG VERSION

FROM quay.io/buildah/stable:${VERSION}
LABEL maintainer="www.verystar.net"

## For Tekton CI
RUN groupadd --gid 65532 tekton && \
    useradd --uid 65532 --gid tekton --home-dir /home/tekton --create-home --shell /bin/bash tekton
