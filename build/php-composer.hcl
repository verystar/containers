variable "CURRENT_TIME" {
  default = "${formatdate("YYYYMMDDhhmmss", timeadd(timestamp(), "8h"))}"
}

target "common" {
  dockerfile = "Dockerfile"
}

target "php71-composer1" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.1-composer"
  args = {
    php_version = "7.1.33"
    composer_version = "1.9.1"
  }
  tags = [
    "registry.verystar.net/library/php:${target.php71-composer1.args.php_version}-composer-${target.php71-composer1.args.composer_version}",
    "registry.verystar.net/library/php:${target.php71-composer1.args.php_version}-composer-${target.php71-composer1.args.composer_version}-${CURRENT_TIME}",
  ]
}

target "php71-composer2" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.1-composer"
  args = {
    php_version = "7.1.33"
    composer_version = "2.2.0"
  }
  tags = [
    "registry.verystar.net/library/php:${target.php71-composer2.args.php_version}-composer-${target.php71-composer2.args.composer_version}",
    "registry.verystar.net/library/php:${target.php71-composer2.args.php_version}-composer-${target.php71-composer2.args.composer_version}-${CURRENT_TIME}",
  ]
}

target "php73-composer1" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.3-composer"
  args = {
    php_version = "7.3.33"
    composer_version = "1.9.1"
  }
  tags = [
    "registry.verystar.net/library/php:${target.php73-composer1.args.php_version}-composer-${target.php73-composer1.args.composer_version}",
    "registry.verystar.net/library/php:${target.php73-composer1.args.php_version}-composer-${target.php73-composer1.args.composer_version}-${CURRENT_TIME}",
  ]
}

target "php73-composer2" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.3-composer"
  args = {
    php_version = "7.3.33"
    composer_version = "2.2.0"
  }
  tags = [
    "registry.verystar.net/library/php:${target.php73-composer2.args.php_version}-composer-${target.php73-composer2.args.composer_version}",
    "registry.verystar.net/library/php:${target.php73-composer2.args.php_version}-composer-${target.php73-composer2.args.composer_version}-${CURRENT_TIME}",
  ]
}

target "php82-composer2" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/8.2-composer"
  args = {
    php_version = "8.2.22"
    composer_version = "2.8.5"
  }
  tags = [
    "registry.verystar.net/library/php:${target.php82-composer2.args.php_version}-composer-${target.php82-composer2.args.composer_version}",
    "registry.verystar.net/library/php:${target.php82-composer2.args.php_version}-composer-${target.php82-composer2.args.composer_version}-${CURRENT_TIME}",
  ]
}
