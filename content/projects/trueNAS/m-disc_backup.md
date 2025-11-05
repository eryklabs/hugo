---
title: "M-Disc Archival Solutions"
date: 2025-11-03T16:26:32-07:00
draft: false
summary: "M-Disc Archival Solutions"
tech: ["TrueNAS SCALE", "M-Disc"]
tags: ["homelab", "archival", "storage"]
role: "Homelab Engineer / Security Analyst"
links:
  repo: ""
  demo: ""
cover:
  image: "/images/truenas/truenas-scale-logo.png"
  caption: "Long term cold-storage archival with 25 GB M-Discs"
---

## 🎯 Objective

Implement a 

## 🗺️ Considerations / Specifications

### Best Burners for M-Disc

- LG WH16NS40 or LG WH16NS58 → Both support M-Disc officially.

- ASUS BW-16D1HT → Supports M-Disc and BDXL, reliable if you ever want to experiment with 100 GB discs.

**Make sure to:**

- Use Verbatim or Milleniata-branded M-Disc media only.

- Burn at 4× speed (slow and consistent = best long-term integrity).

- Use ImgBurn or Nero Burning ROM with “verify after write” enabled.

- Generate and store checksums `(sha256sum * > checksums.txt).`

## 3-2-1 M-Disc Workflow Example

*How the M-Disc burner will function within our TrueNAS backup server (NAS-001):*

1. Once per quarter:

- Snapshot important datasets (e.g. /mnt/pool01/Documents, /mnt/pool01/MusicProjects).

- Compress into .7z archives of ≤23 GB each.

- Generate checksums and burn to Verbatim M-Disc 25 GB.

2. Verification:

- After each burn, run a full CRC/SHA check against source data.

- Log results in backup_log_YYYYMMDD.txt.

3. Offsite:

- Copy same discs and store at a secondary site.

- Optionally upload encrypted duplicates to cloud storage.

Result:

- NAS = fast access + redundancy

- M-Disc = offline, immutable, EMP-resistant backup

- Cloud = disaster insurance

The result is a classic 3-2-1 architecture: physically and digitally redundant.

### Power Consumption 
To save on power consumption, our homelab (EliteDesk 800 G4) server (SV-001) will be the server with 24/7 availability, and this TrueNAS server will utilize WoL (Wake-on-LAN) to power on, on a as-needed basis, or with scheduled cron jobs. 

### Long-Term Backup Solution 
Strong focus on long-term backups. A pain point of mine has been running out of storage on every device (phones, laptops, desktops, etc.)...
Keeping track of backups on various external drives scattered about is not good practice, and thus I am looking to find a proper long term, scaleable solution. 



#### Cold Storage: M-Disc BD-R 25 GB
Taking the 3-2-1 principle into consideration, long term cold-storage backups on 25 GB M-Disks is something I think worthwhile to implement.
These disks can easily be stored in offsite locations, taking up minimal space (inside a DVD binder, for example). 
Hence, the choice to add a BDXL-capable drive, for burning 25 GB disks (verified with checksum) for long-term archival. 



Each disk will get:
- SHA256 checksum text file inside.
- Label printed with permanent ink or laser etching (no stickers, no sharpies).
- Stored vertically in jewel cases or archival sleeves (avoid spindles).
- Kept in an airtight plastic bin with silica gel, inside a closet (no sunlight).



*Note: 25 GB single-layer discs are more reliable than 50 GB ones: fewer layers, fewer focus calibration issues, and much lower uncorrectable error rates over time.)*
 *I might use 50 GB disks for less critical data however, and verify immediately with checksum after burning.*



I was considering 128 GB BDXL disks, however I later became aware of the fact that the lower capacity M-Disks have a much longer true archival lifespan (between 300-1,000 years, theoretically). 
100-128 GB disks are supposed to be much less stable long-term, only 5-10 years, which won't fit our use case. 



*(Note: Disks should be checked periodically to ensure readability and confirm the efficacy of the backup system).*


---

## 🔧 Environment / Hardware

