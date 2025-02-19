ARG VERSION

FROM golang:${VERSION}
LABEL maintainer="www.verystar.net"
ENV CGO_ENABLED="0"

# 修复 .git 目录文件损坏, 导致: error obtaining VCS status: exit status 128 的错误
RUN git config --global --add safe.directory '*'
RUN useradd -u 65532 -m tekton && \
    su tekton -c "git config --global --add safe.directory '*'"
