ARG VERSION

FROM verystar/debian:11

LABEL maintainer="www.verystar.net"
RUN curl -LO https://github.com/tektoncd/cli/releases/download/v${VERSION}/tkn_${VERSION}_Linux_x86_64.tar.gz \
    && tar -xvf tkn_${VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin tkn \
    && rm -rf tkn_${VERSION}_Linux_x86_64.tar.gz
ENTRYPOINT [ "/usr/local/bin/tkn" ]
CMD [ "--help" ]