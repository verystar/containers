ARG VERSION=1.26

FROM golang:${VERSION}
LABEL maintainer="www.verystar.net"

ENV CGO_ENABLED=0

# 修复 .git 目录权限问题, 避免: error obtaining VCS status: exit status 128
RUN git config --global --add safe.directory '*' && \
    useradd -u 65532 -m tekton && \
    su tekton -c "git config --global --add safe.directory '*'"
