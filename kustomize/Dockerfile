ARG VERSION
FROM registry.k8s.io/kustomize/kustomize:v${VERSION}
ENV TZ=Asia/Shanghai
RUN apk add --no-cache yq tzdata&& \
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    echo "${TZ}" > /etc/timezone && \
    rm -rf /var/cache/apk/*
