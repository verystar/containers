target "common" {
  dockerfile = "Dockerfile"
  context = "nginx"
}

target "nginx-1-23-html" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    nginx_version = "1.23.4"
    default_conf = "nginx.vh.html.conf"
  }
  tags = [
    "verystar/nginx:1.23",
    "verystar/nginx:1.23.4",
    "registry.verystar.net/library/nginx:1.23",
    "registry.verystar.net/library/nginx:1.23.4",
  ]
}

target "nginx-1-23-proxy" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    nginx_version = "1.25.2"
    default_conf = "nginx.vh.proxy.conf"
  }
  tags = [
    "registry.verystar.net/library/nginx:1.25-proxy",
    "registry.verystar.net/library/nginx:1.25.2-proxy",
  ]
}

target "nginx-1-23-uwsgi" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    nginx_version = "1.25.2"
    default_conf = "nginx.vh.uwsgi.conf"
  }
  tags = [
    "registry.verystar.net/library/nginx:1.25-uwsgi",
    "registry.verystar.net/library/nginx:1.25.2-uwsgi",
  ]
}

target "nginx-1-23-nsq" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    nginx_version = "1.23.4"
    default_conf = "nginx.vh.nsq.conf"
  }
  tags = [
    "registry.verystar.net/library/nginx:1.23-nsq",
    "registry.verystar.net/library/nginx:1.23.4-nsq",
  ]
}

// https://learnku.com/docs/laravel/5.8/deployment/3884#server-configuration
target "nginx-1-23-laravel" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    nginx_version = "1.23.4"
    default_conf = "nginx.vh.laravel.conf"
  }
  tags = [
    "verystar/nginx:1.23-laravel",
    "verystar/nginx:1.23.4-laravel",
    "registry.verystar.net/library/nginx:1.23-laravel",
    "registry.verystar.net/library/nginx:1.23.4-laravel",
  ]
}

// https://www.laruence.com/manual/tutorial.firstpage.html
target "nginx-1-23-yaf" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    nginx_version = "1.23.4"
    default_conf = "nginx.vh.yaf.conf"
  }
  tags = [
    "verystar/nginx:1.23-yaf",
    "verystar/nginx:1.23.4-yaf",
    "registry.verystar.net/library/nginx:1.23-yaf",
    "registry.verystar.net/library/nginx:1.23.4-yaf",
  ]
}
