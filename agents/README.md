# Agents 容器镜像

用于 AI Agents 工作的 Python 容器镜像，包含完整的工具链和依赖库。

## 特性

- 基于 Python 官方镜像
- 包含 PDF、Excel、Word 等文档处理工具
- 集成数据处理库（pandas、duckdb）
- 支持 OSS 云存储
- 预装常用 CLI 工具（jq、yq、ripgrep、fd-find）

## 构建参数

| 参数                | 说明        | 默认值                    |
| ------------------- | ----------- | ------------------------- |
| `python_version`    | Python 版本 | 必填                      |
| `requirements_file` | 依赖文件    | `requirements-latest.txt` |
| `image_version`     | 镜像版本    | `1.0.0`                   |

## 构建示例

```bash
# 使用 Python 3.12 + 最新依赖版本
docker build --build-arg python_version=3.12 -t agents:3.12 .

# 使用 Python 3.11 + 固定依赖版本
docker build --build-arg python_version=3.11 --build-arg requirements_file=requirements.txt -t agents:3.11-fixed .

# 指定镜像版本
docker build --build-arg python_version=3.12 --build-arg image_version=2.0.0 -t agents:3.12-v2 .
```

## 安全特性

- 以非 root 用户 `agents` (uid 1000) 运行
- 包含健康检查机制
- 设置 WORKDIR 工作目录 `/app`

## 包含工具

### 系统工具

- `jq` - JSON 处理
- `yq` - YAML 处理
- `ripgrep` (rg) - 快速文本搜索
- `fd-find` (fd) - 快速文件查找
- `curl` / `wget` - HTTP 客户端

### 文档处理

- `libreoffice` - Office 文档转换
- `poppler-utils` - PDF 工具集

### Python 库

| 类别       | 库                                         |
| ---------- | ------------------------------------------ |
| 数据处理   | pandas, numpy, duckdb                      |
| PDF 处理   | pypdf, pdfplumber, pdfminer-six, pdf2image |
| Excel 处理 | openpyxl                                   |
| 数据库     | pymysql                                    |
| 云存储     | oss2 (阿里云 OSS)                          |
| HTTP       | requests                                   |
| 工具       | uv, markdownify                            |

### Node.js

- `pptxgenjs` - PowerPoint 生成
- `typescript` - TypeScript 支持

## 时区

默认时区：`Asia/Shanghai`

## 维护者

[verystar.net](https://www.verystar.net)
