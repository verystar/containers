#!/bin/sh
set -e

# 设置上传文件大小
if [ -n "${UPLOAD_MAX_FILESIZE}" ]; then
    sed -i "s|UPLOAD_MAX_FILESIZE|${UPLOAD_MAX_FILESIZE}|g" /usr/local/etc/php-fpm.d/zz-docker.conf
else
    sed -i "s|UPLOAD_MAX_FILESIZE|2m|g" /usr/local/etc/php-fpm.d/zz-docker.conf
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