ARG VERSION
ARG JMX_PROMETHEUS_JAVAAGENT_VERSION

FROM openjdk:${VERSION}
ARG JMX_PROMETHEUS_JAVAAGENT_VERSION

LABEL maintainer="www.verystar.net"
RUN apt update && \
    apt upgrade -y && \
    apt install -y wget && \
    mkdir -p /prometheus-jmx-exporter && \
    wget -O /prometheus-jmx-exporter/jmx_prometheus_javaagent.jar https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_PROMETHEUS_JAVAAGENT_VERSION}/jmx_prometheus_javaagent-${JMX_PROMETHEUS_JAVAAGENT_VERSION}.jar && \
    rm -rf /var/cache/apt/*