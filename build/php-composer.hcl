target "common" {
  dockerfile = "Dockerfile"
}

target "php54-composer18" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/5.4-composer"
  args = {
    php_version = "5.4.45-fpm"
    composer_version = "1.8.0"
  }
  tags = [
    "registry.verystar.net/library/php:5.4.45-composer-1.8.0",
  ]
}

target "php71-composer19" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.1-composer"
  args = {
    php_version = "7.1.33-fpm"
    composer_version = "1.9.1"
  }
  tags = [
    "registry.verystar.net/library/php:7.1.33-composer-1.9.1",
  ]
}

target "php71-composer22" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.1-composer"
  args = {
    php_version = "7.1.33-fpm"
    composer_version = "2.2.0"
  }
  tags = [
    "registry.verystar.net/library/php:7.1.33-composer-2.2.0",
  ]
}

target "php73-composer19" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.3-composer"
  args = {
    php_version = "7.3.33-fpm"
    composer_version = "1.9.1"
  }
  tags = [
    "registry.verystar.net/library/php:7.3.33-composer-1.9.1",
  ]
}

target "php73-composer22" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.3-composer"
  args = {
    php_version = "7.3.33-fpm"
    composer_version = "2.2.0"
  }
  tags = [
    "registry.verystar.net/library/php:7.3.33-composer-2.2.0",
  ]
}

target "php82-composer" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/8.2-composer"
  args = {
    php_version = "8.2.22-fpm"
    composer_version = "2.7.7"
  }
  tags = [
    "registry.verystar.net/library/php:8.2-composer-2.7.7",
    "registry.verystar.net/library/php:8.2.22-composer-2.7.7",
  ]
}

target "starbucks-composer-2-5-php-7-4" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.4-composer/starbucks"
  args = {
    php_version = "7.4.33-fpm-r2"
    composer_version = "2.5.8"
  }
  tags = [
    "verystar/composer:2.5-php-7.4-r2",
    "verystar/composer:2.5.8-php-7.4.33-r2",
  ]
}
