---
title: "M-Disc Archival Solutions"
date: 2025-11-03T16:26:32-07:00
draft: false
summary: "Offline, immutable long-term data storage using Verbatim M-Disc technology integrated with TrueNAS SCALE."
tech: ["TrueNAS SCALE", "M-Disc", "BDXL"]
tags: ["homelab", "archival", "storage", "backup"]
role: "Homelab Engineer / Security Analyst"
links:
  repo: ""
  demo: ""
cover:
  image: ""
  caption: "Long-term cold-storage archival with 25 GB M-Discs"
---

## 🎯 Objective
Implement a **long-term, low-maintenance cold-storage system** using **M-Disc Blu-ray technology** within the TrueNAS backup server (NAS-001).  
This ensures data remains readable for centuries without dependency on cloud providers, power, or magnetic storage integrity.

---

## 🧱 System Overview

| Component | Description |
|------------|--------------|
| **TrueNAS Server (NAS-001)** | Primary data repository, ZFS RAIDZ2 array, 60 TB+ usable. |
| **M-Disc Burner** | LG WH16NS58 (SATA) with BDXL support. |
| **Backup Manager** | SV-001 (EliteDesk 800 G4 Mini) runs scheduled jobs and Wake-on-LAN triggers. |
| **Backup Media** | Verbatim M-Disc BD-R 25 GB (archival grade). |

---

## 🗺️ Considerations / Specifications

### 🔥 Best Burners for M-Disc
- **LG WH16NS40 / WH16NS58** — Official M-Disc support, consistent write quality.  
- **ASUS BW-16D1HT** — Supports both **M-Disc** and **BDXL (100 GB)**. Good for testing, not ideal for long-term critical data.

**Best Practices**
- Use only **Verbatim** or **Milleniata** branded media.  
- Burn at **4× speed or lower** — slower burns improve pit formation and readability.  
- Always **enable verify-after-write** in ImgBurn or Nero.  
- Generate checksums before and after burn:  
```bash
  sha256sum * > checksums.txt
```
<br/>

---

<br/>

<!--- 

🧩 Integration Workflow — 3-2-1 Strategy
🧮 1. Local Snapshot and Compression

Create quarterly ZFS snapshots of critical datasets:
/mnt/pool01/Documents, /mnt/pool01/MusicProjects, etc.

Compress each snapshot to ≤ 23 GB .7z archives for single-disc burns.

Generate checksum file per archive.

💿 2. Write and Verify

Burn each archive to M-Disc BD-R 25 GB.

Verify data against checksum.

Record burn metadata in /mnt/pool01/Logs/backup_log_YYYYMMDD.txt.

🚚 3. Offsite & Cloud Duplication

Duplicate discs and store second set offsite (e.g. family home or safety deposit box).

Optionally encrypt and upload a copy to cloud (rclone, Backblaze B2, or Proton Drive).

Result:

NAS → fast access + redundancy

M-Disc → immutable cold backup

Cloud → disaster insurance

This fulfills the 3-2-1 backup rule: 3 copies, 2 media types, 1 offsite.

⚡ Power Management

NAS-001 remains powered down except during scheduled backup sessions.

SV-001 (low-power node) manages Wake-on-LAN triggers, rsync snapshot exports, and shutdown sequences.

Scheduled via cron or TrueNAS tasks to minimize idle power draw.

🧊 Cold-Storage Guidelines
Recommended Media: M-Disc BD-R 25 GB

Most reliable for long-term archival (single-layer).

50 GB+ dual-layer discs have higher failure rates over decades.

BDXL 100-128 GB discs degrade significantly faster (5-10 yr vs 300-1000 yr theoretical lifespan).

Handling and Storage

Label with archival ink or laser etching — no stickers or Sharpies.

Store vertically in jewel cases or archival sleeves (never spindles).

Keep in airtight plastic bins with silica gel; avoid humidity and sunlight.

Verify readability every 1-2 years using checksum verification.

🧾 File Labeling and Metadata Convention

Each disc will include:

backup_YYYYMMDD_set01_part01.7z
backup_YYYYMMDD_set01_part01.7z.sha256
backup_manifest_YYYYMMDD.txt


Example manifest entry:

Dataset: /mnt/pool01/MusicProjects
Disc: 2025Q1_MDisc01
Size: 23.2 GB
Checksum: SHA256 verified OK
Burner: LG WH16NS58
Software: ImgBurn 2.5.8
Verify: OK (2025-03-10)

🧠 Notes & Lessons Learned

BDXL drives are backward-compatible with M-Disc BD-R 25 GB.

ZFS compression (lz4) before snapshot export reduces total disc count.

Use ECC RAM and error-free ZFS pools before archival — garbage in = garbage forever.

Avoid relying solely on consumer-grade USB hard drives; they degrade faster than optical.

🧮 Future Improvements

Automate checksum validation logs via Python script.

Explore TrueNAS Replication Tasks → local snapshot → automated export to SV-001 → compression → disc burning queue.

Evaluate 50 GB discs only for non-critical bulk data (e.g., video backups).

Add NFC tag or QR label system for disc indexing (linking to digital manifest).

🏁 Summary

M-Disc technology provides a hardware-agnostic, air-gapped, and time-resilient backup layer.
Integrated into the TrueNAS-based workflow, it forms a final safeguard against both cyberattacks and bit-rot — the last line of defense for data that must outlive every other medium.

-->