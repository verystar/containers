#!/bin/sh
set -e

if [ ! -z "${SESSION_SAVE_PATH}" ]; then
    echo "php_value[session.save_path] = \"${SESSION_SAVE_PATH}\"" >> /usr/local/etc/php-fpm.d/zz-docker.conf
    echo "session.save_handler = \"${SESSION_SAVE_PATH}\"" >> /usr/local/etc/php/php.ini
fi

# 设置上传文件大小
if [ -n "${UPLOAD_MAX_FILESIZE}" ]; then
    sed -i "s|UPLOAD_MAX_FILESIZE|${UPLOAD_MAX_FILESIZE}|g" /usr/local/etc/php-fpm.d/zz-docker.conf
else
    sed -i "s|UPLOAD_MAX_FILESIZE|2m|g" /usr/local/etc/php-fpm.d/zz-docker.conf
fi

# 替换环境变量
# starbucks 不知道有没有指定 app_env
if [ -n "${APP_ENV}" ]; then
    if [ -e /usr/share/nginx/html/public/index.php ]; then
        sed -i "s|define('ENVIRONMENT', 'develop');|define('ENVIRONMENT', '${APP_ENV}');|g" /usr/share/nginx/html/public/index.php
    fi
    if [ -e /usr/share/nginx/html/artisan ]; then
        sed -i "s|define('ENVIRONMENT', 'develop');|define('ENVIRONMENT', '${APP_ENV}');|g" /usr/share/nginx/html/artisan
    fi
fi

# 设置PHP执行时间
if [ -n "${MAX_EXECUTION_TIME}" ]; then
    sed -i "s|MAX_EXECUTION_TIME|${MAX_EXECUTION_TIME}|g" /usr/local/etc/php/php.ini
    sed -i "s|MAX_EXECUTION_TIME|${MAX_EXECUTION_TIME}|g" /usr/local/etc/php-fpm.d/zz-docker.conf
else
    sed -i "s|MAX_EXECUTION_TIME|10|g" /usr/local/etc/php/php.ini
    sed -i "s|MAX_EXECUTION_TIME|10|g" /usr/local/etc/php-fpm.d/zz-docker.conf
fi

# 设置子进程数量,默认50
if [ -n "${PM_MAX_CHILDREN}" ]; then
    sed -i "s|PM_MAX_CHILDREN|${PM_MAX_CHILDREN}|g" /usr/local/etc/php-fpm.d/zz-docker.conf
else
    sed -i "s|PM_MAX_CHILDREN|50|g" /usr/local/etc/php-fpm.d/zz-docker.conf
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
