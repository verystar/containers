ARG VERSION
ARG JMX_PROMETHEUS_JAVAAGENT_VERSION

FROM openjdk:${VERSION}
ARG JMX_PROMETHEUS_JAVAAGENT_VERSION

LABEL maintainer="www.verystar.net"
RUN mkdir -p /prometheus-jmx-exporter && \
    curl --silent --show-error --location --output /prometheus-jmx-exporter/jmx_prometheus_javaagent.jar https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_PROMETHEUS_JAVAAGENT_VERSION}/jmx_prometheus_javaagent-${JMX_PROMETHEUS_JAVAAGENT_VERSION}.jar
COPY config.yaml /prometheus-jmx-exporter/config.yaml