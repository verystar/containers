ARG VERSION
ARG PNPM
ARG CNPM

FROM node:${VERSION}
ARG PNPM
ARG CNPM

LABEL maintainer="www.verystar.net"

ENV PNPM_DIR="${HOME}/.local/share/pnpm"
ENV PATH "$PNPM_DIR:$PATH"
ENV NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
    ELECTRON_MIRROR=https://npmmirror.com/mirrors/electron/ \
    ELECTRON_CUSTOM_DIR="{{ version }}" \
    ELECTRON_SKIP_BINARY_DOWNLOAD=1 \
    NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node \
    NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node \
    NODE_MIRROR=https://npmmirror.com/mirrors/node \
    PUPPETEER_DOWNLOAD_HOST=https://npmmirror.com/mirrors \
    SASS_BINARY_SITE=https://npmmirror.com/mirrors/node-sass \
    CHROMEDRIVER_CDNURL=https://npmmirror.com/mirrors/chromedriver \
    OPERADRIVER_CDNURL=https://npmmirror.com/mirrors/operadriver \
    PHANTOMJS_CDNURL=https://npmmirror.com/mirrors/phantomjs \
    SELENIUM_CDNURL=https://npmmirror.com/mirrors/selenium \
    NODE_INSPECTOR_CDNURL=https://npmmirror.com/mirrors/node-inspector

RUN npm install -g pnpm@${PNPM} cnpm@${CNPM} webpack-dev-server pm2 \
    && mkdir ~/.ssh \
    && chmod 700 ~/.ssh \
    && echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config

## For Tekton CI
RUN groupadd --gid 65532 tekton && \
    useradd --uid 65532 --gid tekton --home-dir /home/tekton --create-home --shell /bin/bash tekton