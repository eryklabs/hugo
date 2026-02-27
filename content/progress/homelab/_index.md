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

## 🏁 Milestones

**2026-2-15**: <span style="color: #00d28f;">Joplin Server</span> on `Proxmox VM - VM 100` up and running.

**2026-2-14**: <span style="color: #00d28f;">Gitea</span> on `Proxmox VM - VM 100` up and running.

**2026-2-9**: <span style="color: #00d28f;">WireGuard</span> up and running. Successfully established connection from `PC` to `Homelab` via <span style="color: #00d28f;">WireGuard</span>

**2026-2-8**: First <span style="color: #00d28f;">Proxmox VM (Debian)</span> up and running, on `Homelab` (<span style="color: #00d28f;">`Proxmox VM - VM 100`</span>)


**2026-2-7**: <span style="color: #00d28f;">Proxmox</span> up and running on `Homelab` server

---
## 📥 Next Steps
- Install a private <span style="color: #00d28f;">git</span> solution on `Homelab`, as the source of truth for documentation of working on `Homelab` (and any other projects)
- Install <span style="color: #00d28f;">PiHole</span> for internal DNS resolution and ad-blocking
---
## 👷 Progress Log

### 📅 2026-02-27

- Troubleshooting why `Homelab` server keeps crashing and restarting every 1-2 days.

<br/>

### 📅 2026-02-15

- Deployed <span style="color: #00d28f;">**Joplin Server v3.5.2**</span> inside Docker on `Proxmox VM` (VM-100).
- Separated secrets from compose file:
  - Runtime secrets stored at `/srv/secrets/joplin/.env`
  - Permissions set to `root:root` with `600`
- Rebuilt stack cleanly using `docker compose down -v` and reinitialized PostgreSQL.
- Bound Joplin to WireGuard interface only:
  - `10.6.0.1:22300`
- Verified container health:
  - `joplin-db`
  - `joplin-server`

#### 🔐 Authentication Architecture

- Logged in with default `admin@localhost`
- Rotated admin password immediately
- Created dedicated non-admin sync user
- Stored both credentials in <span style="color: #00d28f;">KeePassXC</span>

#### 🔄 Synchronization Migration

- Exported full JEX backup from `Windows PC` prior to migration.
- Switched sync target from File System → Joplin Server.
- Verified configuration via sync check.
- Seeded server with full dataset (~400+ items).
- Confirmed:
  - 0 conflicts
  - 0 errors
  - Complete note/resource parity

#### 📡 Current Joplin Architecture

```text
Windows PC (Primary Authoritative Client)
        ↓
WireGuard (10.6.0.0/24)
        ↓
Proxmox VM (VM-100)
        ├── joplin-server
        └── postgres
```

<br/>


`Proxmox VM` now acts as central sync authority.

Server contains full dataset and revision history.

Laptop Joplin not yet migrated (pending clean alignment).



<br/>

### 📅 2026-02-14

- Deployed <span style="color: #00d28f;">**Gitea**</span> inside Docker on Proxmox VM.
- Reset containers and performed clean rebuild of:
  - `gitea`
  - `postgres`
- Verified services with `docker ps`.

#### ⚙️ Configuration

- PostgreSQL containerized and connected.
- Persistent volumes configured.
- SSH configured on non-standard internal port.
- HTTP running on internal port.
- Local-only access (WireGuard network).

#### 🔐 SSH Architecture

- Generated dedicated **ED25519** keypair for Gitea.
- Added public key in Gitea user settings.
- Verified SSH authentication works (Git-only access — no shell, expected behavior).
- Added host alias inside `~/.ssh/config` for simplified cloning.

Example structure:

```ssh
Host gitea
    HostName <internal-ip>
    Port <custom-port>
    User git
    IdentityFile ~/.ssh/id_ed25519_gitea
```

#### Architecture Snapshot:

```matlab
Proxmox VM
│
├── wireguard
├── docker
│   ├── gitea
│   └── postgres
│
└── persistent volumes
```

```java
Client Machine
│
├── Dedicated SSH key (Gitea-specific)
└── Structured project directory (non-system drive)
```

<br/>

### 📅 2026-2-13
- Researching what the best privately hosted `git` solution will be, and the best approach to documenting this `Homelab` (and any other further projects), following 
industry best-practices
	- I will use <span style="color: #00d28f;">`Gitea`</span> (private git) + <span style="color: #00d28f;">`Woodpecker`</span> (CI/CD tool to pair with Gitea)
	
<span style="color: #00d28f;">***Current Architecture:***</span>

```scss
VM-100 (Proxmox VM on Homelab)
│
├── wireguard (already running)
├── docker
│    ├── gitea container
│    ├── woodpecker-server container
│    ├── woodpecker-agent container
│    └── postgres (shared or separate)
```
<br>

### 📅 2026-2-9

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
	

### 📅 2026-2-8

- Finished installing Wireguard on `Proxmox Debian VM` (VM that will run Joplin and other services, within Proxmox).
- Installing Wireguard on `Client PC` (Windows) for testing.
	- Having issues with the Wireguard config settings and getting ipv4 to work... so going to setup the Cloudflare DDNS with a domain I purchased, to mitigate
	the fact that my ISP changes my IP address often. This will give us a stable hostname and simplify things. 
		- Creating simple HTML page that will be hosted on Cloudflare Pages (to have something there when address is typed inside a web browser).
		- Will use GitHub private repo + Cloudflare Pages, to make any future updates easier
		- Successfully created GitHub private repo + Cloudflare Page, and working landing page, for the domain.
		


### 📅 2026-2-7
- Installed **Proxmox** on homelab
- Researching how to install **Joplin**, to have a private "Evernote"-type note system, that will sync across various devices

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