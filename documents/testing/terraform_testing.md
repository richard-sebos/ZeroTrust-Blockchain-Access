Creating a new VM in Proxmox using Terraform involves configuring Terraform to communicate with your Proxmox server, setting up the Proxmox provider, and defining the VM parameters. Here’s a step-by-step guide:

### Prerequisites
1. **Terraform**: Ensure you have Terraform installed. You can check this with:
   ```bash
   terraform -v
   ```

2. **Proxmox API Access**: You'll need:
   - The Proxmox server’s IP address or hostname.
   - A Proxmox API token (recommended for security) or user credentials with sufficient permissions to create VMs.
   - The Proxmox server’s `pveproxy` port (default is `8006`).

3. **Terraform Proxmox Provider**: Install the Proxmox provider in your Terraform configuration. The provider is available from the Terraform registry.

### Step 1: Install the Proxmox Provider for Terraform
Add the Proxmox provider to your Terraform configuration file.

1. **Create a project directory**:
   ```bash
   mkdir proxmox-vm && cd proxmox-vm
   ```

2. **Create a Terraform configuration file** (e.g., `main.tf`) and define the provider:
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
     pm_password     = "<your_password>"    # Or use pm_api_token_id for tokens
     pm_tls_insecure = true                 # Set to true if using self-signed certificates
   }
   ```

Replace `<Proxmox-IP>` and `<your_password>` with your actual Proxmox IP and user password. Alternatively, you can use `pm_api_token_id` and `pm_api_token_secret` for more secure access.

### Step 2: Define the Virtual Machine Resource
1. In the same `main.tf` file, define a `proxmox_vm_qemu` resource that specifies the VM settings:

   ```hcl
   resource "proxmox_vm_qemu" "example-vm" {
     name        = "terraform-vm"           # Name of the VM
     target_node = "proxmox-node-01"        # Replace with your Proxmox node name

     # VM settings
     clone          = "template-vm"         # Name of the Proxmox template VM to clone
     vmid           = 100                   # Unique VM ID
     cores          = 2                     # Number of CPU cores
     memory         = 2048                  # RAM in MB
     disk_size      = "10G"                 # Disk size
     storage        = "local-lvm"           # Storage location for VM's disks

     # Network configuration
     network {
       model    = "virtio"
       bridge   = "vmbr0"                  # Replace with your Proxmox network bridge
       firewall = true
     }

     # OS configuration
     os_type        = "cloud-init"         # Use "cloud-init" if using cloud-init images
     ssh_user       = "root"
   }
   ```

   - **clone**: Specify a template VM or an ISO to clone from. This must be set up in Proxmox.
   - **vmid**: Set a unique VM ID that is not already in use.
   - **cores** and **memory**: Configure the desired CPU and RAM.
   - **storage**: Define the storage type and disk size for the VM.
   - **network**: Configure the network, including the network bridge and model.
   - **os_type**: If using a cloud-init image, set this to `cloud-init`.

2. Adjust parameters like `vmid`, `name`, `target_node`, and `storage` to match your Proxmox environment.

### Step 3: Initialize and Apply the Terraform Configuration
1. **Initialize the Terraform project** to download the Proxmox provider:
   ```bash
   terraform init
   ```

2. **Review the plan** to see what changes Terraform will apply:
   ```bash
   terraform plan
   ```

3. **Apply the configuration** to create the VM in Proxmox:
   ```bash
   terraform apply -auto-approve
   ```

Terraform will now connect to Proxmox, create the VM with the specified configuration, and output the result. You can check Proxmox to verify that the VM has been created.

### Step 4: Test and Access the VM
If the VM uses `cloud-init`, ensure that `cloud-init` configurations are correctly set up in the template VM you cloned from, as this will control settings like the SSH key and default user access. Once the VM is up, you can SSH into it using the configured user.

### Example `main.tf` Summary

Here's how the final `main.tf` might look:
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

resource "proxmox_vm_qemu" "example-vm" {
  name        = "terraform-vm"
  target_node = "proxmox-node-01"

  clone       = "template-vm"
  vmid        = 100
  cores       = 2
  memory      = 2048
  disk_size   = "10G"
  storage     = "local-lvm"

  network {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = true
  }

  os_type     = "cloud-init"
  ssh_user    = "root"
}
```

### Troubleshooting Tips
- **Permissions**: If there are permission errors, ensure the Proxmox user or API token has rights to create and manage VMs.
- **Self-Signed Certificate**: For self-signed certificates, setting `pm_tls_insecure = true` bypasses verification; for production, consider adding your certificate to the trusted list.
- **Template Setup**: Using cloud-init images as templates speeds up deployment and configuration. Ensure templates are properly configured for cloud-init.

This should set up your VM through Terraform on Proxmox! Let me know if you have questions on specific configurations.