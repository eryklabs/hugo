---
title: "TrueNAS Server Progress Log"
date: 2025-11-03
draft: false
summary: "Progress Log for TrueNAS Server Build"
tech: ["progress log", "homelab", "nas", "truenas"]
tags: ["homelab", "nas", "truenas", "networking", "storage"]
layout: "list"
showtoc: true
role: ""
links:
  repo: ""
  demo: ""
cover:
  image: "/images/truenas/truenas-scale-logo.png"     # in static folder
  caption: ""
---

![TrueNAS Scale](/images/truenas/truenas-scale-logo.png)


## 🌐 Overview
Tracking setup, upgrades, and progress for building out a TrueNAS local backup server. 

We will be using an old tower PC, recycling some old parts, and buying some new / used parts to build a solid TrueNAS machine, with 60TB+ of useable storage. 

---
### 📅 2026-01-26
- **Put together computer, but it won't POST**... troubleshooting the problem the following ways:
	- <a href="https://forums.tomshardware.com/threads/no-post-system-wont-boot-and-no-video-output-troubleshooting-checklist.1285536/" target="_blank" rel="noopener noreferrer">"No POST", "system won't boot", and "no video output" troubleshooting checklist (Tom's Hardware)</a>. 
		- Inspired by this guide, I realized the "ATX12V2" port on the <a href="https://download.asrock.com/Manual/B550%20Pro4.pdf" target="_blank" rel="noopener noreferrer">B550 Pro4 motherboard</a> isn't plugged in. So I'll try to connect that port to the PSU.

<br/>

### 📅 2025-11-03
- Researching best parts to get, while maximizing savings. Will buy refurbished HDD hard drives, and used ECC RAM to save on costs. 
- Since main workstation PC (PC-001) will only be a few feet away from this TrueNAS server, it will make sense to install a 10GbE NIC, and connect the two with a Cat6a cable (since our PC-001 machine already is 10GbE capable). This will give ~1 GB/s transfers instead of ~110 MB/s on 1GbE. 
- We will refer / tag the TrueNAS server as NAS-001 to stay consistent with our naming conventions (PC-00x for workstations, SV-00x for servers, LT-00x for laptops, etc.)
- To save on electricity, this TrueNAS will only be powered on once or twice a week to run backups and snapshots (or as-needed), and SV-001 (low-power homelab server) will be the always-on machine, taking care of most everyday tasks. 

