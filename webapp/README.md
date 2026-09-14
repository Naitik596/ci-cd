# webapp

A Helm chart for a web application with ConfigMap for config files and Secret for API key, both volumes mounted into the same pod's container.

## Installation

```bash
helm install my-webapp ./webapp
```

## Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `configMap.enabled` | Enable ConfigMap creation | `true` |
| `configMap.data` | ConfigMap data | See values.yaml |
| `secret.enabled` | Enable Secret creation | `true` |
| `secret.apiKey` | API key value | `"your-api-key-here"` |
| `volumeMounts` | Volume mounts for both volumes | See values.yaml |

Both volumes (config-volume from ConfigMap, secret-volume from Secret) are mounted into the container as defined in `volumeMounts`.