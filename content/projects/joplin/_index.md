---
title: "Self-Hosted Joplin Server"
date: 2025-10-17T12:26:32-07:00
draft: false
summary: "Private, self-hosted Joplin Server running on Debian inside Proxmox for secure note synchronization."
description: "End-to-end setup and operation of a self-hosted Joplin Server using Proxmox and Debian."
showtoc: true
cover:
  image: "/images/joplin/joplin_logo.png"
  alt: "Self-Hosted Joplin Server"
  caption: "Private Joplin Server hosted on homelab server"
  relative: false
tech: ["joplin", "proxmox", "debian", "linux"]
tags: ["joplin", "self-hosted", "homelab", "proxmox"]
role: "Owner / Operator"
links:
  repo: ""
  demo: ""
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
| **HP EliteDesk 800 G4 Mini (i7-8700T, 64 GB RAM)** | Physical host (homelab server) |
| **Proxmox VE** | Bare-metal hypervisor |
| **Debian (VM)** | Dedicated service host OS |
| **Joplin Server** | Private note synchronization backend |


---

## 📐 Architecture & Methodology

Proxmox → Debian/Ubuntu VM → Docker/Compose → Joplin Server (+ Postgres)

### 1. Proxmox (Bare Metal)
- Installed directly on sv-001 (Homelab)
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
| Wireguard installed and operational |  |
| Joplin Server operational |  |
| Multi-device sync verified |  |

---

## 💡 Lessons Learned

- Running services inside a VM dramatically simplifies recovery and migration.
- Proxmox snapshots provide a clean rollback strategy before upgrades.
- Self-hosting Joplin removes vendor lock-in and long-term pricing risk.
- Clear separation between **hypervisor**, **OS**, and **application** reduces operational mistakes.

---

## ➡️ Next Steps

- Automated VM backups to NAS
- VPN-only access for Joplin Server
- Hardening Debian (firewall rules, SSH lockdown)
- Monitoring uptime and resource usage
- Optional integration with additional self-hosted services

---

## 👷 Progress Log



### 2026-2-10
- Getting SSH to work with Wireguard, to `SSH` into `Homelab (Proxmox)` and the `Proxmox VM`'s themselves
	- Not sure why it's not Working
	- ***Solution:*** it was because I had to disable `TinyWall` firewall on `PC` to get `SSH` to work.
- Starting on implementing Joplin, since WireGuard is now successfully up and running.

### 2026-2-9

- Successfully setup domain, since was having problems with ipv4. Now getting <span style="color: #00d28f;">WireGuard</span> to work.
	- Working on getting Cloudflare to propagate our domain. Changing DNS CNAME entries, redirects, etc
	- Creating custom API entry, and writing custom DDNS update script for homelab (`Proxmox Debian VM`) to forward any IP changes to Cloudflare 
		- Using the `python3 -m http.server 8000` command to create a very simple (local) HTTP server, to move files easily from `Proxmox Debian VM` to `Client PC`
	- Ran script to test it, and automated it to run every 5 minutes with `cron` by using the following command:
		- `sudo crontab -e` and adding the following line at the bottom: `*/5 * * * * /usr/local/bin/<script name>.sh >/dev/null 2>&1`

<span style="color: #00d28f;">***Our WireGuard infrastructure now looks like this:***</span> 	
	
```markdown
Client (pc / phone / laptop)
        ↓
vpn.<yourdomain.com> → <your dynamic IP address>
        ↓
Home Router (NAT)
        ↓ UDP 51820
192.168.0.X (Proxmox Debian VM)
        ↓
WireGuard (0.0.0.0:51820)

```
	

### 2026-2-8

- Finished installing Wireguard on `Proxmox Debian VM` (VM that will run Joplin and other services, within Proxmox).
- Installing Wireguard on `Client PC` (Windows) for testing.
	- Having issues with the Wireguard config settings and getting ipv4 to work... so going to setup the Cloudflare DDNS with a domain I purchased, to mitigate
	the fact that my ISP changes my IP address often. This will give us a stable hostname and simplify things. 
		- Creating simple HTML page that will be hosted on Cloudflare Pages (to have something there when address is typed inside a web browser).
		- Will use GitHub private repo + Cloudflare Pages, to make any future updates easier
		- Successfully created GitHub private repo + Cloudflare Page, and working landing page, for the domain.
		


### 2026-2-7

- Installing <a href="https://www.youtube.com/watch?v=ShDM-moMHwU" target="_blank" rel="noopener noreferrer">QEMU Guest Agent</a>, which runs inside the VM and serves to enable
enhance communication between the guest operating system and the host hypervisor (ie. Proxmox)
	- Lets Proxmox:
		- See VM IP automatically
		- Shut down VM cleanly
		- Do proper backups/snapshots
	- Enabling QEMU Guest Agent in Proxmox UI
	
- Figuring out how this will sync with my phone. Use Wireguard or Tailscale? 
	- Moving focus to installing Wireguard right now, as I need that to properly work first, if I want Joplin to work correctly.
	
- Installed <a href="https://putty.org/" target="_blank" rel="noopener noreferrer">PuTTY</a> as a better terminal program... as I coulnd't copy/paste into `Proxmox Debian VM` 
via Powershell nor Command Line programs, on `Client PC`


---

## 📍 References

- https://joplinapp.org/help/
- https://github.com/laurent22/joplin
- https://pve.proxmox.com/wiki/Main_Page
