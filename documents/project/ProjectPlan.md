
# Project Plan: Blockchain-Based Zero Trust Architecture (ZTA) for NAS Access Control

## 1. Project Overview

### Objective
Establish a secure, blockchain-enabled Zero Trust Architecture (ZTA) for validating user access to files on a NAS system.

### Scope
Implement Infrastructure as Code (IaC) using Terraform for VM/container provisioning and Ansible for configuration management. Utilize a blockchain network for user verification, integrating with OPNSense for network security.

---

## 2. Project Phases and Milestones

### Phase 1: Infrastructure Setup

#### Task: Terraform & Ansible Setup

1. **Install Tools**  
   - **Objective**: Install Terraform and Ansible on the development environment to set up the IaC environment.
     - [X] Install VSCode on MacBook Air
     - Install OS
       - [ ] Download Oracle 9 Linux ISO
       - [ ] Install Oracle 9 on 
     - Install local Linux Applications
       - [ ] vim
       - [ ] Nano
       - [ ] git
      - Mount VM Storage on NAS
      - Setup git local environment
   - **Duration**: X days
  
2. **Configure Terraform for Proxmox VE**  
   - **Objective**: Set up Terraform with required Proxmox VE providers and create initial configuration files.
   - **Tasks**:
     - Install and configure Proxmox VE provider in Terraform.
     - Verify Terraform's ability to connect to Proxmox API.
   - **Duration**: 3 days

3. **Define VM Specifications in Terraform**  
   - **Objective**: Create Terraform configurations for VM/container specifications to be deployed on Proxmox VE.
   - **Tasks**:
     - Write and organize configuration files for each VM/container (e.g., blockchain nodes, NAS, microservice).
     - Define resources, networking, and firewall rules in configurations.
   - **Duration**: x days

4. **Develop Terraform Provisioning Scripts**  
   - **Objective**: Develop scripts for the automated provisioning of VMs/containers on Proxmox.
   - **Tasks**:
     - Test and refine Terraform scripts for error-free provisioning.
     - Verify successful VM/container deployment and networking configurations.
   - **Duration**: x days

5. **Install and Configure Ansible**  
   - **Objective**: Set up Ansible on the development laptop for configuration management.
   - **Tasks**:
     - Install Ansible and required plugins.
     - Test Ansible connection to the provisioned VMs/containers.
   - **Duration**: x days

6. **Develop Ansible Playbooks for Configuration Management**  
   - **Objective**: Create Ansible playbooks to automate OS setup, security configurations, and software installation on VMs/containers.
   - **Tasks**:
     - Write playbooks for OS and service installation.
     - Implement security configurations and initial firewall rules.
     - Test and refine playbooks for consistency and error handling.
   - **Duration**: x days


#### Networking and firewall 
- **Milestone 1.2**: Networking and firewall configuration on Proxmox and OPNSense.

### Phase 2: Blockchain Network Deployment
- **Milestone 2.1**: Deploy and configure blockchain nodes.
- **Milestone 2.2**: Develop and deploy smart contracts for access validation.

### Phase 3: ZTA Configuration and Integration
- **Milestone 3.1**: Identity verification microservice setup.
- **Milestone 3.2**: Integration with OPNSense for access policy enforcement.

### Phase 4: NAS Access Control and Security
- **Milestone 4.1**: NAS configuration for secure file access.
- **Milestone 4.2**: Secure data transmission setup.

### Phase 5: Testing, Monitoring, and Documentation
- **Milestone 5.1**: Complete end-to-end access control testing.
- **Milestone 5.2**: Finalize monitoring, logging, and reporting setup.
- **Milestone 5.3**: Project documentation and handover.

---

## 3. Task Breakdown by Phase

### Phase 1: Infrastructure Setup

1. **Terraform Installation and Configuration**
   - Install Terraform on the development laptop.
   - Create scripts to provision VMs/containers on Proxmox VE for each ZTA component.

2. **Networking Configurations**
   - Set up Proxmox networking and OPNSense firewall policies.
   - Define VLANs/subnets to isolate blockchain validation, NAS, and user access traffic.

3. **Ansible Configuration Management**
   - Install Ansible and create playbooks for OS and security setup across VMs/containers.

### Phase 2: Blockchain Network Deployment

1. **Blockchain Framework Selection**
   - Select a permissioned blockchain (e.g., Hyperledger Fabric, private Ethereum).

2. **Node Deployment**
   - Deploy blockchain nodes in VMs on Proxmox VE and Debian Mini PC.

3. **Smart Contract Development**
   - Write smart contracts for access permission validation.
   - Deploy contracts to blockchain nodes and configure permissions.

### Phase 3: Zero Trust Architecture (ZTA) Configuration and Integration

1. **Identity Verification Microservice**
   - Create a microservice or API for blockchain-based identity verification.
   - Configure it to check access permissions before allowing NAS access.

2. **OPNSense Integration**
   - Set up OPNSense logging and monitoring for access requests.
   - Configure OPNSense to enforce ZTA policies, denying unauthorized access.

### Phase 4: NAS Access Control and Security

1. **NAS Configuration for ZTA**
   - Configure NAS to restrict file access, checking with the blockchain-based ZTA service.
   - Install secure access protocols like SSH or secure file transfer.

2. **Secure Data Transmission**
   - Enforce TLS or VPN on OPNSense for all NAS access traffic.

### Phase 5: Testing, Monitoring, and Documentation

1. **System and Security Testing**
   - Test end-to-end access control and blockchain verification workflows.
   - Conduct penetration tests and analyze OPNSense logs.

2. **Monitoring, Logging, and Reporting**
   - Deploy monitoring tools (e.g., Grafana, Prometheus) for Proxmox, NAS, and blockchain nodes.
   - Set up a dashboard for access logging and policy violation alerts.

3. **Documentation and Backup**
   - Document the setup, configuration, and ZTA policies.
   - Set up backup and snapshotting for VMs/containers using Proxmox BS.


## 5. Resources & Roles

- **Development Laptop**: Code management, Terraform, and Ansible.
- **Proxmox VE Server**: VM and container hosting for ZTA components.
- **Proxmox BS Server**: Backup and disaster recovery.
- **OPNSense Firewall**: Network security and access enforcement.
- **Debian Mini PC Desktop**: Additional blockchain node or ZTA controller.
- **Debian NAS**: File storage with secure, verified access only.

---

## 6. Risk Management

| Risk                                 | Mitigation Strategy                                 |
|--------------------------------------|-----------------------------------------------------|
| Blockchain latency                   | Choose a lightweight, optimized framework.          |
| Unauthorized NAS access              | Implement strict firewall rules and monitoring.     |
| Configuration errors in IaC          | Test Terraform and Ansible scripts in a sandbox.    |
| Security vulnerabilities             | Conduct regular updates and vulnerability scans.    |
| Network misconfigurations            | Document and review all network settings.           |

---

## 7. Documentation & Maintenance

- **Documentation**: Inline documentation for Terraform, Ansible, and ZTA components.
- **Backup & Recovery**: Automated backups using Proxmox BS; snapshots of key configurations.
- **Audit Trail**: Maintain access logs and review access patterns for compliance.

---

## 8. Deliverables

- **IaC Scripts**: Terraform and Ansible for provisioning and configuration.
- **Blockchain Network**: Deployed nodes with smart contracts for access validation.
- **ZTA Microservice**: Identity verification microservice integrated with blockchain.
- **Secure NAS Setup**: Configured for blockchain-validated access only.
- **Documentation**: Comprehensive setup and configuration guide.

