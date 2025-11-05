---
title: "Homelab Progress Log"
date: 2025-10-22T12:47:32-07:00
draft: false
summary: "Progress Log for Homelab Build"
tech: ["progress log", "homelab"]
tags: ["homelab"]
layout: "list"
showtoc: true
role: ""
links:
  repo: ""
  demo: ""
cover:
  image: "/images/homelab/elitedesk-g4-800-mini-pc.jpg"     # put alongside index.md
  caption: ""
---

## 🌐 Overview
Tracking setup and upgrades for my EliteDesk G4 800 Mini Proxmox server.

---

### 📅 2025-11-03
- Installed 64GB Samsung RAM kit, testing memory by running **MemTest86**, which has been running for about 6 hours now.
- Researching specs for building a trueNAS server, which will work within our homelab ecosystem to supply sufficient storage. 

### 📅 2025-10-24
- Due to trend of increasing prices of most consumer goods, searching for SO-DIMM DDR4 64GB memory kit to install in the EliteDesk G4 800 as an upgrade, to support future services on the server. 
- Use high quality memory (Crucial, Samsung, Kingston, etc.)
- Test with **MemTest86** or other memory testers after installation.
- Match what the system supports: DDR4-2666 (PC4-21300) is the spec. 
- If you buy a 3200 or 3000 kit, the memory will likely downclock to 2666.
- Lower latency helps — so a “2666 CL19” or “2666 CL18” (if available) module is preferable.
- Prices have increased $20 just from earlier this week. Very steep increases in current climate. **Going with the [Samsung 64GB Orig Kit Lot (2x32GB) Memory PC4 DDR4 2666 SODIMM Laptop RAM](https://www.ebay.com/itm/357807381382)** for $200

### 📅 2025-10-22
- Attempted installation of 1TB NVMe drive for Proxmox VM storage. Need a NVME screw however, part ordered. 
- Planning to set up Pi-hole next.

### 📅 2025-10-20
- Installed Debian 13.1 ISO and configured static IP on EliteDesk.
- Verified LAN access from main PC.
- Installed Proxmox, confirmed up and running via remote access. 

### 📅 2025-10-15
- EliteDesk up and running and connected to local LAN