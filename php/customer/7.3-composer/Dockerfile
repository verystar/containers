# 使用线上 PHP 镜像作为基础基础镜像
FROM verystar/php:7.3-fpm

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/tmp
ENV COMPOSER_VERSION=2.2.0

RUN useradd -u 65532 -m tekton
RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  tini \
  ssh-client

# https://github.com/composer/docker
RUN set -eux; \
  curl \
  --silent \
  --fail \
  --location \
  --retry 3 \
  --output /tmp/installer.php \
  --url https://raw.githubusercontent.com/composer/getcomposer.org/cb19f2aa3aeaa2006c0cd69a7ef011eb31463067/web/installer; \
  php -r " \
  \$signature = '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5'; \
  \$hash = hash('sha384', file_get_contents('/tmp/installer.php')); \
  if (!hash_equals(\$signature, \$hash)) { \
  unlink('/tmp/installer.php'); \
  echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
  exit(1); \
  }"; \
  php /tmp/installer.php \
  --no-ansi \
  --install-dir=/usr/bin \
  --filename=composer \
  --version=${COMPOSER_VERSION} \
  ; \
  composer --ansi --version --no-interaction; \
  rm -f /tmp/installer.php; \
  find /tmp -type d -exec chmod -v 1777 {} +

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["composer"]
