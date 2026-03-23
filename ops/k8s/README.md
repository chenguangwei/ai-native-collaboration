# Kubernetes 集群部署清单

此目录用于放置 Kubernetes 配置文件。

## 结构

```
k8s/
├── /base/          # 基础配置
├── /overlays/     # 环境覆盖
└── kustomization.yaml
```

## 部署

```bash
kubectl apply -k overlays/production
```
