#!/bin/bash

# Log file location
LOGFILE="/var/log/setup_environment.log"

# Update system and install necessary packages
echo "Updating system and installing necessary packages..." | tee -a $LOGFILE

# Ensure the script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" | tee -a $LOGFILE
   exit 1
fi

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y | tee -a $LOGFILE
if [ $? -ne 0 ]; then
    echo "Failed to update and upgrade system packages." | tee -a $LOGFILE
    exit 1
fi

# Install snapd and make
sudo apt install snapd make -y | tee -a $LOGFILE
if [ $? -ne 0 ]; then
    echo "Failed to install snapd and make." | tee -a $LOGFILE
    exit 1
fi

# Install Helm
echo "Installing Helm..." | tee -a $LOGFILE
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash | tee -a $LOGFILE
if [ $? -ne 0 ]; then
    echo "Failed to install Helm." | tee -a $LOGFILE
    exit 1
fi

echo "Environment setup complete." | tee -a $LOGFILE

