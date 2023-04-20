#!/bin/sh

isCommand() {
  # Retain backwards compatibility with common CI providers,
  # see: https://github.com/composer/docker/issues/107
  if [ "$1" = "sh" ]; then
    return 1
  fi

  composer help "$1" > /dev/null 2>&1
}

# check if the first argument passed in looks like a flag
if [ "${1#-}" != "$1" ]; then
  set -- /usr/bin/tini -- composer "$@"
# check if the first argument passed in is composer
elif [ "$1" = 'composer' ]; then
  set -- /usr/bin/tini -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /usr/bin/tini -- composer "$@"
fi

exec "$@"
