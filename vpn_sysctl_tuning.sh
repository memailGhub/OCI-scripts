#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root!" 1>&2
    exit 1
fi

# Backup the original sysctl.conf
cp /etc/sysctl.conf /etc/sysctl.conf.bak

# Add optimization parameters to sysctl.conf
echo "Applying sysctl tuning for VPN server..."

# Network Optimizations
cat <<EOF >> /etc/sysctl.conf

# Increase maximum buffer sizes for TCP/UDP
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.rmem_default = 262144
net.core.wmem_default = 262144
net.ipv4.udp_rmem_min = 4096
net.ipv4.udp_wmem_min = 4096
net.core.somaxconn = 1024
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216

# Allow fast TCP connections and reduce overhead
net.netfilter.nf_conntrack_max = 262144
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_tso_win_divisor = 3
net.core.default_qdisc = fq
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_ecn = 0

# Disable IPv6 if not in use
net.ipv6.conf.all.disable_ipv6 = 1

# Enable IP forwarding for VPN routing
net.ipv4.ip_forward = 1
EOF

# Apply the changes
sudo sysctl -p

echo "sysctl tuning applied successfully!"
