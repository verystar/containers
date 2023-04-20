# 注意

## kubectl版本

[官方说明](https://kubernetes.io/zh/docs/setup/release/version-skew-policy/#kube-apiserver-1)

- kube-apiserver 为 1.(n+1) 版本
- kubelet 可以升级到 1.(n+1)（或者停留在 1.n 或 1.(n-1)）

## 构建说明

因为访问资源过慢问题, 如果可以的话, 直接国外构建, 然后推送到公司仓库, 不用忍受墙的问题.