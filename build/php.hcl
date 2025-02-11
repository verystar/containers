variable "CURRENT_TIME" {
  default = "${formatdate("YYYYMMDDhhmmss", timeadd(timestamp(), "8h"))}"
}

target "common" {
  dockerfile = "Dockerfile"
}

function "tag" {
  params = [php_version]
  result = [
    format("registry.verystar.net/library/php:%s", "${php_version}"),
    format("registry.verystar.net/library/php:%s-%s", "${php_version}", "${CURRENT_TIME}"),
  ]
}

target "php7-1" {
  context = "php/7.1-fpm"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    php_version = "7.1.33-fpm"
    redis_version = "4.2.0"
    yaf_version = "3.0.7"
    libssh2_version = "1.9.0"
    ssh2_version = "1.2"
  }
  tags = concat(
    ["registry.verystar.net/library/php:7.1-fpm"],
    tag("${target.php7-1.args.php_version}"),
  )
}


target "php7-3" {
  context = "php/7.3-fpm"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    php_version = "7.3.33-fpm"
    redis_version = "5.3.7"
    yaf_version = "3.3.5"
    mcrypt_version = "1.0.5"
    libssh2_version = "1.10.0"
    ssh2_version = "1.3.1"
  }
  tags = concat(
    ["registry.verystar.net/library/php:7.3-fpm"],
    tag("${target.php7-3.args.php_version}"),
  )
}

target "php7-4" {
  context = "php/7.4-fpm"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    php_version = "7.4.33"
    redis_version = "5.3.7"
    yaf_version = "3.3.5"
    mcrypt_version = "1.0.6"
    libssh2_version = "1.11.0"
    ssh2_version = "1.4"
  }
  tags = concat(
    ["registry.verystar.net/library/php:7.4-fpm"],
    tag("${target.php7-4.args.php_version}"),
  )
}

target "php8-2" {
  context = "php/8.2-fpm"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    php_version = "8.2.22-fpm"
    redis_version = "6.0.2"
    yaf_version = "3.3.6"
    mcrypt_version = "1.0.5"
    libssh2_version = "1.11.0"
    ssh2_version = "1.4.1"
  }
  tags = concat(
    ["registry.verystar.net/library/php:8.2-fpm"],
    tag("${target.php8-2.args.php_version}"),
  )
}