---
title: "Self-Hosted Gitea Server"
date: 2026-02-14T12:26:32-07:00
draft: false
summary: "Private Git server (Gitea) running inside a Debian VM on Proxmox for homelab source control and infrastructure documentation."
description: "End-to-end deployment and operation of a self-hosted Gitea instance for homelab Git repositories, infrastructure tracking, and CI/CD expansion. <br><br> 
A private git server is also a great place to store documentation for homelab infrastructure (and related projects), as it provides centralized version control,
and is a great reference to turn to if anything ever breaks."
showtoc: true
cover:
  image: "/images/gitea/gitea-logo.png"
  alt: "Self-Hosted Gitea Server"
  caption: "Private Gitea instance hosted on homelab server"
  relative: false
tech: ["gitea", "git", "proxmox", "debian", "docker"]
tags: ["gitea", "git", "self-hosted", "homelab", "version-control"]
role: "Owner / Operator"
links:
  repo: ""
  demo: ""
---

## 🎯 Objective

Deploy a <span style="color: #00d28f;">**fully private, self-hosted Git server** using Gitea to act as the single source of truth for:

- Homelab configurations  
- Docker Compose stacks  
- Infrastructure documentation  
- Hugo website source  
- Scripts and automation  
- Future CI/CD workflows  

Primary goals:

- Full source code ownership  
- Eliminate dependency on GitHub for internal projects  
- Centralize documentation + configs  
- Enable future CI/CD (Woodpecker or similar)  
- Clean separation of hypervisor, OS, and services  

---

## 🔧 Environment / Tools

| Component | Purpose |
|-----------|----------|
| **(Proxmox Host)** | Bare-metal hypervisor |
| **VM 100 (Debian VM)** | Dedicated service VM |
| **Docker + Compose** | Application container runtime |
| **Gitea** | Lightweight self-hosted Git service |
| **PostgreSQL** | Gitea database backend |
| **WireGuard** | Secure remote access |

---

## 📐 Architecture & Methodology

Proxmox → Debian VM (`VM 100`) → Docker → Gitea (+ Postgres)

### 1. Proxmox (Bare Metal)

- Installed directly on `Homelab` server
- Runs no application services
- Responsible only for virtualization
- VM-level backups + snapshots

---

### 2. Debian Service VM (`VM 100`)

- Isolated service host
- 8GB RAM allocated (expandable)
- Runs containerized services only
- WireGuard installed directly on VM (network layer)

---

### 3. Gitea Deployment (Dockerized)

- Deployed via `docker-compose`
- Uses `.env` file for environment variables
- Database: PostgreSQL container
- Persistent volumes for:
  - `/data`
  - `/repositories`
  - Database storage

**Key Design Decisions:**

- `.env` excluded from Git
- `.env.template` committed instead
- `chmod 700 .env` applied
- Secrets stored in KeePassXC (not inside repo)

This follows enterprise-style separation between:

- Source code
- Configuration
- Secrets

---

### 4. Network & Access Model

Access Strategy:

Client → WireGuard → Internal VM IP → Gitea

- No direct public exposure
- SSH Git access via VPN only
- Future reverse proxy optional
- Future domain integration possible (e.g. `git.<my-site>.com`)

---

## 🔎 Results

| Item | Status |
|------|--------|
| Proxmox stable | ✅ |
| Debian service VM stable | ✅ |
| WireGuard operational | ✅ |
| Docker installed | ✅ |
| PostgreSQL container deployed |  |
| Gitea container deployed |  |
| Local Git push from Windows PC workstation verified |  |

---

## 💡 Lessons Learned

- Centralizing homelab configs into Git immediately reduces chaos.
- Dockerizing services simplifies upgrades and migration.
- `.env.template` pattern prevents credential leaks.
- Running services inside a VM adds a clean isolation boundary.
- Self-hosted Git is simple — overengineering early (Kubernetes, HA) is unnecessary.

Big takeaway:

Start minimal. Expand only when real operational pressure exists.

---

## ➡️ Next Steps

- Verify SSH-based Git operations from Windows PC
- Add first repo: `homelab`
- Migrate scattered notes into structured Markdown repos
- Implement automated VM backups
- Optional: Install Woodpecker CI for learning CI/CD
- Optional: Reverse proxy + internal DNS

---

## 👷 Progress Log

### 2026-2-14

- Decided to install Gitea inside `VM 100` (service VM), not directly on Proxmox host.
- Created Docker Compose file with:
  - Gitea container
  - PostgreSQL container
- Implemented `.env` secret management strategy.
- Discussed enterprise production patterns:
  - Secrets not stored in Git
  - Environment separation
  - Principle of least privilege

---

### 2026-2-13

- Debated Gitea vs Forgejo.
- Evaluated Woodpecker CI integration.
- Clarified:
  - Docker purpose
  - When to use containers vs bare-metal installs
  - Why WireGuard runs outside Docker (network boundary control)
- Confirmed 8GB RAM sufficient for current services.

---

### 2026-2-12

- Completed WireGuard deployment.
- Validated remote SSH into:
  - Proxmox host
  - Debian VM
- Confirmed VPN-only access model works.

---

## 📍 References

- https://docs.gitea.com/
- https://docs.docker.com/
- https://pve.proxmox.com/wiki/Main_Page
- https://git-scm.com/docs
