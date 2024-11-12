Yes, you can create a new VM in Proxmox from an Oracle Linux 9 ISO using Terraform, though the process is slightly different from cloning a template. Here’s a guide on setting up a VM from scratch using an ISO in Terraform.

### Prerequisites
1. **Oracle Linux 9 ISO**: Upload the Oracle Linux 9 ISO to your Proxmox storage, typically to a storage location like `local` or `iso`.
   - You can upload the ISO through the Proxmox web UI: **Datacenter > Storage > ISO Images > Upload**.
   
2. **Terraform and Proxmox Provider**: Ensure Terraform is installed and that you’re using the Proxmox provider (e.g., Telmate’s Proxmox provider).

### Step 1: Configure Terraform and Proxmox Provider
Create a Terraform configuration file (e.g., `main.tf`) and set up the Proxmox provider:

```hcl
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://<Proxmox-IP>:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "<your_password>"
  pm_tls_insecure = true
}
```

Replace `<Proxmox-IP>` and `<your_password>` with your Proxmox server’s IP and user password or token credentials.

### Step 2: Define the Virtual Machine Resource
In the same `main.tf` file, define a `proxmox_vm_qemu` resource that will use the Oracle Linux 9 ISO.

```hcl
resource "proxmox_vm_qemu" "oracle9-vm" {
  name        = "oracle-linux-9"             # Name of the VM
  target_node = "proxmox-node-01"            # Replace with your Proxmox node name

  # VM Settings
  vmid         = 101                          # Unique VM ID
  agent        = 1                            # Enable QEMU guest agent
  cores        = 2                            # Number of CPU cores
  sockets      = 1                            # Number of CPU sockets
  memory       = 2048                         # RAM in MB
  onboot       = true                         # Start VM on boot

  # Disk Configuration
  disk {
    size        = "20G"                       # Disk size
    storage     = "local-lvm"                 # Storage location for VM's disks
    type        = "scsi"                      # Disk type (e.g., scsi, ide, virtio)
  }

  # CD-ROM with ISO for Installation
  cdrom {
    storage     = "local"                     # ISO storage location
    file        = "iso/OracleLinux-R9.iso"    # Path to the Oracle Linux 9 ISO
  }

  # Network Configuration
  network {
    model    = "virtio"                       # Network model
    bridge   = "vmbr0"                        # Network bridge
  }

  # Operating System Type
  os_type = "l26"                             # "l26" is the generic Linux type for Proxmox
}
```

#### Configuration Explanation
- **vmid**: Ensure the VM ID is unique and not already in use.
- **disk**: Specifies the primary disk for the VM. Adjust `size`, `storage`, and `type` to match your Proxmox storage and preferences.
- **cdrom**: Points to the Oracle Linux 9 ISO file stored in Proxmox.
- **os_type**: Setting to `l26` specifies a generic Linux OS.

### Step 3: Initialize and Apply the Terraform Configuration
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Review the plan**:
   ```bash
   terraform plan
   ```

3. **Apply the configuration** to create the VM:
   ```bash
   terraform apply -auto-approve
   ```

Terraform will connect to Proxmox and create the VM, mounting the Oracle Linux 9 ISO for installation.

### Step 4: Access the Proxmox Console and Install Oracle Linux 9
1. Once Terraform completes, go to the Proxmox web UI.
2. Select the VM created by Terraform (e.g., `oracle-linux-9`).
3. Go to **Console** and start the VM if it’s not already running.
4. Follow the on-screen prompts to install Oracle Linux 9 from the ISO.

### Step 5: Post-Installation Steps
After installing Oracle Linux 9:
1. **Unmount the ISO**: In the Proxmox UI, go to the VM’s **Hardware** tab, select the CD-ROM, and remove the ISO image.
2. **Set Up Guest Agent** (optional but recommended): Install the QEMU guest agent on Oracle Linux to enable additional features and monitoring.

```bash
sudo dnf install -y qemu-guest-agent
sudo systemctl enable --now qemu-guest-agent
```

3. **Networking**: Configure any additional network settings within Oracle Linux 9 as needed.

### Example `main.tf` Summary

Here’s a consolidated example of the configuration file:

```hcl
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://<Proxmox-IP>:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "<your_password>"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "oracle9-vm" {
  name        = "oracle-linux-9"
  target_node = "proxmox-node-01"

  vmid        = 101
  agent       = 1
  cores       = 2
  sockets     = 1
  memory      = 2048
  onboot      = true

  disk {
    size        = "20G"
    storage     = "local-lvm"
    type        = "scsi"
  }

  cdrom {
    storage     = "local"
    file        = "iso/OracleLinux-R9.iso"
  }

  network {
    model    = "virtio"
    bridge   = "vmbr0"
  }

  os_type = "l26"
}
```

This setup will create a new VM in Proxmox with Oracle Linux 9 ready for installation from the ISO.