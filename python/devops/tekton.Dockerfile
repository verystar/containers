ARG python_version

FROM python:${python_version}

LABEL maintainer="www.verystar.net"
ENV TZ Asia/Shanghai

RUN pip install pipenv --no-cache-dir \
    && pip install --upgrade pip
RUN apt-get update && apt-get install -y --no-install-recommends \
    # not found for python3.8 and python3.10
    # python-snappy \
    libsnappy-dev \
    zip \
    && rm -r /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone
RUN groupadd --gid 65532 tekton && \
    useradd --uid 65532 --gid tekton --home-dir /home/tekton --create-home --shell /bin/bash tekton
USER tekton