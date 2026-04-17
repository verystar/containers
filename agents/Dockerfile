ARG python_version
ARG requirements_file=requirements-latest.txt

FROM python:${python_version:-3.10}
ARG requirements_file

LABEL maintainer="www.verystar.net"
ENV TZ=Asia/Shanghai

# 系统依赖安装
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    procps \
    iputils-ping \
    curl \
    wget \
    jq \
    ripgrep \
    fd-find \
    libsnappy-dev \
    zip \
    libreoffice \
    poppler-utils \
    python3-docx \
    nodejs \
    npm \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && ln -sf /usr/bin/fdfind /usr/bin/fd \
    && echo "${TZ}" > /etc/timezone \
    # 安装 yq YAML 处理工具
    && wget -q https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    # 安装 Node.js 全局包
    && npm install -g pptxgenjs typescript \
    && npm cache clean --force \
    # 升级 pip 并安装 Python 依赖
    && pip install --upgrade pip \
    # 清理缓存和临时文件
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cache /root/.npm

# 安装 Python 依赖
COPY ${requirements_file} ./requirements.txt
RUN pip install --no-cache-dir -r ./requirements.txt -i https://pypi.doubanio.com/simple \
    && rm ./requirements.txt
