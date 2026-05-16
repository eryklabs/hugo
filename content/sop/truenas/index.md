---
title: "TrueNAS - Standard Operating Procedures (SOPs)"
date: 2026-05-15T12:26:32-07:00
draft: false
summary: "TrueNAS: repeatable SOPs for NAS setup, drive testing, SMART logs, badblocks, SSH file transfer, and pool maintenance."
description: "A collection of repeatable TrueNAS workflows for nas-001."
showtoc: true
tocopen: true
cover:
  image: "/images/truenas/truenas-scale-logo.png"
  alt: "TrueNAS SOPs"
  
  relative: false
---

These SOPs document repeatable TrueNAS workflows for `nas-001`, including drive testing, SMART logs, badblocks, file transfers, permissions, pool setup, and maintenance.

---

## **<span style="color: #00ff7f">TrueNAS SOP Index</span>**

| SOP | What It Solves | Link |
|---|---|---|
| New HDD Drive Testing | Running Short and Long SMART tests on new drives | [<span style="color: #00ff7f">Link</span>](/sop/truenas/new-drive-sop/) |
| Run Badblocks on New HDDs | Stress-test new/refurbished HDDs before trusting them | [<span style="color: #00ff7f">Link</span>](/sop/truenas/badblocks/) |



---

## **<span style="color: #00ff7f">General Notes to Remember</span>**

- Linux drive names like `/dev/sda`, `/dev/sdb`, `/dev/sdf` can change after reboot.
- Serial numbers and WWNs are what matter.
- Do not trust drive letter alone when deciding which HDD to remove or RMA.
- Save SMART and badblocks results with serial numbers in the filename whenever possible.
- Avoid enabling root SSH login unless there is a specific reason.
- Prefer copying files into an admin user directory first, then pulling them from Windows.

---

## **<span style="color: #00ff7f">Core TrueNAS Commands</span>**

### Check all detected drives

```bash
lsblk -o NAME,SIZE,MODEL,SERIAL
```

### Show SMART info for a drive

```bash
smartctl -a /dev/sdX
```

### Show extended SMART info

```bash
smartctl -x /dev/sdX
```

### Show SMART self-test history

```bash
smartctl -l selftest /dev/sdX
```

### Start a short SMART test

```bash
smartctl -t short /dev/sdX
```

### Start a long SMART test

```bash
smartctl -t long /dev/sdX
```

---

## **<span style="color: #00ff7f">File Transfer Notes</span>**

For copying files from TrueNAS to Windows, the clean workflow is usually:

1. Save logs somewhere predictable on TrueNAS.
2. Move or copy them into a directory your admin user can access.
3. Use `scp` from Windows PowerShell.

Example:

```powershell
scp truenas_admin@192.168.0.X:/home/truenas_admin/logs/*.txt D:\NAS-Logs\
```

---

## **<span style="color: #00ff7f">Drive Identification Rule</span>**

Never RMA or remove a drive based only on:

```text
/dev/sda
/dev/sdb
/dev/sdf
```

Those labels can change.

Use:

```bash
smartctl -i /dev/sdX
```

and record:

```text
Serial Number
WWN
Model
Capacity
Bay location
```

---

## **<span style="color: #00ff7f">Recommended SOPs to Create Next</span>**

| Priority | SOP | Why |
|---|---|---|
| 1 | Drive serial identification SOP | Prevents pulling/RMAing the wrong drive |
| 2 | SMART test SOP | Basic recurring health check |
| 3 | Badblocks SOP | Burn-in workflow for new/refurb drives |
| 4 | Copy logs to Windows SOP | You have already needed this multiple times |
| 5 | Drive replacement/RMA SOP | Prevents expensive mistakes |
| 6 | Pool creation SOP | Needed before trusting the final storage layout |
