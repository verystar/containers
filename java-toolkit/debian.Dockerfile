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

RUN apt update ; \
    apt install -y --no-install-recommends unzip \
    && rm -rf /var/lib/apt/lists/* \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

# maven
RUN curl -sk -o /tmp/apache-maven-${maven_version}-bin.tar.gz https://dlcdn.apache.org/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz \
    && tar -xf /tmp/apache-maven-${maven_version}-bin.tar.gz -C /usr/local \
    && rm /tmp/apache-maven-${maven_version}-bin.tar.gz
COPY settings.xml /usr/local/apache-maven-${maven_version}/conf/settings.xml

# gradle
RUN curl -sk -o /tmp/gradle-${gradle_version}-bin.zip https://downloads.gradle-dn.com/distributions/gradle-${gradle_version}-bin.zip \
    && unzip /tmp/gradle-${gradle_version}-bin.zip -d /usr/local \
    && rm /tmp/gradle-${gradle_version}-bin.zip
