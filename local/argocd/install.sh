#! /bin/bash
# https://github.com/mcarr-and/k3d-traefik-argocd/blob/main/scripts/install-argocd.sh
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml 

kubectl apply -f argocd/ingress-argocd.yaml

kubectl apply -n argocd -f argocd/argocd-cmd-params-cm-insecure.yaml

kubectl rollout restart -n argocd deployment argocd-server
kubectl rollout restart -n argocd deployment argocd-repo-server