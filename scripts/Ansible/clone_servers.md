# Ansible Script Explanation: Cloning VMs for ZTA Blockchain Project

## **Overview**
This Ansible playbook automates the cloning of a master virtual machine (VM) in Proxmox for a Zero Trust Architecture (ZTA) blockchain project. The playbook creates multiple VMs, assigns them to specific resource pools, and stores them in a designated Proxmox storage location.

### **Key Features**
- Stops a master VM (`ID 104`) before cloning.
- Uses full cloning to create independent VMs.
- Assigns each VM to a specific resource pool for organization.
- Outputs detailed clone results for verification.

---

## **Script Sections**

### 1. **Playbook Header**
```yaml
- name: Clone multiple Proxmox VMs for ZTA Blockchain Project
  hosts: localhost
  vars_files:
    - group_vars/all.yml
  gather_facts: no
  collections:
    - community.general
```
- **Purpose**: Defines the playbook's name, hosts, variable files, and required collections.
- **Hosts**: Targets `localhost` because Proxmox tasks are executed via the Proxmox API, not directly on hosts.
- **Variables File**: External variables are loaded from `group_vars/all.yml` for modularity.
- **Collections**: Uses the `community.general` collection for Proxmox-specific tasks.
- **Gather Facts**: Disabled since local facts aren't needed.

---

### 2. **Variables**
```yaml
vars:
  proxmox_validate_certs: false
  master_vm_id: 104
  clone: "MasterCloneOra9"
  vm_storage: "vm_storage"
  node: "{{ node }}"
  api_host: "{{ api_host }}"
  api_user: "{{ api_user }}"
  api_password: "{{ api_password }}"
  vm_definitions:
    - { name: ztrust-auth, pool: ZTA_Access, new_id: "210" }
    - { name: nas-proxy, pool: ZTA_Access, new_id: "211" }
    # More definitions...
```
- **Proxmox Variables**: Define connection settings, such as API credentials (`api_host`, `api_user`, `api_password`).
- **VM Configuration**:
  - `master_vm_id`: ID of the master VM to clone.
  - `clone`: Base name for cloned VMs.
  - `vm_storage`: Target storage for cloned VMs.
  - `vm_definitions`: A list of VM configurations, including:
    - `name`: Name of the new VM.
    - `pool`: Proxmox resource pool for organizing VMs.
    - `new_id`: Unique ID for the new VM.

---

### 3. **Tasks**

#### **a. Stop Master VM**
```yaml
- name: Stop the master VM before cloning
  community.general.proxmox_kvm:
    api_host: "{{ api_host }}"
    api_user: "{{ api_user }}"
    api_password: "{{ api_password }}"
    node: "{{ node }}"
    vmid: "{{ master_vm_id }}"
    state: stopped
```
- Ensures the master VM is stopped before cloning to prevent issues with disk state.

#### **b. Clone VMs**
```yaml
- name: Clone VMs from the master VM
  community.general.proxmox_kvm:
    api_host: "{{ api_host }}"
    api_user: "{{ api_user }}"
    api_password: "{{ api_password }}"
    node: "{{ node }}"
    newid: "{{ item.new_id }}"
    clone: "{{ clone }}"
    vmid: "{{ master_vm_id }}"
    name: "{{ item.name }}"
    pool: "{{ item.pool }}"
    full: true
    storage: "{{ vm_storage }}"
  loop: "{{ vm_definitions }}"
  register: clone_results
```
- Iterates over `vm_definitions` to create clones of the master VM.
- Key parameters:
  - **`newid`**: Sets a unique ID for each VM.
  - **`name`**: Assigns a human-readable name to the VM.
  - **`pool`**: Specifies the resource pool for each VM.
  - **`storage`**: Targets the defined storage.
  - **`full`**: Ensures a full clone (creates an independent VM).

#### **c. Display Results**
```yaml
- name: Message result of each VM clone
  ansible.builtin.debug:
    msg: >
      VM '{{ item.item.name }}' clone result: {{ item | json_query('changed') | ternary("Success", "Failed") }}
  loop: "{{ clone_results.results }}"
  loop_control:
    label: "{{ item.item.name }}"
```
- Displays a success or failure message for each clone operation.
- Uses the `clone_results` registered variable to report the status.

---

## **External Variable File (`group_vars/all.yml`)**
### Example Variables
```yaml
api_host: "192.168.1.10"    # Proxmox server IP or hostname
api_user: "root@pam"        # Proxmox root user with PAM authentication
api_password: "secure_pass" # Secure API password
node: "pve1"                # Node where VMs are managed
```

---

## **Workflow Summary**
1. **Preparation**:
   - Stop the master VM (`ID 104`).
   - Ensure proper API credentials and external variables are configured.

2. **Cloning Process**:
   - Iterate through `vm_definitions` to clone and configure each VM.
   - Assign each VM to a Proxmox resource pool and storage.

3. **Validation**:
   - Display results for each clone operation to confirm success or identify issues.

---

## **Execution Notes**
- **Prerequisites**:
  - Proxmox API must be accessible.
  - API user requires sufficient permissions (e.g., VM administration).
  - Validate external variables (`group_vars/all.yml`).

- **Testing**:
  - Test the playbook in a development environment to ensure proper VM creation.
  - Review resource allocation (e.g., storage and memory) post-cloning.

- **Security**:
  - Replace `proxmox_validate_certs: false` with `true` in production for secure API calls.
  - Use encrypted secrets (e.g., Ansible Vault) for sensitive credentials.

--- 

This script is a modular and repeatable solution tailored for ZTA blockchain projects, ensuring a streamlined VM creation process.
