---
title: "TrueNAS SCALE Server (NAS-001)"
date: 2025-11-03T12:26:32-07:00
draft: false
summary: "ZFS-based NAS built for cybersecurity, backups, and homelab infrastructure"
tech: ["TrueNAS SCALE", "ZFS", "Proxmox", "Splunk", "MinIO"]
tags: ["homelab", "cybersecurity", "storage"]
role: "Homelab Engineer / Security Analyst"
links:
  repo: ""
  demo: ""
cover:
  image: "/images/truenas/truenas-scale-logo.png"
  caption: "TrueNAS SCALE storage server in Cooler Master HAF 932 case"
---

## 🎯 Objective

Build a **TrueNAS SCALE** system as a central storage and cybersecurity lab node — designed to provide reliable ZFS-based storage, snapshots, and replication across my network.  

The server acts as a backbone for my **Proxmox cluster**, **Splunk**, **Security Onion**, and **log aggregation**, while simulating enterprise-level NAS operations and access control (SMB, NFS, S3).


<br/>

---

<br/>

## 🗺️ Considerations / Specifications

### HDD Capacity in the Case I'm Using (Cooler Master HAF 932)
The **Cooler Master HAF 932** has:
- 5 x 3.5" bays at the bottom (to hold our HDD NAS hard drives)
- 5 x 5.25" bays above that (however **one** of those 5.25" bays will be occupied by a BDXL-capable drive). 

Utilizing a **3 x 5.25" to 5 x 3.5" Hot-Swap Cage**, and a **5.25" to 3.5" adapter** (both described below), we effectively will increase the HAF 932's
capacity to **11 x 3.5" HDDs**. 

<span style="color: #00d28f">This will utilize **all available free space** within the HAF 932 case, to hold:</span> 

- **1** x 5.25" BDXL-capable drive
- **11** x 3.5" NAS-grade HDD's 

<br/>



### 5.25" to 3.5" Hot-Swap Cage

How are we going to fit 3.5" HDD Hard Drives where the 5.25" bays are (where optical drives typically go)?

Before researching NAS's, I didn't know there was a solution for this. They're called "Hot Swap Cages". 

They're basically adapters that convert 3 x 5.25" bays into a space for 5 x 3.5" devices (typically HDD's). 

There's also 2 x 5.25" cages (that fits 3 x 3.5" devices), and adapters that can convert one 5.25" bay to one 3.5" slot.

<br/>

---

### Power Consumption 
To save on power consumption, our homelab <span style="color: #00d28f">(EliteDesk 800 G4) server (sv-001)</span> will be the server with <span style="color: #00d28f">24/7 availability</span>, and this TrueNAS server will utilize WoL (Wake-on-LAN) to power on, on a as-needed basis, or with scheduled cron jobs. 

The <span style="color: #00d28f">power savings</span> will be substantial, given electricity prices in our location. 

It's the difference between paying about **$10 a month** in electricity, to power on once or twice a week for a few hours... versus **$500+ / yr**, for keeping it on 24/7. 

<br/>

---

### Long-Term Backup Solution 
Strong focus on long-term backups. A pain point of mine has been running out of storage on every device (phones, laptops, desktops, etc.)...
Keeping track of backups on various external drives scattered about is not good practice, and thus I am looking to find a proper long term, scaleable solution. 

<br/>



#### [<span style="color: #00d28f;">Cold Storage: M-Disc BD-R 25 GB</span>]({{< ref "projects/truenas/m-disc.md" >}})
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

<br/>

---

<br/>

### Why RAIDZ2 Over Other Options? 

RAIDZ2 is a ZFS parity level similar to RAID-6—it can survive two drive failures without data loss (It’s extremely robust). 

<span style="color: #00d28f;">**Here's a table which shows why RAIDZ2 is the "sweet spot" for most TrueNAS builds:**</span>

| Level	| Tolerance	| Efficiency	| Notes |
|------------|----------|----------|----------|
RAIDZ1	|1 disk fails|	~N-1 drives usable|	Not safe with modern large disks; rebuild risk too high|
RAIDZ2	|2 disks fail|	~N-2 drives usable|	Best trade-off between safety and capacity|
RAIDZ3	|3 disks fail|	~N-3 drives usable|	Good for mission-critical or 12-16+ disk arrays|

