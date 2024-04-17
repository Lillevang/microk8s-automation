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

echo "Installing Kyverno policies..."  | tee -a $LOGFILE
helm install kyverno-policies kyverno/kyverno-policies -n kyverno
if [ $? -ne 0 ]; then
	echo "Failed to install Kyverno policies." | tee -a $LOGFILE
	exit 1
fi

echo "Kyverno installed successfully." | tee -a $LOGFILE
echo "Kyverno setup complete." | tee -a $LOGFILE
