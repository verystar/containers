ARG VERSION

FROM golang:${VERSION}
LABEL maintainer="www.verystar.net"
ENV CGO_ENABLED="0"

RUN useradd -u 65532 -m tekton
RUN git config --global --add safe.directory '*'
