#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root!" 1>&2
    exit 1
fi

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install cpufrequtils to manage CPU governor
echo "Installing cpufrequtils for CPU governor control..."
sudo apt-get install cpufrequtils -y

# Install UFW (Uncomplicated Firewall) if not already installed
echo "Installing UFW for firewall management..."
sudo apt-get install ufw -y

# Enable UFW (Uncomplicated Firewall) if it's not already enabled
echo "Enabling UFW..."
sudo ufw enable

# Allow SSH and OpenVPN (UDP 1194)
sudo ufw allow 22/tcp       # SSH
sudo ufw allow 1194/udp     # OpenVPN

echo "Required packages installed successfully!"
