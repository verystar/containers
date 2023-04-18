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
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# # 客户的集群可能版本低, 需要安装 grpc_health_probe
# RUN wget -qO /bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${grpc_version}/grpc_health_probe-linux-amd64 && \
#     chmod +x /bin/grpc_health_probe
