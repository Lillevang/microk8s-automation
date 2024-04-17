#!/bin/bash

# Log file location
LOGFILE="/var/log/setup_kyverno.log"

# Ensure the script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" | tee -a $LOGFILE
   exit 1
fi

# Set KUBECONFIG for MicroK8s
export KUBECONFIG=/var/snap/microk8s/current/credentials/client.config

echo "Starting Kyverno installation..." | tee -a $LOGFILE

# Install Kyverno using Helm
echo "Adding Kyverno Helm repository..." | tee -a $LOGFILE
helm repo add kyverno https://kyverno.github.io/kyverno/ | tee -a $LOGFILE
helm repo update | tee -a $LOGFILE

echo "Installing Kyverno..." | tee -a $LOGFILE
helm install kyverno kyverno/kyverno -n kyverno --create-namespace | tee -a $LOGFILE
if [ $? -ne 0 ]; then
    echo "Failed to install Kyverno." | tee -a $LOGFILE
    exit 1
fi

# Wait for Kyverno to be ready
echo "Waiting for Kyverno pods to be ready..." | tee -a $LOGFILE
READY=0
while [ $READY -eq 0 ]; do
    # Check if the Kyverno pod is ready
    KYVERNO_READY=$(kubectl get pods -n kyverno -l app.kubernetes.io/name=kyverno -o jsonpath="{.items[0].status.conditions[?(@.type=='Ready')].status}")
    if [ "$KYVERNO_READY" == "True" ]; then
        READY=1
        echo "Kyverno is ready." | tee -a $LOGFILE
    else
        echo "Waiting for Kyverno to become ready..." | tee -a $LOGFILE
        sleep 10
    fi
done



echo "Installing Kyverno policies..."  | tee -a $LOGFILE
helm install kyverno-policies kyverno/kyverno-policies -n kyverno
if [ $? -ne 0 ]; then
	echo "Failed to install Kyverno policies." | tee -a $LOGFILE
	exit 1
fi

echo "Kyverno installed successfully." | tee -a $LOGFILE
echo "Kyverno setup complete." | tee -a $LOGFILE
