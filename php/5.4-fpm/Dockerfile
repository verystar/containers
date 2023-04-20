ARG php_version
ARG mcrypt_version
ARG redis_version
ARG yaf_version
ARG libssh2_version
ARG ssh2_version

FROM php:${php_version}-fpm

ARG mcrypt_version
ARG redis_version
ARG yaf_version
ARG libssh2_version
ARG ssh2_version

LABEL maintainer="www.verystar.net"

# ENV REQUEST_TIMEOUT 10
ENV TZ Asia/Shanghai
ENV SESSION_SAVE_PATH "tcp://r-bp12479e0cae1bb4.redis.rds.aliyuncs.com:6379"

# RUN sed -i "s|deb.debian.org|mirrors.aliyun.com|g" /etc/apt/sources.list
# RUN sed -i "/security.debian.org/d" /etc/apt/sources.list
# RUN sed -i "s/httpredir.debian.org/mirrors.ustc.edu.cn/g" /etc/apt/sources.list

# Print Extension Version
RUN echo "redis version: ${redis_version}" \
    && echo "yaf version: ${yaf_version}" \
    && echo "libssh2 version: ${libssh2_version}" \
    && echo "ssh2 version: ${ssh2_version}" \
    && echo "mcrypt version: ${mcrypt_version}"

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
    && rm -r /var/lib/apt/lists/* \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

# PHP Core Extensions
RUN docker-php-ext-install mcrypt bcmath zip pdo_mysql mysqli xsl gettext pcntl sockets \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    # Install Ldap extension
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap

# bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase
# intl json ldap mbstring mcrypt mssql mysql mysqli oci8 odbc pcntl
# pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite
# pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard
# sybase_ct sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip

# PECL extensions
RUN pecl install https://pecl.php.net/get/redis-${redis_version}.tgz \
    && docker-php-ext-enable redis

RUN pecl install https://pecl.php.net/get/zendopcache-7.0.5.tgz \
    && docker-php-ext-enable opcache

RUN pecl install https://pecl.php.net/get/msgpack-0.5.7.tgz \
    && docker-php-ext-enable msgpack

# # Install libssh2 extension
RUN curl -fsSL https://libssh2.org/download/libssh2-${libssh2_version}.tar.gz -o libssh2-${libssh2_version}.tar.gz \
    && mkdir -p /tmp/libssh2 \
    && tar xf libssh2-${libssh2_version}.tar.gz -C /tmp/libssh2 --strip-components=1 \
    && rm -f libssh2-${libssh2_version}.tar.gz \
    && cd /tmp/libssh2 \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/libssh2

RUN sed -i -e "s/access.log/;access.log/g" /usr/local/etc/php-fpm.conf \
    && echo "" >> /usr/local/etc/php-fpm.conf \
    && echo "request_slowlog_timeout = 3" >> /usr/local/etc/php-fpm.conf \
    && echo "slowlog = /proc/self/fd/2" >> /usr/local/etc/php-fpm.conf \
    # 与执行时间相关
    && echo "request_terminate_timeout = MAX_EXECUTION_TIME" >> /usr/local/etc/php-fpm.conf \
    && echo "pm.max_requests = 5000" >> /usr/local/etc/php-fpm.conf \
    && echo "pm.max_children = PM_MAX_CHILDREN" >> /usr/local/etc/php-fpm.conf \
    && echo "pm.status_path = /fpm_status" >> /usr/local/etc/php-fpm.conf \
    && echo "ping.path = /fpm_ping" >> /usr/local/etc/php-fpm.conf \
    && echo "ping.response = pong" >> /usr/local/etc/php-fpm.conf \
    && echo "php_admin_value[memory_limit] = 128M" >> /usr/local/etc/php-fpm.conf \
    && echo "php_admin_value[error_log] = /proc/self/fd/2" >> /usr/local/etc/php-fpm.conf \
    && echo "php_admin_value[date.timezone] = ${TZ}" >> /usr/local/etc/php-fpm.conf \
    && echo "php_value[session.save_handler] = redis" >> /usr/local/etc/php-fpm.conf \
    # 设置上传文件大小
    && echo "php_admin_value[post_max_size] = UPLOAD_MAX_FILESIZE" >> /usr/local/etc/php-fpm.conf \
    && echo "php_admin_value[upload_max_filesize] = UPLOAD_MAX_FILESIZE" >> /usr/local/etc/php-fpm.conf \
    && echo "date.timezone = ${TZ}" >> /usr/local/etc/php/php.ini \
    && echo "expose_php = Off" >> /usr/local/etc/php/php.ini \
    && echo "display_errors = Off" >> /usr/local/etc/php/php.ini \
    && echo "log_errors = On" >> /usr/local/etc/php/php.ini \
    && echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /usr/local/etc/php/php.ini \
    && echo "error_log = /proc/self/fd/2" >> /usr/local/etc/php/php.ini \
    && echo "session.save_handler = redis" >> /usr/local/etc/php/php.ini \
    # 设置PHP最大执行时间
    && echo "max_execution_time = MAX_EXECUTION_TIME" >> /usr/local/etc/php/php.ini

COPY docker-php-entrypoint.sh /docker-php-entrypoint
ENTRYPOINT [ "/docker-php-entrypoint" ]
CMD [ "php-fpm" ]
