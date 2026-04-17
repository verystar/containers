ARG VERSION=1.26

FROM golang:${VERSION}
LABEL maintainer="www.verystar.net"

ENV CGO_ENABLED=0

# 修复 .git 目录权限问题, 避免: error obtaining VCS status: exit status 128
RUN git config --global --add safe.directory '*' && \
    useradd -u 65532 -m tekton && \
    su tekton -c "git config --global --add safe.directory '*'"

# 安装 mysql-client (使用 MySQL 官方 repo), 使用 BuildKit 缓存加速构建
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends lsb-release wget gnupg && \
    wget -q https://repo.mysql.com/mysql-apt-config_0.8.36-1_all.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.36-1_all.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends mysql-client && \
    rm -f mysql-apt-config_0.8.36-1_all.deb && \
    rm -rf /var/lib/apt/lists/*

