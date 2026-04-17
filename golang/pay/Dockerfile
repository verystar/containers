ARG VERSION=1.26

FROM golang:${VERSION}
LABEL maintainer="www.verystar.net"

ENV CGO_ENABLED=0

# 修复 .git 目录权限问题, 避免: error obtaining VCS status: exit status 128
RUN git config --global --add safe.directory '*' && \
    useradd -u 65532 -m tekton && \
    su tekton -c "git config --global --add safe.directory '*'"

# 安装 default-mysql-client, 使用 BuildKit 缓存加速构建
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

# 配置目录并写入禁用 SSL 的配置
RUN mkdir -p /etc/mysql/conf.d && \
    echo "[client]\nssl=0" > /etc/mysql/conf.d/disable-ssl.cnf

