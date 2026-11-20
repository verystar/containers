ARG php_version
ARG mcrypt_version
# phpredis develop 中已适配 PHP 8.6 的 commit,单独 docker build 时也有可用默认值
ARG redis_commit=a6ce1e60b3e81ce3b25174aa5aaefd5590dc64fd
ARG redis_sha256=79288312706263ad0744391752fd9a62273d5a73c4e6e6a42ff2819e76363533
ARG yaf_version
ARG libssh2_version
ARG ssh2_version

FROM php:${php_version:-"8.6-fpm"}

ARG mcrypt_version
ARG redis_commit
ARG redis_sha256
ARG yaf_version
ARG libssh2_version
ARG ssh2_version

LABEL org.opencontainers.image.authors="www.verystar.net"

# ENV REQUEST_TIMEOUT 10
ENV TZ=Asia/Shanghai
ENV SESSION_SAVE_PATH="tcp://r-bp12479e0cae1bb4.redis.rds.aliyuncs.com:6379"

# Print Extension Version
RUN echo "redis commit: ${redis_commit}" \
    && echo "yaf version: ${yaf_version}" \
    && echo "mcrypt version: ${mcrypt_version}" \
    && echo "libssh2 version: ${libssh2_version}" \
    && echo "ssh2 version: ${ssh2_version}"

# COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    libaio-dev \
    git \
    unzip \
    patch \
    libssl-dev \
    libzip-dev \
    libldap2-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libxslt1-dev \
    libmcrypt-dev \
    libevent-dev \
    && rm -r /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

# opcache 自 PHP 8.5 起已内置,且 8.6 官方镜像改为 ZTS(opcache 同样内置),
# docker-php-ext-install opcache 会失败(exit=2),故不显式安装;
# 8.6 官方镜像已不带 --enable-mbstring,须显式安装(依赖 libonig-dev)
RUN docker-php-ext-install bcmath zip pdo_mysql mysqli xsl gettext pcntl mbstring \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install gd \
    # Install Ldap extension
    && docker-php-ext-configure ldap --with-libdir=lib/$(uname -m)-linux-gnu/ \
    && docker-php-ext-install ldap

# Install Redis extension
# 使用 phpredis develop 的 8.6 兼容 commit(6.3.0 仍调用 PHP 8.6 已移除的 zval_dtor/ZEND_WRONG_PARAM_COUNT,
# 上游尚未发版);升到发版后改回 https://pecl.php.net/get/redis-${redis_version}.tgz
RUN curl -fsSL --retry 3 https://github.com/phpredis/phpredis/archive/${redis_commit}.tar.gz -o redis.tar.gz \
    && echo "${redis_sha256}  redis.tar.gz" | sha256sum -c - \
    && mkdir -p /tmp/redis \
    && tar xf redis.tar.gz -C /tmp/redis --strip-components=1 \
    && rm -f redis.tar.gz \
    && docker-php-ext-configure /tmp/redis --enable-redis \
    && docker-php-ext-install /tmp/redis \
    && rm -rf /tmp/redis

# Install yaf extension
# yaf 3.3.8 仍使用 PHP 8.6 已移除的 API(zval_dtor、zend_parse_parameters_throw、
# ZVAL_IS_NULL)且未适配 zend_fcall_info 新增的 consumed_args,通过 yaf-8.6.patch
# 就地修复;待 yaf 发版支持 8.6 后删除补丁并改用原版源码
COPY yaf-8.6.patch /tmp/yaf-8.6.patch
RUN curl -fsSL --retry 3 https://pecl.php.net/get/yaf-${yaf_version}.tgz -o yaf-${yaf_version}.tgz \
    && mkdir -p /tmp/yaf \
    && tar xf yaf-${yaf_version}.tgz -C /tmp/yaf --strip-components=1 \
    && rm -f yaf-${yaf_version}.tgz \
    && cd /tmp/yaf \
    && patch -p1 --fuzz=0 --forward < /tmp/yaf-8.6.patch \
    && rm -f /tmp/yaf-8.6.patch \
    && ! grep -rq -E 'zval_dtor\(|zend_parse_parameters_throw|ZVAL_IS_NULL' /tmp/yaf \
    && docker-php-ext-configure /tmp/yaf \
    && docker-php-ext-install /tmp/yaf \
    && rm -rf /tmp/yaf

