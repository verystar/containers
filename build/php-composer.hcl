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
    "registry.verystar.net/library/composer:5.4.45-composer-1.8.0",
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
    "registry.verystar.net/library/composer:7.1.33-composer-1.9.1",
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
    "registry.verystar.net/library/composer:7.3.33-composer-1.9.1",
  ]
}


target "starbucks-composer-2-4-php-7-4" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  context = "php/7.4-composer/starbucks"
  args = {
    php_version = "7.4.30-fpm"
    composer_version = "2.4.1"
  }
  tags = [
    "verystar/composer:2.4.1-php-7.4.30",
    "verystar/composer:2.4-php-7.4",
  ]
}
