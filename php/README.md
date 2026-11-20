# PHP FPM 镜像

构建配置见 `build/php.hcl`,基础镜像来自 `php:*-fpm` 官方镜像(7.4 除外,已改自建,见下文)。

## PHP 版本支持状态

### PHP 7

| 次版本 | 最新 Patch | 镜像 tag          | 状态                                       |
| ------ | ---------- | ----------------- | ------------------------------------------ |
| 7.1    | 7.1.33     | `php:7.1.33-fpm`  | EOL 2019-12,已最新                         |
| 7.2    | 7.2.34     | `php:7.2.34-fpm`  | EOL 2020-11,已最新                         |
| 7.3    | 7.3.33     | `php:7.3.33-fpm`  | EOL 2021-12,已最新                         |
| 7.4    | 7.4.34     | 自建 `7.4.34-fpm` | EOL 2022-11,含 CVE-2026-109618/109619 修复 |

### PHP 7.4 自建基础镜像

官方 `php:7.4.33-fpm` 已随 7.4 EOL 停更,永远不包含
[CVE-2026-109618 / CVE-2026-109619](https://github.com/php/php-src/tree/PHP-7.4-CVE-2026-109618-109619)
修复,因此 7.4 改为在 `php/7.4-fpm-base` 参照 docker-library 官方 Dockerfile
(底座 `debian:bullseye-slim`,与官方 `php:7.4.33-fpm` 一致)
从 php-src CVE 修复分支(commit `712e60f`,sha256 校验)从源码自建基础镜像:

```
php-src CVE 分支 → php:7.4-fpm-base(base 层)
    → php:7.4-fpm(扩展层,原 Dockerfile 仅改 FROM)
        → php:7.4-composer(不变,引用内部 7.4-fpm)
    → verystar/php:7.4-fpm(客户版扩展层,仅推 DockerHub,见下节)
```

- 底座为 bullseye,与官方及旧生产 `7.4.33-fpm` 系镜像一致,系统库吃到
  bullseye 最后一批安全修订(curl `7.74.0-1.3+deb11u16`、openssl `1.1.1w`、
  libxml2 `2.9.10+deb11u10`)。bullseye 2026-08 结束 LTS 后 deb.debian.org 与
  阿里云均已摘除其包文件,apt 源固定指向 `archive.debian.org` 官方归档;
  archive 的 buster 库基线更旧且不再更新,勿改用
- 构建顺序:先 dispatch `php7-4-base`,完成后再 dispatch `php7-4` 与
  `php7-4-github`(base 更新当日需分步单独构建,勿一次选 `all`),最后触发
  `php-composer` 的 `php74` 构建
- 镜像内 `php -v` 显示 `7.4.34-dev`(CVE 分支 HEAD 版本号),版本 tag 为 `7.4.34-fpm(-base)`
- 上游 CVE 分支再叠加修复时:更新 `php/7.4-fpm-base/Dockerfile` 中的
  `PHP_URL`(commit)与 `PHP_SHA256`,重建三层即可

### 客户镜像(DockerHub)

`php/7.4-fpm-github` 是面向客户的 7.4 发布变体,构建配置见 `build/php.hcl`
的 `php7-4-github` target,仅推 DockerHub,不进内部 registry:

- 与内部 `php:7.4-fpm` 同源:同一 `7.4.34-fpm-base` 基础镜像、同一扩展集与
  php.ini/php-fpm 配置;内部 7.4 升级时需同步修改两份 Dockerfile
- 不内置默认 `SESSION_SAVE_PATH`(内部 Redis 地址不可推公开仓库),客户运行时
  通过环境变量注入自己的 Redis 地址:

  ```
  docker run -e SESSION_SAVE_PATH=tcp://<redis-host>:6379 verystar/php:7.4-fpm
  ```

- 仅构建 `linux/amd64` 单平台(客户环境无 arm64 需求)
- 发布 tag:`verystar/php:7.4-fpm`、`verystar/php:7.4.34-fpm`

### PHP 8

| 次版本 | 最新 Patch | 镜像 tag         | 状态               |
| ------ | ---------- | ---------------- | ------------------ |
| 8.0    | 8.0.30     | `php:8.0.30-fpm` | EOL 2023-11        |
| 8.1    | 8.1.34     | `php:8.1.34-fpm` | EOL 2025-12        |
| 8.2    | 8.2.36     | `php:8.2.36-fpm` | 安全支持至 2026-12 |
| 8.3    | 8.3.37     | `php:8.3.37-fpm` | 安全支持至 2027-12 |
| 8.4    | 8.4.28     | `php:8.4.28-fpm` | 活跃支持至 2026-12 |
| 8.5    | 8.5.13     | `php:8.5.13-fpm` | 活跃支持至 2027-12 |
| 8.6    | 8.6.0      | `php:8.6.0-fpm`  | 活跃支持至 2028-12 |

> 数据来源:php.net supported-versions / eol,2026-11-20 核对。仓库维护:7.1、7.2、7.3、7.4、8.0、8.1、8.2、8.3、8.4、8.5、8.6。

### PHP 8.6 说明

PHP 8.6.0 于 2026-11-19 发布,仓库已提供 `php/8.6-fpm` 与 `php/8.6-composer`,
但部分上游扩展尚未适配。PHP 8.6 移除了 `zval_dtor()`、`ZEND_WRONG_PARAM_COUNT`、
`zend_parse_parameters_throw`、`ZVAL_IS_NULL` 等 API,并调整了 `zend_fcall_info`、
`zend_function_entry` 与 stream filter 结构:

- **官方镜像自 8.6 起只提供 ZTS 构建**(NTS 已移除),`php -i` 的
  `Thread Safety` 为 enabled,见 docker-library/php#1673
- **redis**:6.3.0 未适配,暂固定 phpredis develop 的 commit
  `a6ce1e60b3e81ce3b25174aa5aaefd5590dc64fd`(sha256
  `79288312706263ad0744391752fd9a62273d5a73c4e6e6a42ff2819e76363533`);上游
  已加 8.6 CI 但未发版,发版后改回 PECL 下载
- **yaf**:3.3.8 未适配,构建时应用 `php/8.6-fpm/yaf-8.6.patch`(替换已移除 API、
  补齐 `zend_fcall_info.consumed_args`、修正 `YAF_ME` 的结构体初始化)
- **mcrypt**:1.0.9 虽声明支持到 8.6,但未适配新 stream filter API,构建时应用
  `php/8.6-fpm/mcrypt-8.6.patch`
- **nsq**:3.9.1 仍依赖 8.5 已移除的 `php_smart_string_public.h`,暂不安装
- **默认值变化**:8.6 把 `session.use_strict_mode` 默认改为 1、
  `session.cookie_httponly` 改为 1、`session.cookie_samesite` 改为 `Lax`;
  依赖跨站 POST 携带 Cookie 或应用自指定 session ID 的老应用需在应用侧显式覆盖
- **工具链变化**:官方 8.6 镜像不再包含 `pecl`/`pear`(仅保留 `phpize`/
  `php-config`),派生镜像若用 `pecl install` 需自行安装
- **ZTS 影响**:扩展 `.so` 为 ZTS ABI,不能复用 8.5(NTS)的扩展二进制;
  `Zend Signal Handling` 默认关闭
- 官方 `zz-docker.conf` 不再包含兼容用的 `[www]` 段,8.6 的 Dockerfile 自行补上后
  再追加 pool 配置
- mcrypt 流过滤器按不可 seek 注册,`rewind()` 不可用(8.5 可用),解密流程不受影响
- 构建顺序:先 dispatch `php8-6`(推送 `8.6.0-fpm`),完成后再 dispatch
  `php86-composer2`,否则 composer 构建会因基础镜像尚未推送而失败

上述补丁与 commit 固定待扩展官方发版支持 8.6 后移除。

## Composer 变体

`php:*-composer` 镜像在对应版本 FPM 镜像基础上内置 Composer,构建配置见 `build/php-composer.hcl`。

| PHP 版本 | 基础镜像          | Composer | 状态   |
| -------- | ----------------- | -------- | ------ |
| 7.1      | `php:7.1.33-fpm`  | 2.2.0    | 已支持 |
| 7.2      | `php:7.2.34-fpm`  | 2.2.0    | 已支持 |
| 7.3      | `php:7.3.33-fpm`  | 2.2.0    | 已支持 |
| 7.4      | 自建 `7.4.34-fpm` | 2.2.0    | 已支持 |
| 8.0      | `php:8.0.30-fpm`  | 2.8.5    | 已支持 |
| 8.1      | `php:8.1.34-fpm`  | 2.8.5    | 已支持 |
| 8.2      | `php:8.2.36-fpm`  | 2.8.5    | 已支持 |
| 8.3      | `php:8.3.37-fpm`  | 2.8.5    | 已支持 |
| 8.4      | `php:8.4.28-fpm`  | 2.8.5    | 已支持 |
| 8.5      | `php:8.5.13-fpm`  | 2.8.5    | 已支持 |
| 8.6      | `php:8.6.0-fpm`   | 2.11.2   | 已支持 |

## 扩展版本矩阵

### PHP 7

| 扩展    | 7.1.33 | 7.2.34 | 7.3.33 | 7.4.34 |
| ------- | ------ | ------ | ------ | ------ |
| redis   | 4.2.0  | 4.2.0  | 5.3.7  | 5.3.7  |
| yaf     | 3.0.7  | 3.0.7  | 3.3.5  | 3.3.5  |
| mcrypt  | 内置   | 1.0.1  | 1.0.5  | 1.0.6  |
| libssh2 | 1.9.0  | 1.9.0  | 1.10.0 | 1.11.0 |
| ssh2    | 1.2    | 1.2    | 1.3.1  | 1.4    |
| nsq     | 3.5.1  | 3.5.1  | 3.5.1  | 3.5.1  |

### PHP 8

| 扩展    | 8.0    | 8.1    | 8.2    | 8.3    | 8.4    | 8.5    | 8.6                    |
| ------- | ------ | ------ | ------ | ------ | ------ | ------ | ---------------------- |
| redis   | 6.3.0  | 6.3.0  | 6.3.0  | 6.3.0  | 6.3.0  | 6.3.0  | dev a6ce1e6 (6.3.0RC1) |
| yaf     | 3.3.7  | 3.3.7  | 3.3.7  | 3.3.7  | 3.3.7  | 3.3.7  | 3.3.8\*                |
| mcrypt  | 1.0.9  | 1.0.9  | 1.0.9  | 1.0.9  | 1.0.9  | 1.0.9  | 1.0.9\*                |
| libssh2 | 1.11.1 | 1.11.1 | 1.11.1 | 1.11.1 | 1.11.1 | 1.11.1 | 1.11.1                 |
| ssh2    | 1.5.0  | 1.5.0  | 1.5.0  | 1.5.0  | 1.5.0  | 1.5.0  | 1.6.1                  |
| nsq     | 3.5.1  | 3.5.1  | 3.5.1  | 3.5.1  | 3.5.1  | —      | —                      |

> `*` 表示该版本需在构建时应用 `php/8.6-fpm/` 下的补丁,详见「PHP 8.6 说明」。

#### PHP 8 扩展官方支持说明

数据来源:PECL 官网 release 依赖声明,2026-11-20 核对。

| 扩展    | 官方最新稳定版 | 官方 PHP 依赖声明 | 8.0~8.6 支持说明                         |
| ------- | -------------- | ----------------- | ---------------------------------------- |
| redis   | 6.3.0          | PHP 7.4+          | 8.0~8.5 用 6.3.0;8.6 需 phpredis develop |
| yaf     | 3.3.8          | PHP 7.0+          | 8.0~8.5 用 3.3.7;8.6 用 3.3.8 + 补丁     |
| mcrypt  | 1.0.9          | PHP 7.2+, ≤8.6    | 覆盖 8.5;8.6 需补丁                      |
| libssh2 | 1.11.1         | 系统 C 库         | 与 PHP 版本无关                          |
| ssh2    | 1.6.1          | PHP 8.0+          | 8.0~8.5 用 1.5.0;8.6 用 1.6.1            |
| nsq     | 3.9.1          | PHP 7.0+          | 8.0~8.4 用 3.5.1;8.5、8.6 编译失败(见下) |

> 注:nsq 官方最新版为 3.9.1,理论上支持 8.5;但 PHP 8.5/8.6 移除了 `php_smart_string_public.h`,源码编译失败,故 8.5、8.6 镜像暂不安装,待官方适配后恢复。

## 内置扩展(随 PHP 版本)

bcmath、zip、pdo_mysql、mysqli、opcache、xsl、gettext、pcntl、gd、ldap、mbstring

> 注:7.1 的 mcrypt 为 PHP 内置扩展,7.2+ 改为 pecl 安装;nsq 在 8.0~~8.4 固定 3.5.1,8.5/8.6 因 PHP 移除了 `php_smart_string_public.h` 暂不可用;8.0~~8.4 的扩展版本一致,8.5 除 nsq 外与 8.4 相同;8.6 官方镜像改为 ZTS,除 nsq 外扩展均已验证可加载。
