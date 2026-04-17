ARG python_version

FROM python:${python_version}
# FROM python:3.14

LABEL maintainer="www.verystar.net"
ENV TZ Asia/Shanghai

# System
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    procps \
    iputils-ping \
    curl \
    wget \
    jq \
    ripgrep \
    fd-find \
    # not found for python3.8 and python3.10
    # python-snappy \
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
    && rm -rf /var/lib/apt/lists/*

# YAML
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq \
    && chmod +x /usr/bin/yq

# Node
RUN npm install -g pptxgenjs typescript

# Python
RUN pip install pipenv --no-cache-dir \
    && pip install --upgrade pip

COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r ./requirements.txt -i https://pypi.doubanio.com/simple
