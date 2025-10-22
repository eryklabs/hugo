---
title: "SOP – TITLE HERE"
date: 2025-10-17
lastmod: 2025-10-17
draft: false
tags: ["SOP", "Template"]
categories: ["Standard Operating Procedure"]
summary: "Short one-sentence summary of this SOP’s purpose."
tech: ["Tool1", "Tool2", "System3"]   # optional
ShowToc: true
TocOpen: false
disableShare: true
---

## Purpose
State *why* this SOP exists and what it standardizes.

Example:  
“This procedure ensures consistent and secure configuration of Pi-hole DNS servers in my homelab environment.”

---

## Scope
Define where this SOP applies.  
Example: “Applies to all self-hosted DNS deployments (Pi-hole, AdGuard Home) within the local VLAN.”

---

## Prerequisites
List required tools, permissions, or configurations.

- Admin access to `SV-001`
- `docker-compose` installed
- Backup system active

---

## Procedure
Detailed numbered steps (the heart of the SOP):

1. SSH into the target host:
   ```bash
   ssh admin@sv-001
