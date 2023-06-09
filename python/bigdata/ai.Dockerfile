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
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

WORKDIR /usr/share/nginx/html
# ADD https://verystar.oss-cn-hangzhou.aliyuncs.com/kirei_model/v1/weights/weights_KEJColorRegression_forMobile_FacePatch_lrmax_mobilenet_Max.pth ./weights/
# ADD https://verystar.oss-cn-hangzhou.aliyuncs.com/kirei_model/v1/weights/weights_KEJTextureRegression_forMobile_FacePatch_test_mobilenet_Max.pth ./weights/
# ADD https://verystar.oss-cn-hangzhou.aliyuncs.com/kirei_model/v1/weights/weights_MakeupHeavinessSkinAge_forMobile_FacePatch_test_mobilenet_Max.pth ./weights/
# ADD https://verystar.oss-cn-hangzhou.aliyuncs.com/kirei_model/v1/weights/weights_OtherFactorsRegression_forMobile_FacePatch_lrmax_mobilenet_Max.pth ./weights/
# ADD https://verystar.oss-cn-hangzhou.aliyuncs.com/kirei_model/v1/weights/weights_WrinkleNormGradeRegression_forMobile_FacePatch_mobilenet_Max.pth ./weights/

COPY ai.requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r ./requirements.txt -i https://pypi.doubanio.com/simple
COPY pip.conf /root/.pip/pip.conf
