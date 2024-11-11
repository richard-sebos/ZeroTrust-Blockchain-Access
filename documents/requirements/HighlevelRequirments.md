# Highlevel Requirements
Creating a blockchain-based Zero Trust Architecture (ZTA) project to validate users accessing files on a NAS system is a unique and modern approach. Here's a breakdown of high-level requirements and key phases for this project, taking into account the hardware you have:

### 1. **Core Objective and Scope**
   - **Objective**: Establish a secure, blockchain-enabled Zero Trust Architecture (ZTA) for validating user access to files on a NAS.
   - **Scope**: Implement infrastructure as code (IaC) using Terraform for VM/container provisioning and Ansible for configuration management. Utilize a blockchain network for user verification and integrate with OPNSense for network security.

### 2. **Components & Roles**
   - **Development Laptop**: Primary workstation for writing code, managing Terraform, Ansible, and possibly interacting with the blockchain.
   - **Proxmox VE Server**: Hosting VMs/containers required for this project.
   - **Proxmox BS Server**: Provide backup solutions, potentially using it for disaster recovery or snapshotting critical configurations.
   - **OPNSense Firewall**: Network security, segmenting access between the ZTA components and external traffic.
   - **Debian Mini PC Desktop**: Acts as an additional node for blockchain or ZTA controller if required.
   - **Debian Server (NAS)**: Holds the files for access control testing.

### 3. **High-Level Requirements**

#### A. **Network and Infrastructure Setup**
   1. **Terraform Installation and Configuration**
      - Install and configure Terraform on the development laptop.
      - Create Terraform scripts to provision VMs and containers on Proxmox VE, defining resources for each ZTA component.

   2. **Networking Configurations**
      - Configure networking within Proxmox for communication among VMs/containers.
      - Configure OPNSense firewall policies to enforce segmentation and define access rules.
      - Set up VLANs or subnets to isolate traffic between the blockchain validation system, NAS, and user access points.

   3. **Ansible Configuration Management**
      - Install Ansible on the development laptop.
      - Create playbooks for configuring OS, installing required services, and applying security updates across all VMs/containers.

#### B. **Blockchain Network Setup**
   - **Blockchain Framework**: Choose a lightweight, permissioned blockchain solution (e.g., Hyperledger Fabric, Ethereum Private Network) that supports smart contracts.
   - **Blockchain Node Deployment**:
      - Deploy at least two nodes within the VMs/containers in Proxmox VE to create a basic blockchain network. Use one node on the Debian Mini PC as an external verifier node.
      - Configure the blockchain network to manage identity and access records for the ZTA.
   - **Smart Contract Development**:
      - Develop a smart contract to store and validate access permissions.
      - Define roles and permissions within the smart contract that verify access to specific files or directories on the NAS.

#### C. **Zero Trust Architecture (ZTA) Implementation**
   1. **Identity Verification and Access Policy**
      - Configure blockchain-based identity verification.
      - Develop a Zero Trust microservice or API that interacts with the blockchain, checking identity and access policies before allowing access.
   2. **Integration with OPNSense**:
      - Set up OPNSense to log and monitor access requests.
      - Configure OPNSense to deny or redirect unauthorized access attempts based on Zero Trust principles.
      - Enable logging in OPNSense and set up alerts for any access policy violations.

#### D. **File Access Control via NAS**
   - **NAS Configuration for ZTA**:
      - Configure the NAS (Debian Server) to restrict file access and to be accessible only through validated requests.
      - Install and configure an authentication module on the NAS that checks with the blockchain ZTA service before granting access.

   - **Secure Data Transmission**:
      - Set up SSH or a secure file transfer protocol on the NAS.
      - Use OPNSense to enforce TLS or VPN requirements for all NAS access traffic.

#### E. **Monitoring, Logging, and Reporting**
   - **System Monitoring**:
      - Deploy monitoring tools (e.g., Grafana, Prometheus) to track resource usage on Proxmox, blockchain nodes, and the NAS.
   - **Access Logging**:
      - Log access attempts on the blockchain, NAS, and OPNSense firewall.
   - **Audit Trail and Compliance**:
      - Develop a dashboard to review access logs and blockchain-based verification attempts.
      - Set up automated alerts for unauthorized access attempts or policy violations.

### 4. **Development and Testing Workflow**

   - **Provisioning Workflow**:
      - Use Terraform for VM/container provisioning in Proxmox.
      - Automate configuration with Ansible, ensuring each component (e.g., blockchain nodes, ZTA microservice, NAS integration) is configured and hardened.

   - **Blockchain Validation Workflow**:
      - Test blockchain transactions that handle access control, ensuring smart contract logic properly validates access.
      - Test response times and error handling when querying the blockchain for permissions.

   - **Access Control Testing**:
      - Test user access requests to the NAS and validate responses based on identity verification and policy checks.

   - **Security Testing**:
      - Conduct penetration testing on the network setup and access control mechanisms.
      - Use OPNSense firewall logs to analyze traffic and validate ZTA enforcement policies.

### 5. **Documentation & Maintenance**

   - **Documentation**:
      - Maintain Terraform and Ansible scripts with inline comments.
      - Document the architecture, smart contracts, and ZTA access policies.

   - **Backup and Recovery**:
      - Utilize Proxmox BS for backup and snapshots of critical VMs/containers.
      - Set up automated backups of the blockchain data and NAS configurations.
