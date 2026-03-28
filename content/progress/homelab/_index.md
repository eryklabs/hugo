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
Tracking setup and upgrades for my EliteDesk G4 800 Mini Proxmox server (`sv-001`).

---

## 🏁 Milestones

**2026-3-27**: <span style="color: #00d28f;">Technitium DNS Server, Nginx Reverse Proxy, Syncthing</span> on `sv-001-svc` up and running.

**2026-2-15**: <span style="color: #00d28f;">Joplin Server</span> on `sv-001-svc` up and running.

**2026-2-14**: <span style="color: #00d28f;">Gitea</span> on `sv-001-svc` up and running.

**2026-2-9**: <span style="color: #00d28f;">WireGuard</span> up and running. Successfully established connection from `PC` to `Homelab` via <span style="color: #00d28f;">WireGuard</span>

**2026-2-8**: First <span style="color: #00d28f;">Proxmox VM (Debian)</span> up and running, on `Homelab` (<span style="color: #00d28f;">`sv-001-svc: Proxmox VM - VM 100`</span>)


**2026-2-7**: <span style="color: #00d28f;">Proxmox</span> up and running on `Homelab` server

---
## 📥 Next Steps
- Install a private <span style="color: #00d28f;">git</span> solution on `Homelab`, as the source of truth for documentation of working on `Homelab` (and any other projects)
- Install <span style="color: #00d28f;">PiHole</span> for internal DNS resolution and ad-blocking
---
## 👷 Progress Log


### 📅 2026-03-27

- Built a full internal access stack (DNS + WireGuard + reverse proxy) to access homelab services via clean hostnames instead of IP:port
- Solved multiple connectivity issues across DNS resolution, VPN routing, reverse proxy config, and Docker service exposure

---

## 🔧 Systems Worked On

### Technitium (Internal DNS Server)
- Set up Technitium internal DNS to resolve local services to a single server IP
- Verified resolution works both locally and over VPN
- Fixed inconsistent resolution caused by OS using multiple DNS sources

---

### WireGuard (VPN + DNS Routing)
- Configured clients to use internal DNS server instead of ISP DNS
- Ensured DNS queries route through VPN instead of leaking externally
- Verified full internal access via VPN subnet (10.x network)

---

### Reverse Proxy (Nginx Proxy Manager)
- Configured hostname-based routing to internal services (no ports)
- Fixed multiple 502 errors caused by incorrect upstream targets
- Learned correct proxy flow: DNS → proxy → service

---

### Joplin Server
- Debugged “Invalid origin” error caused by base URL mismatch
- Fixed environment config (`APP_BASE_URL`)
- Verified correct behavior via curl + Host header simulation

---

### Syncthing
- Diagnosed container crash loop due to permission issues
- Fixed volume ownership + permissions
- Successfully exposed UI and routed via reverse proxy

---

### ⚖️ Decisions Made

#### Use Reverse Proxy instead of Direct Ports
- **Pros:**
  - Clean URLs (no ports)
  - Centralized routing
  - Matches real-world production setups 
- **Cons:**
  - Adds complexity (can break with misconfig)
- **Decision:** Use reverse proxy → necessary for scaling + professionalism

---

#### Keep Services Internal (VPN-only)
- **Pros:**
  - Reduces attack surface
  - Avoids exposing home network publicly 
- **Cons:**
  - Requires VPN for access
- **Decision:** VPN-first architecture → security over convenience

---

#### Run Services in Docker
- **Pros:**
  - Consistency across services
  - Easier deployment + rebuild
- **Cons:**
  - Permissions + networking issues can break things
- **Decision:** Continue using Docker → industry standard skill

---

### ⚠️ Problems Encountered

- DNS resolving inconsistently → caused by OS mixing DNS sources
- Reverse proxy 502 errors → caused by wrong IP/port targets
- Joplin rejecting requests → caused by base URL mismatch
- Syncthing failing to start → caused by filesystem permissions
- Services working via IP but not domain → caused by DNS misconfiguration

---

### 🧠 Lessons Learned

#### DNS vs Routing (critical)
- DNS only resolves names → does NOT control traffic path

---

#### Reverse Proxy Behavior
- Routes based on **hostname (Host header)**, not IP
- All domains should point to proxy, not services directly 

---

