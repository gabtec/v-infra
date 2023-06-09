#! /bin/bash

echo "[ WARNING:] This will delete the cluster defined in k3d-conf.yaml file"
echo "[ WARNING:] Do you wish to continue (y/n)?"
read ANSWER

if [[ $ANSWER == "y" || $ANSWER == "Y" ]]; then 
  KLUSTER_NAME=$(cat k3d-conf.yaml| grep -A 2 metadata | grep name: | cut -d ":" -f 2)

  if [ ! $KLUSTER_NAME ]; then
    echo "[ERROR:] No action performed."
    exit 1
  fi

  k3d cluster delete ${KLUSTER_NAME}

  echo "[INFO:] K3d cluster deleted."
  echo ""
  echo "[TODO:] clean your /etc/hosts file argocd.local entry."
  exit 0
fi 

echo "[INFO:] No action performed."
exit 0
