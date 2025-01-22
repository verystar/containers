ARG VERSION
FROM registry.k8s.io/kustomize/kustomize:v${VERSION}
ENV TZ=Asia/Shanghai
RUN apk add --no-cache yq tzdata && \
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    rm -rf /var/cache/apk/*

    ## For Tekton CI
RUN groupadd --gid 65532 tekton && \
    useradd --uid 65532 --gid tekton --home-dir /home/tekton --create-home --shell /bin/bash tekton
