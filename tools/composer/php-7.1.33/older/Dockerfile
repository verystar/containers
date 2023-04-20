FROM php:7.1.33-alpine

RUN set -eux; \
  apk add --no-cache --virtual .composer-rundeps \
  bash \
  coreutils \
  git \
  make \
  mercurial \
  openssh-client \
  patch \
  subversion \
  tini \
  unzip \
  zip

RUN set -eux; \
  apk add --no-cache --virtual .build-deps \
  libzip-dev \
  zlib-dev \
  ; \
  docker-php-ext-install -j "$(nproc)" \
  zip \
  pdo_mysql \
  pcntl \
  ; \
  runDeps="$( \
  scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
  | tr ',' '\n' \
  | sort -u \
  | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
  )"; \
  apk add --no-cache --virtual .composer-phpext-rundeps $runDeps; \
  apk del .build-deps

# 安装 gd 扩展
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd

# 安装 Redis 扩展
RUN curl -fsSL https://pecl.php.net/get/redis-4.2.0.tgz -o redis-4.2.0.tgz \
  && mkdir -p /tmp/redis \
  && tar xf redis-4.2.0.tgz -C /tmp/redis --strip-components=1 \
  && rm -f redis-4.2.0.tgz \
  && docker-php-ext-configure /tmp/redis --enable-redis \
  && docker-php-ext-install /tmp/redis \
  && rm -rf /tmp/redis 

RUN printf "# composer php cli ini settings\n\
  date.timezone=UTC\n\
  memory_limit=-1\n\
  " > $PHP_INI_DIR/php-cli.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 1.9.1

RUN set -eux; \
  curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://raw.githubusercontent.com/composer/getcomposer.org/cb19f2aa3aeaa2006c0cd69a7ef011eb31463067/web/installer; \
  php -r " \
  \$signature = '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5'; \
  \$hash = hash('sha384', file_get_contents('/tmp/installer.php')); \
  if (!hash_equals(\$signature, \$hash)) { \
  unlink('/tmp/installer.php'); \
  echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
  exit(1); \
  }"; \
  php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION}; \
  composer --ansi --version --no-interaction; \
  rm -f /tmp/installer.php; \
  find /tmp -type d -exec chmod -v 1777 {} +

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]

CMD ["composer"]
