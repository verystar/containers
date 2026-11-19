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

## 从 amazoncorretto 迁移

`amazoncorretto` 仓库已冻结，不再更新。2026-11 的替换清单：

| 旧引用                                                    | 推荐引用                                    | 说明                               |
| --------------------------------------------------------- | ------------------------------------------- | ---------------------------------- |
| `amazoncorretto:8u362`、`8u372`、`8`、`8.0`               | `openjdk:8u514` 或 `openjdk:8`              | 遗留系统                           |
| `amazoncorretto:11.0.18`、`11.0.19`、`11`、`11.0`         | `openjdk:11.0.33` 或 `openjdk:11`           | 遗留系统                           |
| `amazoncorretto:17.0.6`、`17.0.7`、`17`、`17.0`           | `openjdk:17.0.21` 或 `openjdk:17`           |                                    |
| `amazoncorretto:15.0.2`、`15`、`15.0`                     | `openjdk:17.0.21`（或 `21.0.13`、`25.0.5`） | Java 15 已 EOL，运行时镜像不再发布 |
| `amazoncorretto:19.0.2`、`19`、`19.0`                     | `openjdk:21.0.13` 或 `openjdk:21`           | Java 19 已 EOL                     |
| `amazoncorretto:20.0.0`、`20.0.1`、`20`、`20.0`、`latest` | `openjdk:25.0.5` 或 `openjdk:latest`        | Java 20 已 EOL，`latest` 已切到 25 |

注意事项：

- 两个仓库底座相同，`JAVA_HOME` 都是 `/usr/lib/jvm/java-*-amazon-corretto`；但从更早的官方 `openjdk:*` 镜像迁移过来时，路径会从 `/usr/java/openjdk-*` 变为上述路径，硬编码路径的脚本需要检查。
- `15` 只保留在 toolkit 矩阵（`openjdk:15-gradle-7.4-maven-3.8`），运行时镜像已移除。
- 短 tag（`openjdk:11`、`17`、`21`）随每次构建自动跟补丁；需要可复现时固定完整版本号。
