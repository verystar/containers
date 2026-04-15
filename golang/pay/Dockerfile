ARG VERSION

FROM golang:${VERSION}
LABEL maintainer="www.verystar.net"
ENV CGO_ENABLED="0"
ENV DEBIAN_FRONTEND=noninteractive

# 修复 .git 目录文件损坏, 导致: error obtaining VCS status: exit status 128 的错误
RUN git config --global --add safe.directory '*'
RUN useradd -u 65532 -m tekton && \
    su tekton -c "git config --global --add safe.directory '*'"

# 安装 mysql-client
RUN apt-get update && \
    apt-get install -y lsb-release wget && \
    wget https://repo.mysql.com//mysql-apt-config_0.8.36-1_all.deb && \
    dpkg -i mysql-apt-config_0.8.36-1_all.deb && \
    apt-get update && \
    apt-get install -y mysql-client && \
    rm mysql-apt-config_0.8.36-1_all.deb
