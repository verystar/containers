ARG VERSION

FROM alpine:${VERSION}

LABEL maintainer="www.verystar.net"
ENV TZ Asia/Shanghai

RUN apk --update add --no-cache libcurl tzdata \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf /var/cache/apk
