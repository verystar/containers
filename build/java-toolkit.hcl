target "common" {
  dockerfile = "Dockerfile"
  context = "verystar/java-toolkit"
}

target "amazoncorretto-8" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  // dockerfile = "debian.Dockerfile"
  args = {
    openjdk_version = "8u362"
    gradle_version = "7.4.2"
    maven_version = "3.8.8"
  }
  tags = [
    "registry.verystar.net/library/java-toolkit:openjdk8-gradle-7.4.2-maven-3.8.8",
  ]
}

target "amazoncorretto-11" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    openjdk_version = "11.0.18"
    gradle_version = "7.4.2"
    maven_version = "3.8.8"
  }
  tags = [
    "registry.verystar.net/library/java-toolkit:openjdk11-gradle-7.4.2-maven-3.8.8",
  ]
}

target "amazoncorretto-14" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    openjdk_version = "14.0.2-oraclelinux7"
    gradle_version = "7.4.2"
    maven_version = "3.8.8"
  }
  tags = [
    "registry.verystar.net/library/java-toolkit:openjdk14-gradle-7.4.2-maven-3.8.8-v3",
  ]
}

target "amazoncorretto-15" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    openjdk_version = "15.0.2"
    gradle_version = "7.4.2"
    maven_version = "3.8.8"
  }
  tags = [
    "registry.verystar.net/library/java-toolkit:openjdk15-gradle-7.4.2-maven-3.8.8",
  ]
}

target "amazoncorretto-17" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    openjdk_version = "17.0.6"
    gradle_version = "7.4.2"
    maven_version = "3.8.8"
  }
  tags = [
    "registry.verystar.net/library/java-toolkit:openjdk17-gradle-7.4.2-maven-3.8.8",
  ]
}
