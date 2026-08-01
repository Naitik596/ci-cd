# talkops-sample-app

A Helm chart for the talkops-sample-app.

## Introduction

This chart bootstraps a talkops-sample-app deployment on a Kubernetes cluster using the Helm package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.2.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add my-repo https://example.com/charts
$ helm install my-release my-repo/talkops-sample-app
```

The command deploys talkops-sample-app on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the talkops-sample-app chart and their default values.

| Parameter                  | Description                                     | Default                                |
| -------------------------- | ----------------------------------------------- | -------------------------------------- |
| `replicaCount`             | Number of replicas to deploy                    | `2`                                    |
| `image.repository`         | Image repository                                | `mehakt07/talkops-sample-app`          |
| `image.pullPolicy`         | Image pull policy                               | `IfNotPresent`                         |
| `image.tag`                | Image tag (overrides the chart's appVersion)    | `v1`                                   |
| `nameOverride`             | String to override the name of the chart        | `""`                                   |
| `fullnameOverride`         | String to override the fully qualified app name | `""`                                   |
| `serviceAccount.create`    | Whether to create a service account             | `true`                                 |
| `serviceAccount.annotations` | Annotations to add to the service account       | `{}`                                   |
| `serviceAccount.name`      | The name of the service account to use          | `""` (generated)                       |
| `podAnnotations`           | Annotations to add to the pod                   | `{}`                                   |
| `podSecurityContext`       | Pod security context                            | `{}`                                   |
| `securityContext`          | Container security context                      | see `values.yaml`                      |
| `service.type`             | Type of service to create                       | `LoadBalancer`                         |
| `service.port`             | Port for the service                            | `80`                                   |
| `ingress.enabled`          | Whether to enable ingress                       | `false`                                |
| `resources`                | CPU/memory resource requests and limits         | see `values.yaml`                      |
| `autoscaling.enabled`      | Whether to enable autoscaling                   | `false`                                |
| `nodeSelector`             | Node labels for pod assignment                  | `{}`                                   |
| `tolerations`              | Tolerations for pod assignment                  | `[]`                                   |
| `affinity`                 | Affinity for pod assignment                     | `{}`                                   |
