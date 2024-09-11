ARG python_version
ARG ansible_version

FROM python:${python_version}

ARG ansible_version
LABEL maintainer="www.verystar.net"
ENV TZ Asia/Shanghai

RUN pip install pipenv --no-cache-dir \
    && pip install --upgrade pip \
    && pip install ansible==${ansible_version}

RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone
