ARG openjdk_version
ARG maven_version
ARG gradle_version

FROM amazoncorretto:${openjdk_version}

ARG maven_version
ARG gradle_version
LABEL maintainer="www.verystar.net"
ENV TZ Asia/Shanghai

ENV MAVEN_DIR="/usr/local/apache-maven-${maven_version}"
ENV GRADLE_DIR="/usr/local/gradle-${gradle_version}"
ENV PATH "$MAVEN_DIR/bin:$GRADLE_DIR/bin:$PATH"

RUN yum update ; \
    yum install -y --setopt=skip_missing_names_on_install=False unzip tar gzip shadow-utils \
    && rm -rf /var/cache/yum \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

# maven
# 使用 archive.apache.org 而非 dlcdn.apache.org：dlcdn 仅保留最新版本，旧版本（如 3.8.8）会返回 404
RUN curl -skL -o /tmp/apache-maven-${maven_version}-bin.tar.gz https://archive.apache.org/dist/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz \
    && tar -xf /tmp/apache-maven-${maven_version}-bin.tar.gz -C /usr/local \
    && rm /tmp/apache-maven-${maven_version}-bin.tar.gz
COPY settings.xml /usr/local/apache-maven-${maven_version}/conf/settings.xml

# gradle
# 使用 services.gradle.org 而非 downloads.gradle-dn.com：避免第三方镜像不稳定，改用官方稳定源
RUN curl -skL -o /tmp/gradle-${gradle_version}-bin.zip https://services.gradle.org/distributions/gradle-${gradle_version}-bin.zip \
    && unzip /tmp/gradle-${gradle_version}-bin.zip -d /usr/local \
    && rm /tmp/gradle-${gradle_version}-bin.zip

## For Tekton CI
RUN groupadd --gid 65532 tekton && \
    useradd --uid 65532 --gid tekton --home-dir /home/tekton --create-home --shell /bin/bash tekton