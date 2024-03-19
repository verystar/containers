target "common" {
  dockerfile = "Dockerfile"
  context = "toolkit"
}

target "toolkit" {
  inherits = ["common"]
  platforms = ["linux/amd64"]
  args = {
    debian_version = "12"
    kubewatch_version = "v0.20.0"
    aliyun_cli_version = "v3"
    kubectl_version = "v1.28.3"
    kustomize_version = "v5.3.0"
    argocd_version = "v2.10.4"
    yq_version = "v4.27.2"
  }
  // kubectl: https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl
  // kustomize: https://github.com/kubernetes-sigs/kustomize/releases
  tags = [
    "registry.verystar.net/library/toolkit:v1.8.0",
  ]
}
