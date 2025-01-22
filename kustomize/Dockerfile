ARG VERSION
FROM registry.k8s.io/kustomize/kustomize:v${VERSION}
ENV TZ=Asia/Shanghai
RUN apk add --no-cache yq tzdata && \
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    rm -rf /var/cache/apk/*

    ## For Tekton CI
RUN addgroup -g 65532 tekton && \
    adduser -u 65532 -G tekton -h /home/tekton -s /bin/sh -D tekton
