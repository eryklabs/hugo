---
title: "Self-Hosted Joplin Server"
date: 2025-10-17T12:26:32-07:00
draft: false
summary: "Private, self-hosted Joplin Server running on Debian inside Proxmox for secure note synchronization"
tech: ["joplin", "proxmox", "debian", "linux"]
tags: ["joplin", "self-hosted", "homelab", "proxmox"]
role: "Owner / Operator"
showtoc: true
links:
  repo: ""
  demo: ""
cover:
  image: "/images/joplin/joplin_logo.png"
  alt: "Joplin running on a homelab as a central node"
  caption: "Private Joplin Server hosted on sv-001"
  relative: false
---

## 🎯 Objective

Deploy a **fully private, self-hosted Joplin Server** to synchronize notes across multiple personal devices without relying on third-party cloud providers.

Primary goals:

- Full data ownership  
- End-to-end control of infrastructure  
- Long-term reliability with minimal maintenance  
- Clean separation between hypervisor and application services  

---

## 🔧 Environment / Tools

| Component | Purpose |
|---------|--------|
| **HP EliteDesk 800 G4 Mini (i7-8700T, 64 GB RAM)** | Physical host (sv-001) |
| **Proxmox VE** | Bare-metal hypervisor |
| **Debian (VM)** | Dedicated service host OS |
| **Joplin Server** | Private note synchronization backend |
| **Python 3.11** | Automation, scripting, and tooling |
| **Wireshark** | Network inspection and troubleshooting |

---

## 📐 Architecture & Methodology

### 1. Proxmox (Bare Metal)
- Installed directly on sv-001
- Used strictly as a hypervisor
- No application services run on the host itself

### 2. Debian Virtual Machine
- Created and managed via Proxmox
- Acts as an isolated service container
- Snapshots and backups handled at VM level

### 3. Joplin Server Deployment
- Installed inside the Debian VM
- Used exclusively for personal note synchronization
- Syncs multiple devices (desktop + mobile)
- No dependency on Joplin Cloud or third-party storage

### 4. Network & Security
- Service isolation via VM boundaries
- Network traffic validated during setup using Wireshark
- Designed to later integrate VPN-only access

---

## 🔎 Results

| Item | Status |
|------|--------|
| Proxmox installed and stable | ✅ |
| Debian VM provisioned | ✅ |
| Joplin Server operational | ✅ |
| Multi-device sync verified | ✅ |

---

## 💡 Lessons Learned

- Running services inside a VM dramatically simplifies recovery and migration.
- Proxmox snapshots provide a clean rollback strategy before upgrades.
- Self-hosting Joplin removes vendor lock-in and long-term pricing risk.
- Clear separation between **hypervisor**, **OS**, and **application** reduces operational mistakes.

---

## ➡️ Next Steps

- Automated VM backups to NAS-001
- VPN-only access for Joplin Server
- Hardening Debian (firewall rules, SSH lockdown)
- Monitoring uptime and resource usage
- Optional integration with additional self-hosted services

---

## 📍 References

- https://joplinapp.org/help/
- https://github.com/laurent22/joplin
- https://pve.proxmox.com/wiki/Main_Page
