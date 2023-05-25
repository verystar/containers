target "common" {
  dockerfile = "Dockerfile.3"
  context = "python"
}

// 很久没有更新了
target "python2-7" {
  dockerfile = "Dockerfile.2"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="2.7.18"
  }
  tags = [
    "registry.verystar.net/library/python:2.7",
    "registry.verystar.net/library/python:2.7.18",
  ]
}

// 很久没有更新了
target "python3-6" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.6.15"
  }
  tags = [
    "registry.verystar.net/library/python:3.6",
    "registry.verystar.net/library/python:3.6.15",
  ]
}

target "python3-7" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.7.16"
  }
  tags = [
    "registry.verystar.net/library/python:3.7",
    "registry.verystar.net/library/python:3.7.16",
  ]
}

target "python3-8" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.8.16"
  }
  tags = [
    "registry.verystar.net/library/python:3.8",
    "registry.verystar.net/library/python:3.8.16",
  ]
}

target "python3-9" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.9.16"
  }
  tags = [
    "registry.verystar.net/library/python:3.9",
    "registry.verystar.net/library/python:3.9.16",
  ]
}

target "python3-10" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.10.11"
  }
  tags = [
    "registry.verystar.net/library/python:3.10",
    "registry.verystar.net/library/python:3.10.11",
  ]
}

target "python3-11" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.11.3"
  }
  tags = [
    "registry.verystar.net/library/python:3.11",
    "registry.verystar.net/library/python:3.11.3",
  ]
}

target "python3-9-ai" {
  context = "python/bigdata"
  dockerfile = "Dockerfile.ai"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.9"
  }
  tags = [
    "registry.verystar.net/library/python:3.9-ai-v4",
  ]
}

target "python3-8-aigc" {
  context = "python/bigdata"
  dockerfile = "aigc.Dockerfile"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.8.13"
  }
  tags = [
    "registry.verystar.net/library/python:3.8-aigc",
    "registry.verystar.net/library/python:3.8.13-aigc",
  ]
}
