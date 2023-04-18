#!/bin/sh
# set -eo pipefail
# shopt -s nullglob

if [ -n "${SERVER_NAME}" ]; then
    sed -i "s|server_name localhost|server_name $SERVER_NAME|g" /etc/nginx/conf.d/default.conf
fi

if [ -n "${ROOT_DIR}" ]; then
    sed -i "s|root   /usr/share/nginx/html|root   ${ROOT_DIR}|g" /etc/nginx/conf.d/default.conf
fi

if [ -n "${PROXY_HOST}" ]; then
    sed -i "s|127.0.0.1|${PROXY_HOST}|g" /etc/nginx/conf.d/default.conf
fi

if [ -n "${PROXY_PORT}" ]; then
    sed -i "s|8080|${PROXY_PORT}|g" /etc/nginx/conf.d/default.conf
fi

# 设置超时时间, 主要与PHP的执行时间有关
if [ -n "${NGINX_TIMEOUT}" ]; then
    sed -i "s|NGINX_TIMEOUT|${NGINX_TIMEOUT}|g" /etc/nginx/nginx.conf
else
    sed -i "s|NGINX_TIMEOUT|10|g" /etc/nginx/nginx.conf
fi

# 设置上传文件大小
if [ -n "${CLIENT_MAX_BODY_SIZE}" ]; then
    sed -i "s|CLIENT_MAX_BODY_SIZE|${CLIENT_MAX_BODY_SIZE}|g" /etc/nginx/nginx.conf
else
    sed -i "s|CLIENT_MAX_BODY_SIZE|10m|g" /etc/nginx/nginx.conf
fi

# 设置index文件
if [ -n "${INDEX_FILE}" ]; then
    sed -i "s|__INDEX_FILE__|${INDEX_FILE}|g" /etc/nginx/conf.d/default.conf
else
    sed -i "s|__INDEX_FILE__|/index.html|g" /etc/nginx/conf.d/default.conf
fi

exec "$@"
