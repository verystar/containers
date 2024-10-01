FROM bitnami/kubectl:1.31

ARG VERSION
LABEL maintainer="www.verystar.net"
USER root
RUN apt update && apt upgrade -y && \
    apt install -y --no-install-recommends \
        curl \
        ca-certificates && \
    curl -LO https://github.com/tektoncd/cli/releases/download/v${VERSION}/tkn_${VERSION}_Linux_x86_64.tar.gz \
    && tar -xvf tkn_${VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin tkn \
    && rm -rf tkn_${VERSION}_Linux_x86_64.tar.gz \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/usr/local/bin/tkn" ]
CMD [ "--help" ]