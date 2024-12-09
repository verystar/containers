ARG python_version

FROM python:${python_version}

LABEL maintainer="www.verystar.net"
ENV TZ Asia/Shanghai

RUN pip install pipenv --no-cache-dir \
    && pip install --upgrade pip
RUN apt-get update && apt-get install -y --no-install-recommends \
    # not found for python3.8 and python3.10
    # python-snappy \
    libopencv-dev \
    libsnappy-dev \
    zip \
    && wget -O /tmp/wkhtmltopdf_0.12.6-2+b1_amd64.deb http://ftp.us.debian.org/debian/pool/main/w/wkhtmltopdf/wkhtmltopdf_0.12.6-2+b1_amd64.deb \
    && apt-get install /tmp/wkhtmltopdf_0.12.6-2+b1_amd64.deb  -y --no-install-recommends \
    && rm /tmp/wkhtmltopdf_0.12.6-2+b1_amd64.deb \
    && rm -r /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone
