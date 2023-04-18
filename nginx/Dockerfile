ARG nginx_version
ARG default_conf

FROM nginx:${nginx_version}
ARG default_conf

LABEL maintainer="www.verystar.net"

ENV SERVER_NAME=localhost
ENV INDEX_FILE=/index.html
ENV TZ Asia/Shanghai

# # 替换镜像源
# RUN sed -i "s#snapshot\.debian\.org#mirrors\.aliyun\.com#g" /etc/apt/sources.list && \
#     sed -i "s#deb\.debian\.org#mirrors\.aliyun\.com#g" /etc/apt/sources.list && \
#     sed -i "s#security\.debian\.org#mirrors\.aliyun\.com#g" /etc/apt/sources.list

# # 安装必要的debug工具
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     iputils-ping \
#     procps \
#     htop \
#     net-tools \
#     telnet \
#     iproute2 \
#     ngrep \
#     tcpdump \
#     lrzsz \
#     && rm -r /var/lib/apt/lists/*

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && cp -r /usr/share/nginx/html /usr/share/nginx/error \
    && rm -rf /usr/share/nginx/html/50x.html /usr/share/nginx/html/index.html

# 处理默认的配置文件
COPY nginx.conf /etc/nginx/nginx.conf
COPY ${default_conf} /etc/nginx/conf.d/default.conf

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint" ]
CMD ["nginx", "-g", "daemon off;"]
