#!/bin/sh
set -e

if [ ! -z "${SESSION_SAVE_PATH}" ]; then
    echo "php_value[session.save_path] = \"${SESSION_SAVE_PATH}\"" >> /usr/local/etc/php-fpm.d/zz-docker.conf
    echo "session.save_handler = \"${SESSION_SAVE_PATH}\"" >> /usr/local/etc/php/php.ini
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"