# openjdk

本目录包含两类镜像：

- `Dockerfile`：容器运行时使用的 JDK 镜像，基础镜像为 `amazoncorretto`。
- `toolkit/`：JDK + Gradle + Maven 的构建工具镜像。

## 镜像归属

| 用途            | 构建文件                                                            | 镜像名    | tag 示例                            |
| --------------- | ------------------------------------------------------------------- | --------- | ----------------------------------- |
| 运行时 JDK 镜像 | [`openjdk.yaml`](../.github/workflows/openjdk.yaml)                 | `openjdk` | `21.0.13`、`21`、`25.0.5`、`latest` |
| 构建工具镜像    | [`openjdk-toolkit.yaml`](../.github/workflows/openjdk-toolkit.yaml) | `openjdk` | `21-gradle-8.14-maven-3.9`          |

两类镜像共用 `openjdk` 仓库，tag 前缀不同（纯版本号 vs `<jdk>-gradle-`），不会互相覆盖。

## 历史

原 `openjdk.yaml` 基于官方 `openjdk:<version>` 并内置 jmx_prometheus_javaagent，已下线。现在运行时 JDK 镜像改由 Amazon Corretto 提供（`FROM amazoncorretto`），镜像名与 tag 格式保持不变，使用方无需调整引用。
