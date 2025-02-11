ARG php_version
ARG composer_version

# 使用线上 PHP 镜像作为基础基础镜像
FROM registry.verystar.net/library/php:${php_version:-8.2}-fpm
ARG composer_version

LABEL org.opencontainers.image.url=https://www.verystar.net/
LABEL org.opencontainers.image.version=${composer_version}
LABEL org.opencontainers.image.authors="www.verystar.net"
LABEL org.opencontainers.image.description="PHP Composer"
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/tmp
ENV COMPOSER_VERSION=${composer_version}

RUN useradd -u 65532 -m tekton
RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  tini \
  openssh-client \
  && rm -rf /var/lib/apt/lists/*

# https://github.com/composer/docker
RUN set -eux; \
  curl \
  --silent \
  --fail \
  --location \
  --retry 3 \
  --output /tmp/installer.php \
  --url https://raw.githubusercontent.com/composer/getcomposer.org/f24b8f860b95b52167f91bbd3e3a7bcafe043038/web/installer \
  ; \
  echo 3137ad86bd990524ba1dedc2038309dfa6b63790d3ca52c28afea65dcc2eaead16fb33e9a72fd2a7a8240afaf26e065939a2d472f3b0eeaa575d1e8648f9bf19 /tmp/installer.php | sha512sum --strict --check ; \
  # install composer phar binary
  php /tmp/installer.php \
  --no-ansi \
  --install-dir=/usr/bin \
  --filename=composer \
  --version=${composer_version} \
  ; \
  composer --ansi --version --no-interaction; \
  composer diagnose; \
  rm -f /tmp/installer.php; \
  find /tmp -type d -exec chmod -v 1777 {} +

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["composer"]