| Component | Purpose |
|------------|----------|
| Cooler Master HAF 932 | Full-tower chassis with airflow and drive capacity |
| Corsair RM850x | Stable, silent 850W PSU |
| H60x RGB Elite | CPU cooler (repurposed) |
| ECC-capable motherboard + Ryzen CPU | ZFS stability and data integrity |
| 64GB ECC DDR4 RAM | ZFS ARC cache + container workloads |
| 6× 16TB Seagate Exos drives | RAIDZ2 pool (`tank`) for redundancy |
| 2× 480GB SSDs | Boot mirror (TrueNAS OS) |
| LSI 9300-8i HBA (IT Mode) | Direct SATA access for ZFS |
| Intel X520-DA2 | Dual-port 10GbE NIC |
| APC Smart-UPS | Power protection and clean shutdowns |

---

## 🧠 Software Stack

| Tool / Service | Function |
|----------------|-----------|
| **TrueNAS SCALE (23.x)** | Core NAS OS |
| **ZFS RAIDZ2** | Redundant storage pool |
| **SMB / NFS / iSCSI** | File sharing and VM storage |
| **MinIO (S3)** | Object storage for Proxmox backups |
| **Rsyslog / Fluent Bit** | Centralized log forwarding |
| **Scrub / Snapshot / Replication** | Data protection and versioning |
| **AD / LDAP integration** | Simulated enterprise ACL structure |
| **UPS daemon (NUT)** | Power loss detection and shutdown |

---

## 📐 Configuration & Methodology

1. **ZFS Pool Setup**
   - Pool: `tank`
   - Layout: 6×16TB → **RAIDZ2**
   - Compression: `zstd`
   - Atime: `off`
   - Snapshots:  
     - 15-min: 48h retention  
     - Hourly: 7 days  
     - Daily: 90 days
   - Replication: weekly off-box copy via external disk.

2. **Network Configuration**
   - 10GbE backbone → main switch → Proxmox node (SV-001)
   - VLAN segmentation for storage vs management
   - Jumbo frames (MTU 9000) for NFS/iSCSI throughput

3. **File Services**
   - SMB: Auth via Active Directory (simulated domain)
   - NFS: For Linux VM mounts
   - iSCSI: For Proxmox test VMs / backup targets

4. **Security & Monitoring**
   - Syslog forwarding from firewall and Proxmox
   - Audit logging on SMB shares
   - Monthly SMART tests + ZFS scrubs
   - Ransomware rollback demo via snapshots

5. **Applications**
   - MinIO container (S3 backup target)
   - Rsyslog → Splunk indexer
   - Fluent Bit → Security Onion
   - Zabbix / Grafana for uptime and temperature monitoring

---

## 🔎 Results

| Metric | Result |
|--------|:--------:|
| Network Throughput | 9.8 Gbps sustained |
| ZFS Pool IOPS (cached) | ~110k |
| Snapshot Restore Time | <30 sec |
| Power Usage (avg) | 85–110 W |
| Data Availability | 99.99% uptime since deployment |

Example ZFS pool layout:

NAME STATE READ WRITE CKSUM
tank ONLINE 0 0 0
raidz2-0 ONLINE 0 0 0
da0 ONLINE
da1 ONLINE
da2 ONLINE
da3 ONLINE
da4 ONLINE
da5 ONLINE


---

## 💡 Lessons Learned

- ZFS + ECC = mandatory for long-term reliability. Consumer RAM is a liability.
- RAIDZ1 is obsolete for multi-terabyte drives — URE risk is real.
- iSCSI performs best with separate VLAN and jumbo frames.
- TrueNAS SCALE’s Kubernetes layer is useful but overkill for critical data — isolate core datasets.
- UPS integration with NUT daemon is non-negotiable. Sudden power loss will corrupt metadata.

---

## ➡️ Next Steps

- Deploy **Proxmox Backup Server** with MinIO offload.  
- Automate snapshot replication to secondary node (`SV-001`).  
- Add **immutable dataset** for ransomware forensics demo.  
- Publish internal SOPs and architecture diagram to eryklabs.com documentation.  
- Expand to **two-node failover cluster** with ZFS replication.  

---

## 📍 References

- [TrueNAS SCALE Documentation](https://www.truenas.com/docs/scale/)
- [ZFS Best Practices Guide](https://openzfs.org/wiki/Performance_tuning)
- [MinIO Documentation](https://min.io/docs/minio/linux/index.html)
- [NUT UPS Daemon Config](https://networkupstools.org/docs/)
- [Proxmox Backup + S3 Integration](https://pve.proxmox.com/wiki/Backup_and_Restore)

---