# Install mcrypt extension
# mcrypt 1.0.9 尚未适配 PHP 8.6 的 stream filter API(php_stream_filter_ops 新增 seek、
# INI_STR 移除、filter 工厂参数改为 bool、filter_alloc 增加 seek 参数),
# 通过 mcrypt-8.6.patch 修复;过滤器按 PSFS_SEEKABLE_NEVER 注册,
# 因此 rewind() 不可用(与 8.5 行为不同);待 mcrypt 发版支持 8.6 后删除补丁
COPY mcrypt-8.6.patch /tmp/mcrypt-8.6.patch
RUN curl -fsSL --retry 3 https://pecl.php.net/get/mcrypt-${mcrypt_version}.tgz -o mcrypt-${mcrypt_version}.tgz \
    && mkdir -p /tmp/mcrypt \
    && tar xf mcrypt-${mcrypt_version}.tgz -C /tmp/mcrypt --strip-components=1 \
    && rm -f mcrypt-${mcrypt_version}.tgz \
    && cd /tmp/mcrypt \
    && patch -p1 --fuzz=0 --forward < /tmp/mcrypt-8.6.patch \
    && rm -f /tmp/mcrypt-8.6.patch \
    && grep -q 'zend_ini_string_literal' /tmp/mcrypt/mcrypt_filter.c \
    && docker-php-ext-configure /tmp/mcrypt \
    && docker-php-ext-install /tmp/mcrypt \
    && rm -rf /tmp/mcrypt

# Install libssh2 extension
RUN curl -fsSL --retry 3 https://libssh2.org/download/libssh2-${libssh2_version}.tar.gz -o libssh2-${libssh2_version}.tar.gz \
    && mkdir -p /tmp/libssh2 \
    && tar xf libssh2-${libssh2_version}.tar.gz -C /tmp/libssh2 --strip-components=1 \
    && rm -f libssh2-${libssh2_version}.tar.gz \
    && cd /tmp/libssh2 \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/libssh2

# Install ssh2 extension
RUN curl -fsSL --retry 3 https://pecl.php.net/get/ssh2-${ssh2_version}.tgz -o ssh2-${ssh2_version}.tgz \
    && mkdir -p /tmp/ssh2 \
    && tar xf ssh2-${ssh2_version}.tgz -C /tmp/ssh2 --strip-components=1 \
    && rm -f ssh2-${ssh2_version}.tgz \
    && docker-php-ext-configure /tmp/ssh2 --with-ssh2 \
    && docker-php-ext-install /tmp/ssh2 \
    && rm -rf /tmp/ssh2

# Install nsq extension
# PHP 8.6 仍不提供 php_smart_string_public.h,nsq 扩展暂不可用,待官方适配后恢复
# RUN curl -fsSL --retry 3 https://pecl.php.net/get/nsq-3.9.1.tgz -o nsq-3.9.1.tgz \
#     && mkdir -p /tmp/nsq \
#     && tar xf nsq-3.9.1.tgz -C /tmp/nsq --strip-components=1 \
#     && rm -f nsq-3.9.1.tgz \
#     && docker-php-ext-configure /tmp/nsq --with-libevent-path=/usr \
#     && docker-php-ext-install /tmp/nsq \
#     && rm -rf /tmp/nsq

RUN sed -i -e "s/access.log/;access.log/g" /usr/local/etc/php-fpm.d/docker.conf \
    # PHP 8.6 起官方 zz-docker.conf 不再包含兼容用的 [www] 段,需自行补上再追加 pool 配置
    && echo "[www]" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
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
    # CVE-2026-115560:禁用会话上传进度
    && echo "session.upload_progress.enabled = 0" >> /usr/local/etc/php/php.ini \
    # 设置PHP最大执行时间
    && echo "max_execution_time = MAX_EXECUTION_TIME" >> /usr/local/etc/php/php.ini

COPY docker-php-entrypoint.sh /docker-php-entrypoint
ENTRYPOINT [ "/docker-php-entrypoint" ]
CMD [ "php-fpm" ]