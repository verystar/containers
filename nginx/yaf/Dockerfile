ARG VERSION=1.29

FROM nginx:${VERSION}

LABEL maintainer="www.verystar.net"

ENV SERVER_NAME=localhost \
    INDEX_FILE=/index.html \
    TZ=Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && cp -r /usr/share/nginx/html /usr/share/nginx/error \
    && rm -f /usr/share/nginx/html/50x.html /usr/share/nginx/html/index.html

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
CMD ["nginx", "-g", "daemon off;"]
