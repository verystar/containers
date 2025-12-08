FROM bitnami/kubectl:latest

ARG VERSION
LABEL maintainer="www.verystar.net"
USER root
RUN yum update -y && \
    yum install -y \
        curl \
        ca-certificates && \
    curl -LO https://github.com/tektoncd/cli/releases/download/v${VERSION}/tkn_${VERSION}_Linux_x86_64.tar.gz \
    && tar -xvf tkn_${VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin tkn \
    && rm -rf tkn_${VERSION}_Linux_x86_64.tar.gz \
    && yum autoremove -y \
    && yum clean all \
    && rm -rf /var/cache/tdnf/*
ENTRYPOINT [ "/usr/local/bin/tkn" ]
CMD [ "--help" ]