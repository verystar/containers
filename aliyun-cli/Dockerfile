FROM verystar/debian:12

LABEL MAINTAINER="Xijun Dai <daixijun1990@gmail.com>"

ARG VERSION
ENV FILENAME=aliyun-cli-linux-amd64.tar.gz

RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends  ca-certificates curl \
    && curl --silent -L https://github.com/aliyun/aliyun-cli/releases/download/v${VERSION}/aliyun-cli-linux-${VERSION}-amd64.tgz -o /tmp/aliyun-cli.tgz \
    && tar xf /tmp/aliyun-cli.tgz -C /usr/local/bin/ \
    && rm -rf /tmp/aliyun-cli.tgz \
    && rm -fr /var/cache/apt/*

ENTRYPOINT [ "/usr/local/bin/aliyun" ]
CMD [ "--help" ]