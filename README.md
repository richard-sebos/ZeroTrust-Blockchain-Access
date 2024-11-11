# **Blockchain Zero Trust Access (ZTA) Project**

## Overview

The **Blockchain Zero Trust Access (ZTA)** project implements a cutting-edge security solution that leverages blockchain technology within a Zero Trust Architecture (ZTA) framework to manage secure file access on a NAS (Network-Attached Storage) system. By utilizing a permissioned blockchain network, this project verifies user identity and permissions in a decentralized and tamper-resistant way, enhancing both security and transparency. It includes automated provisioning, configuration, and access management using Terraform and Ansible, making the setup and maintenance efficient.

---

## Features

- **Blockchain-Based Access Control**: Permissioned blockchain network (e.g., Hyperledger Fabric or Ethereum) ensures decentralized and tamper-proof access verification.
- **Zero Trust Microservices**: A dedicated API verifies user requests against the blockchain for secure access to NAS files.
- **Terraform Provisioning**: Automated VM and container creation within a Proxmox Virtual Environment.
- **Ansible Configuration Management**: Centralized configuration management to apply consistent policies across all project nodes.
- **Firewall and Network Segmentation**: OPNSense firewall enforces strict network segmentation based on Zero Trust principles.
- **Secure NAS Access**: Managed access to NAS files through a proxy server that forwards only authenticated and authorized requests.
