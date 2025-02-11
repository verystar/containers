FROM php:8.2.22-fpm

LABEL org.opencontainers.image.authors="www.verystar.net"

# ENV REQUEST_TIMEOUT 10
ENV TZ=Asia/Shanghai
ENV REDIS_VERSION=6.0.2
ENV YAF_VERSION=3.3.6
ENV MCRYPT_VERSION=1.0.5
ENV LIBSSH2_VERSION=1.11.0
ENV SSH2_VERSION=1.4.1

# Print Extension Version
RUN echo "redis version: ${REDIS_VERSION}" \
    && echo "yaf version: ${YAF_VERSION}" \
    && echo "libssh2 version: ${LIBSSH2_VERSION}" \
    && echo "ssh2 version: ${SSH2_VERSION}" \
    && echo "mcrypt version: ${MCRYPT_VERSION}"

COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    libaio-dev \
    git \
    unzip \
    libssl-dev \
    libzip-dev \
    libldap2-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxslt1-dev \
    libmcrypt-dev \
    libevent-dev \
    && rm -r /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

RUN docker-php-ext-install bcmath zip pdo_mysql mysqli opcache xsl gettext pcntl \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install gd \
    # Install Ldap extension
    && docker-php-ext-configure ldap --with-libdir=lib/$(uname -m)-linux-gnu/ \
    && docker-php-ext-install ldap

# Install Redis extension
RUN curl -fsSL https://pecl.php.net/get/redis-${REDIS_VERSION}.tgz -o redis-${REDIS_VERSION}.tgz \
    && mkdir -p /tmp/redis \
    && tar xf redis-${REDIS_VERSION}.tgz -C /tmp/redis --strip-components=1 \
    && rm -f redis-${REDIS_VERSION}.tgz \
    && docker-php-ext-configure /tmp/redis --enable-redis \
    && docker-php-ext-install /tmp/redis \
    && rm -rf /tmp/redis

# Install yaf extension
RUN curl -fsSL https://pecl.php.net/get/yaf-${YAF_VERSION}.tgz -o yaf-${YAF_VERSION}.tgz \
    && mkdir -p /tmp/yaf \
    && tar xf yaf-${YAF_VERSION}.tgz -C /tmp/yaf --strip-components=1 \
    && rm -f yaf-${YAF_VERSION}.tgz \
    && docker-php-ext-configure /tmp/yaf \
    && docker-php-ext-install /tmp/yaf \
    && rm -rf /tmp/yaf

# Install mcrypt extension
RUN curl -fsSL https://pecl.php.net/get/mcrypt-${MCRYPT_VERSION}.tgz -o mcrypt-${MCRYPT_VERSION}.tgz \
    && mkdir -p /tmp/mcrypt \
    && tar xf mcrypt-${MCRYPT_VERSION}.tgz -C /tmp/mcrypt --strip-components=1 \
    && rm -f mcrypt-${MCRYPT_VERSION}.tgz \
    && docker-php-ext-configure /tmp/mcrypt \
    && docker-php-ext-install /tmp/mcrypt \
    && rm -rf /tmp/mcrypt

# Install libssh2 extension
RUN curl -fsSL https://libssh2.org/download/libssh2-${LIBSSH2_VERSION}.tar.gz -o libssh2-${LIBSSH2_VERSION}.tar.gz \
    && mkdir -p /tmp/libssh2 \
    && tar xf libssh2-${LIBSSH2_VERSION}.tar.gz -C /tmp/libssh2 --strip-components=1 \
    && rm -f libssh2-${LIBSSH2_VERSION}.tar.gz \
    && cd /tmp/libssh2 \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/libssh2

# Install ssh2 extension
RUN curl -fsSL https://pecl.php.net/get/ssh2-${SSH2_VERSION}.tgz -o ssh2-${SSH2_VERSION}.tgz \
    && mkdir -p /tmp/ssh2 \
    && tar xf ssh2-${SSH2_VERSION}.tgz -C /tmp/ssh2 --strip-components=1 \
    && rm -f ssh2-${SSH2_VERSION}.tgz \
    && docker-php-ext-configure /tmp/ssh2 --with-ssh2 \
    && docker-php-ext-install /tmp/ssh2 \
    && rm -rf /tmp/ssh2

# Install nsq extension
RUN curl -fsSL https://pecl.php.net/get/nsq-3.5.1.tgz -o nsq-3.5.1.tgz \
&& mkdir -p /tmp/nsq \
&& tar xf nsq-3.5.1.tgz -C /tmp/nsq --strip-components=1 \
&& rm -f nsq-3.5.1.tgz \
&& docker-php-ext-configure /tmp/nsq --with-libevent-path=/usr \
&& docker-php-ext-install /tmp/nsq \
&& rm -rf /tmp/nsq

RUN sed -i -e "s/access.log/;access.log/g" /usr/local/etc/php-fpm.d/docker.conf \
    && echo "request_slowlog_timeout = 3" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "slowlog = /proc/self/fd/2" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    # 与执行时间相关
    && echo "request_terminate_timeout = MAX_EXECUTION_TIME" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "pm.max_requests = 5000" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "pm.max_children = PM_MAX_CHILDREN" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "pm.status_path = /fpm_status" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "ping.path = /fpm_ping" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "ping.response = pong" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_admin_value[memory_limit] = 128M" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_admin_value[error_log] = /proc/self/fd/2" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_admin_value[date.timezone] = ${TZ}" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_value[session.save_handler] = redis" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    # 设置上传文件大小
    && echo "php_admin_value[post_max_size] = UPLOAD_MAX_FILESIZE" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "php_admin_value[upload_max_filesize] = UPLOAD_MAX_FILESIZE" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo "date.timezone = ${TZ}" >> /usr/local/etc/php/php.ini \
    && echo "expose_php = Off" >> /usr/local/etc/php/php.ini \
    && echo "display_errors = Off" >> /usr/local/etc/php/php.ini \
    && echo "log_errors = On" >> /usr/local/etc/php/php.ini \
    && echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /usr/local/etc/php/php.ini \
    && echo "error_log = /proc/self/fd/2" >> /usr/local/etc/php/php.ini \
    && echo "session.save_handler = redis" >> /usr/local/etc/php/php.ini \
    # 设置PHP最大执行时间
    && echo "max_execution_time = MAX_EXECUTION_TIME" >> /usr/local/etc/php/php.ini

# 修改 LDAP TLS 问题
RUN mkdir /etc/ldap && echo "TLS_REQUEST never" >> /etc/ldap/ldap.con

COPY docker-php-entrypoint.sh /docker-php-entrypoint
ENTRYPOINT [ "/docker-php-entrypoint" ]
CMD [ "php-fpm" ]