#### WireGuard Reality
- DNS must be explicitly configured per client
- Otherwise system falls back to ISP DNS silently

---

#### Docker Networking
- Binding services to wrong interface breaks proxy access
- Services must be reachable from proxy layer

---

#### Permissions Are a Common Failure Point
- Many container crashes are caused by volume permission issues, not app bugs

---

#### Standard Homelab Architecture (validated)
- DNS + Reverse Proxy + VPN is a common pattern for secure access 

---

### 🔁 Final Architecture Built

Client (PC / Phone) <br/>
↓ <br/>
WireGuard VPN <br/>
↓ <br/>
Internal DNS <br/>
↓ <br/>
Reverse Proxy <br/>
↓ <br/>
Docker Services <br/>


---

### 🧾 Ultra-Short Summary

- Built internal DNS for service discovery across LAN + VPN  
- Integrated WireGuard with DNS to prevent leaks and ensure consistency  
- Deployed reverse proxy for clean hostname-based routing  
- Fixed Joplin origin issues and proxy misconfiguration  
- Debugged and deployed Syncthing with correct permissions  

<br/>

Current new `Homelab` architecture:

```python

internet
   │
   │ UDP 51820
   ▼
router
   │
192.168.0.0/24
   │
   ├── sv-001 (proxmox)
   │
   ├── sv-001-svc (services - Debian VM)
   │       ├─ wireguard (wg0 → 10.6.0.1)
   │       └─ docker
   │            ├─ technitium (DNS server, port 53)
   │            ├─ nginx-proxy-manager (ports 80, 443)
   │            ├─ gitea (3000)
   │            ├─ joplin (22300)
   │            └─ syncthing (8384)
   │
   ├── nas-001
   │
   └── other devices
   │
   │ DNS resolution path:
   │   device → DNS (192.168.0.22)
   │           → resolves to 192.168.0.22
   │           → nginx (port 80/443)
   │           → service (port)
   │
   ▼

VPN network
10.6.0.0/24
   │
   ├── sv-001-svc (10.6.0.1)
   │       └─ DNS + reverse proxy entry point
   │
   └── clients
           ├─ DNS = 10.6.0.1 (→ forwards to 192.168.0.22)
           └─ access services via hostnames (no ports)
```


### 📅 2026-03-15

- Troubleshooting `WireGuard` service, assigning `DHCP` addresses in router configuration to keep persistant IPs in homelab LAN.
(I hadn't been able to login to `Homelab` server remotely lately). 
- Adding port forwarding for UDP port `51820` to `Homelab`
- Enabled packet forwarding with the following commands:
	- `sudo nano /etc/sysctl.conf`
		- Adding this line: `net.ipv4.ip_forward=1`
	- Applying it with `sudo sysctl -p`
	- Adding NAT rule to LAN machines think VPN clients are local:
		- `sudo iptables -t nat -A POSTROUTING -o ens00 -j MASQUERADE`
		- (`ens00` is my LAN interface)
	- <span style="color: #00d28f;">Editing `WireGuard` client configs to tell the client to send LAN traffic through the VPN:</span>
		- Change `AllowedIPs = 10.6.0.0/24` to `AllowedIPs = 10.6.0.0/24, 192.168.0.0/24`

Current new `Homelab` architecture:

```python
internet
   │
   │ UDP 51820
   ▼
router
   │
192.168.0.0/24
   │
   ├── sv-001 (proxmox)
   │
   ├── sv-001-svc (services - Debian VM)
   │       ├─ wireguard (wg0 → 10.6.0.1)
   │	   └─ docker
   │       	├─ gitea
   │       	└─ joplin
   │
   ├── nas-001
   │
   └── other devices

VPN network
10.6.0.0/24
   │
   ├── sv-001-svc (10.6.0.1)
   │
   └── clients
```




### 📅 2026-02-27

- Troubleshooting why `Homelab` server keeps crashing and restarting every 1-2 days.
- Solved: Had to add `i915.enable_dc=0` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`
	```bash
	GRUB_CMDLINE_LINUX_DEFAULT="quiet i915.enable_dc=0"
	```
- It fixed the reboots because `i915.enable_dc=0` disables a buggy Intel GPU power-saving feature in the 
Linux i915 driver that can cause GPU hangs and random system crashes on some Intel CPUs, so the driver 
never enters the unstable power state that was triggering the hard resets.

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