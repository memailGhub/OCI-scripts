#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root!" 1>&2
    exit 1
fi

# Backup /etc/rc.local if it exists to set the scheduler permanently
if [ -f /etc/rc.local ]; then
    cp /etc/rc.local /etc/rc.local.bak
else
    touch /etc/rc.local
fi

# Change I/O scheduler (if using SSD)
echo "Setting I/O scheduler to 'deadline'..."
echo deadline > /sys/block/sda/queue/scheduler

# Make the change permanent by adding to /etc/rc.local
echo "echo deadline > /sys/block/sda/queue/scheduler" >> /etc/rc.local

# Set CPU governor to 'performance'
echo "Setting CPU governor to 'performance'..."
cpufreq-set -g performance

# Enable IP forwarding (for VPN routing)
echo "Ensuring IP forwarding is enabled..."
sysctl -w net.ipv4.ip_forward=1

# Firewall Configuration - Allow OpenVPN (UDP 1194) and SSH (TCP 22)
echo "Setting up firewall rules..."
ufw allow 1194/udp     # OpenVPN (UDP 1194)
ufw allow 22/tcp       # SSH (TCP 22)
ufw enable             # Enable UFW

# Disable IPv6 (if not used by your VPN)
echo "Disabling IPv6..."
sysctl -w net.ipv6.conf.all.disable_ipv6=1

echo "VPN server optimization completed successfully!"
