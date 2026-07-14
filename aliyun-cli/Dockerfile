FROM verystar/debian:12

LABEL MAINTAINER="Xijun Dai <daixijun1990@gmail.com>"

ARG VERSION=3.4.6
ENV ALIBABA_CLOUD_CLI_PLUGIN_AUTO_INSTALL=true

RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends  ca-certificates curl \
    && curl -fsSL --retry 3 https://github.com/aliyun/aliyun-cli/releases/download/v${VERSION}/aliyun-cli-linux-${VERSION}-amd64.tgz -o /tmp/aliyun-cli.tgz \
    && tar xf /tmp/aliyun-cli.tgz -C /usr/local/bin/ \
    && rm -rf /tmp/aliyun-cli.tgz \
    && rm -fr /var/cache/apt/*

RUN aliyun plugin install --names ecs rds vpc slb bssopenapi cms tablestore sls cdn cloudfw sts ram nas kms ess cs cr || true

ENTRYPOINT [ "/usr/local/bin/aliyun" ]
CMD [ "--help" ]
