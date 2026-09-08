# PostgreSQL

A Helm chart for PostgreSQL using postgres:16-alpine image.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

## Installing the Chart

```bash
helm install my-postgresql ./postgresql
```

## Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| replicaCount | Number of replicas | 1 |
| image.repository | Image repository | postgres |
| image.tag | Image tag | "" (uses .Chart.AppVersion) |
| service.type | Service type | ClusterIP |
| service.port | Service port | 5432 |
| persistence.enabled | Enable PVC | true |
| persistence.size | PVC size | 8Gi |

## Security

- Runs as non-root user (999)
- All capabilities dropped
- PodSecurityContext with fsGroup 999