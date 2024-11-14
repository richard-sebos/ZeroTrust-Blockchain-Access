# Configure the Proxmox provider
provider "proxmox" {
  pm_api_url = "https://192.168.177.7:8006/api2/json"
  pm_user    = "root@pam"
  pm_password = "<YOUR_PASSWORD>"
  pm_tls_insecure = true  # Only set to true if you don't have a valid SSL cert on Proxmox
}

# Define the LXC container
resource "proxmox_lxc" "bind_server" {
  # Basic container settings
  target_node = "proxmox-mgmt"
  hostname    = "bind-server.local"
  ostemplate  = "local:vztmpl/debian-11-standard_11.0-1_amd64.tar.gz"
  storage     = "local-lvm"
  rootfs      = "local-lvm:8G" # Adjust storage size as needed
  memory      = 512  # Memory allocation
  swap        = 512  # Swap allocation
  cores       = 2
  net0        = "name=eth0,bridge=vmbr0,ip=192.168.178.72/24,gw=192.168.178.1" # Update IP and gateway

  # Container provisioning
  provisioner "remote-exec" {
    inline = [
      "apt update && apt install -y bind9",
      "echo 'options { directory \"/var/cache/bind\"; };' > /etc/bind/named.conf.options",
      "systemctl restart bind9"
    ]

    connection {
      type     = "ssh"
      user     = "root"
      password = "<CONTAINER_ROOT_PASSWORD>"
      host     = self.ipv4_address
      port     = 22
    }
  }

  # DNS zone file provisioning
  provisioner "file" {
    content     = <<EOF
zone "local" {
    type master;
    file "/etc/bind/db.local";
};
EOF
    destination = "/etc/bind/named.conf.local"

    connection {
      type     = "ssh"
      user     = "root"
      password = "<CONTAINER_ROOT_PASSWORD>"
      host     = self.ipv4_address
      port     = 22
    }
  }

  # DNS zone file configuration with required DNS entries
  provisioner "file" {
    content = <<EOF
\$TTL 86400
@   IN  SOA dns.local. admin.local. (
          1 ; Serial
     604800 ; Refresh
      86400 ; Retry
    2419200 ; Expire
     604800 ) ; Negative Cache TTL
;
@               IN  NS      dns.local.
proxmox-mgmt    IN  A       192.168.177.7
proxmox-bckup   IN  A       192.168.177.129
clone_master    IN  A       192.168.178.50
automation      IN  A       192.168.178.70
ztrust-auth     IN  A       192.168.178.80
nas-proxy       IN  A       192.168.178.100
opnsense        IN  A       192.168.178.31
bc-node1        IN  A       192.168.178.120
bc-node2        IN  A       192.168.178.121
bc-node3        IN  A       192.168.178.123
nas             IN  A       192.168.198.8
monitor         IN  A       192.168.178.140
dns             IN  A       192.168.178.72
ntp             IN  A       192.168.178.74
EOF
    destination = "/etc/bind/db.local"

    connection {
      type     = "ssh"
      user     = "root"
      password = "<CONTAINER_ROOT_PASSWORD>"
      host     = self.ipv4_address
      port     = 22
    }
  }

  # Restarting Bind9 service to apply DNS configurations
  provisioner "remote-exec" {
    inline = [
      "systemctl restart bind9"
    ]

    connection {
      type     = "ssh"
      user     = "root"
      password = "<CONTAINER_ROOT_PASSWORD>"
      host     = self.ipv4_address
      port     = 22
    }
  }
}

output "bind_server_ip" {
  value = proxmox_lxc.bind_server.ipv4_address
}