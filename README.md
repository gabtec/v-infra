# Infra Repository

This repo is part of a bigger project:

- project-backend repo
- project-frontend repo
- project-infra repo

# Features

- [√] It's responsable for deploying local dev k3d kubernetes cluster, with ArgoCD included
- [TODO] It's responsable for deploying a production kubernetes cluster, with ArgoCD included

# Usage

## How to deploy the local cluster

```sh
# prep the local/k3d-conf.yaml file
# --> setup the cluster name: metadata.name: the-desired-name
# --> setup the cluster loadBalancer (traefik) port: ports.port: <the-desired-port-number>:80

# run
$ cd local
$ ./init-cluster.sh

# NOTE
## the script will add the following entry in /etc/hosts
## 127.0.0.1 argocd.local
```

## How to destroy the local cluster

```sh
# run
$ cd local
$ ./init-destruction.sh

# NOTE
## you should clean your /etc/hosts file, by removing:
## 127.0.0.1 argocd.local
```
