# Network Diagram for Blockchain ZTA Project

```mermaid
graph TD;
  
    subgraph Network_Services
        dns["DNS Server (dns.local)"]
        ntp["NTP Server (ntp.local)"]
    end
    
    subgraph Proxmox_Infrastructure
        proxmox["Proxmox Management (proxmox-mgmt.local)"]
    end
    
    subgraph Orchestration
        automation["Automation Server (automation.local)"]
    end

    subgraph Zero_Trust_Architecture
        ztrust["Zero Trust Auth Server (ztrust-auth.local)"]
        nas_proxy["NAS Proxy Server (nas-proxy.local)"]
        opnsense["OPNSense Firewall (opnsense.local)"]
    end

    subgraph Blockchain_Network
        bc1["Blockchain Node 1 (bc-node1.local)"]
        bc2["Blockchain Node 2 (bc-node2.local)"]
        bc3["Blockchain Node 3 (bc-node3.local)"]
    end

    subgraph NAS_and_Monitoring
        nas["NAS Server (nas.local)"]
        monitoring["Monitoring Server (monitor.local)"]
    end
    
    %% Connections
    proxmox --> automation
    automation --> ztrust
    ztrust -->|Access Requests| nas_proxy
    nas_proxy -->|File Access| nas
    ztrust -->|Blockchain Verification| bc1
    ztrust -->|Blockchain Verification| bc2
    ztrust -->|Blockchain Verification| bc3
    opnsense --> nas_proxy
    opnsense --> ztrust
    opnsense --> nas
    bc1 --> dns
    bc2 --> dns
    bc3 --> dns
    nas_proxy --> dns
    automation --> dns
    nas --> monitoring
    dns --> ntp
```

# Network Diagram Legend for Blockchain ZTA Project

<div align="center">

| **Server Name**           | **Category**                | **Network**         | **IP Address** |
|---------------------------|-----------------------------|---------------------|----------------|
| `proxmox-mgmt.local`      |Virtualization Host          | Management Network  | [To be filled] |
| `automation.local`        | Orchestration               | Management Network  | [To be filled] |
| `ztrust-auth.local`       | ZTA - Access Control        | ZTA Network         | [To be filled] |
| `nas-proxy.local`         | ZTA - Access Proxy          | ZTA Network         | [To be filled] |
| `opnsense.local`          | Network Security            | All Networks        | [To be filled] |
| `bc-node1.local`          | Blockchain Network          | Blockchain Network  | [To be filled] |
| `bc-node2.local`          | Blockchain Network          | Blockchain Network  | [To be filled] |
| `bc-node3.local`          | Blockchain Network          | Blockchain Network  | [To be filled] |
| `nas.local`               | File Storage                | Storage Network     | [To be filled] |
| `monitor.local`           | Monitoring and Logging      | Management Network  | [To be filled] |
| `dns.local`               | Network Services            | Management Network  | [To be filled] |
| `ntp.local`               | Network Services            | Management Network  | [To be filled] |

</div>

---

## Network Assignments
- **Management Network**: Used for Proxmox management, orchestration, and general administrative functions.
- **ZTA Network**: Dedicated network for Zero Trust Architecture services, isolating access control and authentication.
- **Blockchain Network**: Network dedicated to blockchain nodes to handle access verification, minimizing external traffic.
- **Storage Network**: Network solely for the NAS, access

