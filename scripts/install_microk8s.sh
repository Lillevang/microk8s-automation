#!/bin/bash

# Log file location
LOGFILE="/var/log/install_microk8s.log"

# Ensure the script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" | tee -a $LOGFILE
   exit 1
fi

echo "Starting MicroK8s installation..." | tee -a $LOGFILE

# Install MicroK8s from Snap
sudo snap install microk8s --classic | tee -a $LOGFILE
if [ $? -ne 0 ]; then
    echo "Failed to install MicroK8s." | tee -a $LOGFILE
    exit 1
fi

echo "MicroK8s installed successfully." | tee -a $LOGFILE

# Wait for MicroK8s to be ready
echo "Waiting for MicroK8s to be ready..." | tee -a $LOGFILE
sudo microk8s.status --wait-ready | tee -a $LOGFILE

# Enable essential services
echo "Enabling DNS and dashboard services..." | tee -a $LOGFILE
sudo microk8s enable dns dashboard | tee -a $LOGFILE
if [ $? -ne 0 ]; then
    echo "Failed to enable DNS and dashboard services on MicroK8s." | tee -a $LOGFILE
    exit 1
fi

echo "Services enabled successfully." | tee -a $LOGFILE

# Alias kubectl to simplify command execution
echo "Creating kubectl alias..." | tee -a $LOGFILE
sudo snap alias microk8s.kubectl kubectl | tee -a $LOGFILE
if [ $? -ne 0 ]; then
    echo "Failed to create alias for kubectl." | tee -a $LOGFILE
    exit 1
fi

echo "kubectl alias created successfully." | tee -a $LOGFILE
echo "MicroK8s installation and setup complete." | tee -a $LOGFILE
