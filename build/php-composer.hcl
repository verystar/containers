target "common" {
  dockerfile = "Dockerfile"
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
    "registry.verystar.net/library/php:7.1.33-composer-1.9.1-20250211151103",
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
    "registry.verystar.net/library/php:7.1.33-composer-2.2.0-20250211071331",
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
    "registry.verystar.net/library/php:7.3.33-composer-1.9.1-20250211151553",
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
    "registry.verystar.net/library/php:7.3.33-composer-2.2.0-20250211151853",
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
