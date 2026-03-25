ARG python_version

FROM python:${python_version}
# FROM python:3.14

LABEL maintainer="www.verystar.net"
ENV TZ Asia/Shanghai

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    procps \
    iputils-ping \
    curl \
    wget \
    # not found for python3.8 and python3.10
    # python-snappy \
    libsnappy-dev \
    zip \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

RUN pip install pipenv --no-cache-dir \
    && pip install --upgrade pip

COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r ./requirements.txt -i https://pypi.doubanio.com/simple
