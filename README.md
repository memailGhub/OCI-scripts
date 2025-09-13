# OCI-scripts
OCI scripts to optimise the vm performance


### **1. Bash Script to Create Swap File**

**Purpose**: This script creates a swap file on your OCI instance, enabling additional virtual memory.

#### Key Steps in the Script:

1. **Create a Swap File** of 5GB (`/swapfile`):

   ```bash
   dd if=/dev/zero of=/swapfile bs=1M count=5120 status=progress
   ```

2. **Set the Right Permissions**:

   ```bash
   chmod 600 /swapfile
   ```

3. **Format the Swap File**:

   ```bash
   mkswap /swapfile
   ```

4. **Enable the Swap**:

   ```bash
   swapon /swapfile
   ```

5. **Make the Swap Permanent** by adding it to `/etc/fstab`:

   ```bash
   echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
   ```

**Outcome**: The script will create a swap file, make it active, and ensure it's used on system reboots.

---

### **2. Optimized `sysctl.conf` Configuration File**

**Purpose**: This config file optimizes various system parameters for better performance on a server with limited resources (1GB RAM, 1 CPU). It covers network, memory, disk, CPU, and system settings.

#### Key Sections:

* **Network Settings**:

  * Optimizes TCP buffers, enables TCP window scaling, disables delayed ACKs, and disables IPv6 for reduced overhead.

* **Memory Settings**:

  * Configures overcommit memory, sets `swappiness` to 10 to avoid excessive swapping, and enables `zswap` for compressed swap.

* **CPU Settings**:

  * Forces the CPU governor to "performance" mode for maximum CPU speed and reduces CPU frequency scaling overhead.

* **Disk and I/O Settings**:

  * Configures disk read-ahead buffer, disables write barriers for SSDs, and tunes I/O scheduler for better performance.

* **File System & Miscellaneous Settings**:

  * Reduces file access time (`noatime`), adjusts file descriptor limits, and optimizes for high-traffic applications by increasing connection tracking tables.

* **Automatic Disk Trim**:

  * Enables `fstrim` for SSD optimization, ensuring free space is reclaimed periodically.

**Outcome**: This file, once applied, will optimize the system for better network throughput, faster disk I/O, lower latency, and better use of limited resources.

---

### **In Summary:**

* **Bash script**: Creates and enables a 5GB swap file, making it persistent across reboots.
* **`sysctl.conf` configuration**: Optimizes the system's network, memory, disk, and CPU settings for improved performance on a low-resource OCI instance.


