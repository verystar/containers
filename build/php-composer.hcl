variable "CURRENT_TIME" {
  default = "${formatdate("YYYYMMDDhhmmss", timeadd(timestamp(), "8h"))}"
}

target "common" {
  dockerfile = "Dockerfile"
}

function "tag" {
  params = [php_version, composer_version]
  result = [
    format("registry.verystar.net/library/php:%s-%s", replace("${php_version}", "-fpm", "-composer"), "${composer_version}"),
    format("registry.verystar.net/library/php:%s-%s-%s", replace("${php_version}", "-fpm", "-composer"), "${composer_version}", "${CURRENT_TIME}"),
  ]
}

target "php71-composer1" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.1-composer"
  args = {
    php_version = "7.1.33-fpm"
    composer_version = "1.9.1"
  }
  tags = tag("${target.php71-composer1.args.php_version}", "${target.php71-composer1.args.composer_version}")
}

target "php71-composer2" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.1-composer"
  args = {
    php_version = "7.1.33"
    composer_version = "2.2.0"
  }
  tags = tag("${target.php71-composer2.args.php_version}", "${target.php71-composer2.args.composer_version}")
}

target "php73-composer1" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.3-composer"
  args = {
    php_version = "7.3.33"
    composer_version = "1.9.1"
  }
  tags = tag("${target.php73-composer1.args.php_version}", "${target.php73-composer1.args.composer_version}")
}

target "php73-composer2" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.3-composer"
  args = {
    php_version = "7.3.33"
    composer_version = "2.2.0"
  }
  tags = tag("${target.php73-composer2.args.php_version}", "${target.php73-composer2.args.composer_version}")
}

target "php82-composer2" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/8.2-composer"
  args = {
    php_version = "8.2.22"
    composer_version = "2.8.5"
  }
  tags = tag("${target.php82-composer2.args.php_version}", "${target.php82-composer2.args.composer_version}")
}
