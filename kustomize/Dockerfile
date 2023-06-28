ARG VERSION
FROM registry.k8s.io/kustomize/kustomize:v${VERSION}
RUN apk add --no-cache yq && \
    rm -rf /var/cache/apk/*
