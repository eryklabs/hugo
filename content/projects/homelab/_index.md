---
title: "Homelab"
date: 2025-10-17T12:26:32-07:00
draft: false
summary: "Homelab for learning cybersecurity, networking, and experimenting"
tech: ["homelab", "go", "splunk", "python", "joplin", "wireguard", "proxmox", "debian"]
tags: ["homelab"]
role: ""
links:
  repo: ""
  demo: ""
cover:
  image: "/images/homelab/elitedesk-g4-800-mini-pc.jpg"     # put alongside index.md
  caption: ""
---

## 🎯 Objective
To create a functional homelab not only for learning, but for practical uses in security, home networking, and real-world applications.

---

## 🔧 Environment / Tools

*List of system setup and versions:*

| Component | Purpose |
|------------|----------|
| HP EliteDesk 800 G4 Mini i7-8700T 2.4GHz 64GB RAM | Main Server |
| Python 3.11 | Scripting and data parsing |
| Proxmox VE | Bare-metal hypervisor |
| Debian (VM) | Service host OS |
| Joplin Server | Self-hosted note sync backend |
| Wireshark | Network packet inspection |

---

## 📐 Methodology

*Researching and implementing the following services:*

1. Proxmox
   - Installed as bare-metal hypervisor on sv-001

2. Debian Virtual Machine
   - Created and managed via Proxmox
   - Used as an isolated service host

3. Joplin Server
   - Deployed inside the Debian VM
   - Used for private, self-hosted note synchronization

4. Pi-Hole
	- Blocking ads

  

## 🔎 Results

*Summary of measurable output, screenshots, and/or outcomes:*

| Item | Status |
|------|--------|
| Proxmox installed | ✅ |
| Debian VM running | ✅ |
| Joplin server syncing | ✅ |


## 💡 Lessons Learned

- Keeping services off the Proxmox host reduces risk and simplifies recovery.
- VM isolation makes backups, snapshots, and migrations safer.
- Self-hosting Joplin removes reliance on third-party sync providers.


## ➡️ Next Steps

*What to add, automate, and/or scale:*

- Automate query generation with Python.

- Integrate with an alerting system.

- Add automated backups of the Debian VM.
- Secure remote access to sv-001 (VPN or SSH hardening).
- Integrate NAS-001 for storage and backups.

## 📍 References

- [Splunk BOTS v3 Dataset Docs](https://github.com/splunk/botsv3)

- [Wireshark Filters Cheat Sheet](https://wiki.wireshark.org/DisplayFilters)



<!--- optional for use

---
<br/>

## 📝️ Notes

| Topic | Explanation |
|--------|-------------|
| **`tech:`** | purely informational; use it to display your stack (e.g., Splunk, Docker).  It’s not a taxonomy unless you define it in `hugo.toml`. |
| **`tags:`** | these appear under `/tags/.../` and can group all templates, projects, etc. |
| **`ShowToc:`** | shows an auto-generated table of contents. |
| **`Images:`** | store them in `/static/images/` and reference with `/images/...`. |

---

## ✅ Result

When you run:

```bash
hugo server -D
```

You’ll get a proper **project page with TOC, cover image, and summary**, and it will also appear under:

/tags/template/
/categories/projects/

if `draft: false`.


--->
