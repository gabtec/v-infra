#! /bin/bash

echo "[ INFO:] Checking if k3d is installed..."


if $(k3d version | grep "not found"); then
  echo "[ INFO:] Installing k3d..."
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
fi

echo "[ INFO:] k3d OK."

echo "[ INFO:] Starting a local kubernetes cluster..."

if [ ! -e "k3d-conf.yaml" ]; then
  echo "[ERROR:] Can not find a configuration file."
  exit 1
fi 

k3d cluster create --config ./k3d-conf.yaml

echo "[ INFO:] Done. Cluster created."

k3d cluster list

LB_PORT=$(cat k3d-conf.yaml | grep port: | cut -d "#" -f 1 | cut -d ":" -f 2)
KLUSTER_NAME=$(cat k3d-conf.yaml| grep -A 2 metadata | grep name: | cut -d ":" -f 2)

echo "[INFO:] Cluster LoadBalancer/Ingress Port is: ${LB_PORT}"

echo "[INFO:] Switching context..."

# {...## } --> removes leading spaces
kubectl config use-context k3d-${KLUSTER_NAME## }

echo "[INFO:] Installing ArgoCD..."

./argocd/install.sh

# prep /etc/hosts
DNS_OK=$(cat /etc/hosts | grep argocd.local)

if [ $DNS_OK != "127.0.0.1 argocd.local" ]; then
  sudo echo "127.0.0.1 argocd.local" >> /etc/hosts
fi 

echo ""
echo "[INFO:] ArgoCD installed."
echo "[INFO:] You can access ArgoCD UI browsing to https://argocd.local:${LB_PORT## }"
K_PASS=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
echo "[INFO:] Use this credentials: user=admin, password=${K_PASS}"