***RAIDZ2 is ideal if you’re using 6–10 drives. Once you hit 12+ drives, RAIDZ3 becomes worth considering.***

<br/>

***Note:***
- Capacity needs to be planned up front, due to the face you can't add drives to an existing RAIDZ vdev later. (You can only add *new vdevs*, which are groups of drives). 
- Data is striped across all vdevs. Mixing mismatched vdevs (different sizes or layouts) later leads to performance imbalance and wasted space.

<br/>

#### When Mirrors, RAIDZ1, or Other Setups Make Sense

The right RAID setup depends entirely on what you’re building the system for — disk size doesn’t really matter.
If you’re running **virtual machines**, go with mirrors.
If you’re building **long-term archival storage**, go with a wide RAIDZ2.
For an **active file share**, either mirrors or a smaller Z2 setup works fine.

A 3-wide RAIDZ1 can make sense if you’re trying to squeeze more usable space out of SSDs.
A **5–7-wide RAIDZ2** is a good middle ground, while **11–12-wide Z2** is about as far as you want to push it.

---

<br/>

### Definitions

<span style="color: #00d28f">***HBA***</span> = Host Bus Adapter
- Dedicated PCIe card designed for enterprise-level storage connectivity. 

<span style="color: #00d28f">***SLOG***</span> = Separate Intent Log 
 - Optional dedicated device (usually a fast SSD) used to handle synchronous writes more safely and efficiently.
 - ZFS has a built-in write log called the ZIL (ZFS Intent Log), which temporarily records synchronous write operations 
 (writes that must be confirmed as “safely stored” before the system can continue).
 - Normally, the ZIL lives on your main pool disks (slower HDD drives)... so if you add a SLOG device, it moves the ZIL off those slower disks 
 onto a separate, faster SSD, highly improving performance for certain workloads.



<br/>

---

<br/>

### Considerations

#### Capacity 

Once your pool hits around **60–70% full**, it’s time to either add another `vdev` or create a new pool with one.
ZFS doesn’t rebalance data across `vdev`'s, so you need to leave some free space on the older one — otherwise, it’ll start throwing data wherever it can.
For long-term health and performance, never let your pool go past 80% full.

<br/>

#### Mirrored Boot Pool

For the boot pool, it’s generally best to avoid NVMe drives since TrueNAS barely reads from the boot device after startup, 
and you’ll want to keep your M.2 slots free for cache or VMs. 

Instead, I'll be using two small enterprise-grade SATA SSDs (like Intel DC S3510 or S3610) in a mirrored ZFS boot pool. 
These drives have **power-loss protection (PLP)** and higher endurance, which prevents corruption during sudden power loss (a real risk on consumer SSDs).

This setup gives true redundancy, stable performance, and long-term reliability, while leaving the high-speed slots open for 
important roles later (L2ARC, SLOG, or app storage). It’s the simplest and most robust option for a Ryzen-based NAS like this one.

<br/>

**But isn't a mirrored boot superfluous if I'm using a UPS (Uninterruptible Power Supply) to power my NAS?**

While a UPS protects against external power loss, it doesn't protect against sudden system crashes, controller hangs, 
user error (accidental power-off), etc.

If power is cut mid-write, consumer SSDs without PLP can lose in-flight data still sitting in volatile DRAM cache. 
Enterprise SSDs with PLP finish flushing that cache to NAND using capacitors.

Used enterprise SATA SSDs (such as the Intel DC S3510) can be found for quite cheap in the second-hand market,
so it's not an expensive decision to make, for this build. 



<br/>

---

<br/>


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
- [Proxmox Backup + S3 Integration](https://pve.proxmox.com/wiki/Backup_and_Restore)
- [Choosing The BEST Drive Layout For Your NAS (Hardware Haven)](https://www.youtube.com/watch?v=ykhaXo6m-04)
- [ZFS: You should use mirror vdevs, not RAIDZ.](https://jrs-s.net/2015/02/06/zfs-you-should-use-mirror-vdevs-not-raidz/)
- [Things Nobody Told You About ZFS (Nex7)](https://nex7.blogspot.com/2013/03/readme1st.html)

---
