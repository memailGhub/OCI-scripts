#!/bin/bash

# Exit on error
set -e

# 1. Create a 5GB swap file
echo "Creating 5GB swap file..."
sudo fallocate -l 5G /swapfile || sudo dd if=/dev/zero of=/swapfile bs=1M count=5120 status=progress

# 2. Set proper permissions
echo "Setting proper permissions..."
sudo chmod 600 /swapfile

# 3. Make the file a swap space
echo "Setting up swap space..."
sudo mkswap /swapfile

# 4. Enable swap
echo "Enabling swap..."
sudo swapon /swapfile

# 5. Verify swap is active
echo "Verifying swap..."
swapon --show

# 6. Make the swap permanent by adding it to /etc/fstab
echo "Making swap permanent..."
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# 7. Adjust swappiness to 20 (optional)
echo "Setting swappiness to 20..."
sudo sysctl vm.swappiness=20

# 8. Make swappiness change permanent
echo "Making swappiness change permanent..."
echo 'vm.swappiness=20' | sudo tee -a /etc/sysctl.conf

# 9. Reload sysctl configuration
echo "Reloading sysctl configuration..."
sudo sysctl -p

echo "Swap file creation and configuration completed successfully!"

