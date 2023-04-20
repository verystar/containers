
FROM php:7.1.11-fpm

ENV REQUEST_TIMEOUT 10
ENV TZ Asia/Shanghai
ENV SESSION_SAVE_PATH "tcp://r-bp12479e0cae1bb4.redis.rds.aliyuncs.com:6379"

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    libaio-dev \
    git \
    libfreetype6-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxslt1-dev \
    libmcrypt-dev \
    && rm -r /var/lib/apt/lists/* \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone 
RUN docker-php-ext-install bcmath zip pdo_mysql mysqli opcache xsl gettext ldap mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    # && pecl install redis \
    # && pecl install yaf \
    # && docker-php-ext-enable redis yaf \
    ## Install Redis extension
    && curl -fsSL https://pecl.php.net/get/redis-4.2.0.tgz -o redis-4.2.0.tgz \
    && mkdir -p /tmp/redis \
    && tar xf redis-4.2.0.tgz -C /tmp/redis --strip-components=1 \
    && rm -f redis-4.2.0.tgz \
    && docker-php-ext-configure /tmp/redis --enable-redis \
    && docker-php-ext-install /tmp/redis \
    && rm -rf /tmp/redis \
    ## Install yaf extension
    && curl -fsSL https://pecl.php.net/get/yaf-3.0.7.tgz -o yaf-3.0.7.tgz \
    && mkdir -p /tmp/yaf \
    && tar xf yaf-3.0.7.tgz -C /tmp/yaf --strip-components=1 \
    && rm -f yaf-3.0.7.tgz \
    && docker-php-ext-configure /tmp/yaf \
    && docker-php-ext-install /tmp/yaf \
    && rm -rf /tmp/yaf \
    ## Install mcrypt extension
    && curl -fsSL https://pecl.php.net/get/mcrypt-1.0.1.tgz -o mcrypt-1.0.1.tgz \
    && mkdir -p /tmp/mcrypt \
    && tar xf mcrypt-1.0.1.tgz -C /tmp/mcrypt --strip-components=1 \
    && rm -f mcrypt-1.0.1.tgz \
    && docker-php-ext-configure /tmp/mcrypt \
    && docker-php-ext-install /tmp/mcrypt \
    && rm -rf /tmp/mcrypt

RUN sed -i -e "s/access.log/;access.log/g" /usr/local/etc/php-fpm.d/docker.conf \
    && echo "request_slowlog_timeout = 3" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "slowlog = /proc/self/fd/2" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "request_terminate_timeout = ${REQUEST_TIMEOUT}" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "pm.max_requests = 5000" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "pm.status_path = /fpm_status" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "ping.path = /fpm_ping" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "ping.response = pong" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_admin_value[memory_limit] = 128M" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_admin_value[error_log] = /proc/self/fd/2" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_admin_value[date.timezone] = ${TZ}" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_value[session.save_handler] = redis" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "date.timezone = ${TZ}" >> /usr/local/etc/php/php.ini \
    && echo "expose_php = Off" >> /usr/local/etc/php/php.ini \
    && echo "display_errors = Off" >> /usr/local/etc/php/php.ini \
    && echo "log_errors = On" >> /usr/local/etc/php/php.ini \
    && echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /usr/local/etc/php/php.ini \
    && echo "error_log = /proc/self/fd/2" >> /usr/local/etc/php/php.ini \
    && echo "session.save_handler = redis" >> /usr/local/etc/php/php.ini

COPY docker-php-entrypoint.sh /docker-php-entrypoint
ENTRYPOINT [ "/docker-php-entrypoint" ]
CMD [ "php-fpm" ]