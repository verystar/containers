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
    python_version="3.7.17"
  }
  tags = [
    "registry.verystar.net/library/python:3.7",
    "registry.verystar.net/library/python:3.7.17",
  ]
}

target "python3-8" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.8.19"
  }
  tags = [
    "registry.verystar.net/library/python:3.8",
    "registry.verystar.net/library/python:3.8.19",
  ]
}

target "python3-9" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.9.19"
  }
  tags = [
    "registry.verystar.net/library/python:3.9",
    "registry.verystar.net/library/python:3.9.19",
  ]
}

target "python3-10" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.10.14"
  }
  tags = [
    "registry.verystar.net/library/python:3.10",
    "registry.verystar.net/library/python:3.10.14",
  ]
}

target "python3-11" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.11.9"
  }
  tags = [
    "registry.verystar.net/library/python:3.11",
    "registry.verystar.net/library/python:3.11.9",
  ]
}

target "python3-12" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.12.0"
  }
  tags = [
    "registry.verystar.net/library/python:3.12",
    "registry.verystar.net/library/python:3.12.0",
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
    "registry.verystar.net/library/python:3.9-ai-v5",
  ]
}

target "python3-8-aigc" {
  context = "python/bigdata"
  dockerfile = "aigc.Dockerfile"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.8.19"
  }
  tags = [
    "registry.verystar.net/library/python:3.8-aigc",
    "registry.verystar.net/library/python:3.8.19-aigc",
  ]
}

target "python3-8-walking" {
  context = "python/bigdata"
  dockerfile = "walking.Dockerfile"
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    python_version="3.8.19"
  }
  tags = [
    "registry.verystar.net/library/python:3.8-walking",
    "registry.verystar.net/library/python:3.8.19-walking",
  ]
}
