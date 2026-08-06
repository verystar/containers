variable "CURRENT_TIME" {
  default = "${formatdate("YYYYMMDDhhmmss", timeadd(timestamp(), "8h"))}"
}

target "common" {
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
}

function "major_minor" {
  params = [version]
  result = format("%s.%s", split(".", version)[0], split(".", version)[1])
}

function "tag" {
  params = [php_version, composer_version]
  result = [
    format("registry.verystar.net/library/php:%s-%s", replace("${php_version}", "-fpm", "-composer"), major_minor("${composer_version}")),
    format("registry.verystar.net/library/php:%s-%s", replace("${php_version}", "-fpm", "-composer"), "${composer_version}"),
    format("registry.verystar.net/library/php:%s-%s-%s", replace("${php_version}", "-fpm", "-composer"), "${composer_version}", "${CURRENT_TIME}"),
  ]
}

target "php71-composer2" {
  inherits = ["common"]
  context = "php/7.1-composer"
  args = {
    php_version = "7.1.33-fpm"
    composer_version = "2.2.0"
  }
  tags = tag("${target.php71-composer2.args.php_version}", "${target.php71-composer2.args.composer_version}")
}

target "php72-composer2" {
  inherits = ["common"]
  context = "php/7.2-composer"
  args = {
    php_version = "7.2.34-fpm"
    composer_version = "2.2.0"
  }
  tags = tag("${target.php72-composer2.args.php_version}", "${target.php72-composer2.args.composer_version}")
}

target "php73-composer2" {
  inherits = ["common"]
  context = "php/7.3-composer"
  args = {
    php_version = "7.3.33-fpm"
    composer_version = "2.2.0"
  }
  tags = tag("${target.php73-composer2.args.php_version}", "${target.php73-composer2.args.composer_version}")
}

target "php74-composer2" {
  inherits = ["common"]
  context = "php/7.4-composer"
  args = {
    php_version = "7.4.33-fpm"
    composer_version = "2.2.0"
  }
  tags = tag("${target.php74-composer2.args.php_version}", "${target.php74-composer2.args.composer_version}")
}

target "php80-composer2" {
  inherits = ["common"]
  context = "php/8.0-composer"
  args = {
    php_version = "8.0.30-fpm"
    composer_version = "2.8.5"
  }
  tags = tag("${target.php80-composer2.args.php_version}", "${target.php80-composer2.args.composer_version}")
}

target "php81-composer2" {
  inherits = ["common"]
  context = "php/8.1-composer"
  args = {
    php_version = "8.1.34-fpm"
    composer_version = "2.8.5"
  }
  tags = tag("${target.php81-composer2.args.php_version}", "${target.php81-composer2.args.composer_version}")
}

target "php82-composer2" {
  inherits = ["common"]
  context = "php/8.2-composer"
  args = {
    php_version = "8.2.33-fpm"
    composer_version = "2.8.5"
  }
  tags = tag("${target.php82-composer2.args.php_version}", "${target.php82-composer2.args.composer_version}")
}

target "php83-composer2" {
  inherits = ["common"]
  context = "php/8.3-composer"
  args = {
    php_version = "8.3.33-fpm"
    composer_version = "2.8.5"
  }
  tags = tag("${target.php83-composer2.args.php_version}", "${target.php83-composer2.args.composer_version}")
}

target "php84-composer2" {
  inherits = ["common"]
  context = "php/8.4-composer"
  args = {
    php_version = "8.4.24-fpm"
    composer_version = "2.8.5"
  }
  tags = tag("${target.php84-composer2.args.php_version}", "${target.php84-composer2.args.composer_version}")
}

target "php85-composer2" {
  inherits = ["common"]
  context = "php/8.5-composer"
  args = {
    php_version = "8.5.9-fpm"
    composer_version = "2.8.5"
  }
  tags = tag("${target.php85-composer2.args.php_version}", "${target.php85-composer2.args.composer_version}")
}
