---
title: "New HDD Drive Testing SOP"
date: 2026-05-15T12:00:00-07:00
draft: false
summary: "Running short and long SMART tests on new or replacement HDDs before trusting them in TrueNAS."
description: "TrueNAS SOP for identifying new drives, saving baseline SMART logs, running short and long SMART tests, and exporting the results for review."
showtoc: true
tocopen: true
---

# New HDD Drive Testing SOP

This SOP covers the basic validation workflow for new or replacement HDDs before trusting them in TrueNAS.

Use this for:

- New HDDs
- Replacement HDDs
- Refurbished / recertified HDDs
- Drives being checked before pool creation or replacement

<br/>

---

## **<span style="color: #00ff7f">Critical Rule</span>**

Do **not** trust Linux drive labels like:

```text
/dev/sda
/dev/sdb
/dev/sdc
/dev/sdf
```

Linux can change these labels after reboot, hardware changes, or controller changes.

Always identify drives by:

- Serial number
- WWN
- Model
- Capacity
- Physical bay/location, if documented

<br/>

---

## 1. Login and Prepare

1. Log in to the TrueNAS web interface.
2. Go to **System > Services**.
3. Enable **SSH** only when needed.
4. Connect through SSH using your normal TrueNAS admin user.
5. Elevate privileges only when needed:

```bash
sudo -i
```

Security note: do **not** publish or document real usernames, passwords, public IPs, VPN details, or exact internal network details in a public SOP.

<br/>

---

## 2. Identify Drives by Serial / WWN

Run these commands before testing:

```bash
smartctl --scan
lsblk -d -o NAME,MODEL,SERIAL,WWN,SIZE,ROTA,TRAN
ls -l /dev/disk/by-id/ | grep -E "ata|wwn"
```

Record the output somewhere safe.

You are trying to map each current `/dev/sdX` label to the real drive identity.

Example checklist:

| Current Device | Model | Serial | WWN | Size | Physical Bay / Notes |
|---|---|---|---|---|---|
| `/dev/sdX` |  |  |  |  |  |
| `/dev/sdY` |  |  |  |  |  |

<br/>

---

## 3. Save Baseline SMART Logs Before Testing

For each new or replacement drive, save a baseline SMART report before running tests.

Basic example:

```bash
smartctl -x /dev/sdX | tee BEFORE_sdX_SERIAL.txt
```

Better filename format:

```bash
smartctl -x /dev/sdX | tee BEFORE_WD-SERIAL.txt
```

Use the drive serial number in the filename.

Do **not** rely only on filenames like:

```text
BEFORE_sdc.txt
BEFORE_sdd.txt
```

Those filenames become unreliable if drive letters change later.

<br/>

---

## 4. Run Short SMART Test

For each new or replacement drive:

```bash
smartctl -t short /dev/sdX
```

Check progress:

```bash
smartctl -a /dev/sdX | grep -i "Self-test execution status" -A2
```

After the short test finishes, save the full SMART snapshot:

```bash
smartctl -x /dev/sdX | tee AFTER_SHORT_WD-SERIAL.txt
```

Also save the self-test history table:

```bash
smartctl -l selftest /dev/sdX | tee SELFTEST_SHORT_WD-SERIAL.txt
```

Command meaning:

```bash
smartctl -x           # full forensic SMART snapshot
smartctl -l selftest  # clean self-test result history
```

<br/>

---

## 5. Run Long SMART Test

For each new or replacement drive:

```bash
smartctl -t long /dev/sdX
```

Check estimated completion time:

```bash
smartctl -c /dev/sdX | grep -i "extended"
```

Check progress later:

```bash
smartctl -a /dev/sdX | grep -i "Self-test execution status" -A2
```

Before saving final results, verify the current `/dev/sdX` to serial number mapping again:

```bash
lsblk -d -o NAME,MODEL,SERIAL,WWN,SIZE,ROTA,TRAN
```

After the long test finishes, save the full SMART snapshot:

```bash
smartctl -x /dev/sdX | tee AFTER_LONG_WD-SERIAL.txt
```

Then save the self-test history:

```bash
smartctl -l selftest /dev/sdX | tee SELFTEST_LONG_WD-SERIAL.txt
```

The long / extended SMART test scans the disk surface more completely than the short test. For new or replacement HDD validation, the long test matters more than the short test.

<br/>

---

## 6. Export SMART Test Results From TrueNAS

Use this when you need to move SMART test logs off the NAS for review, storage, or external analysis.

### 6.1 Create an Archive

From inside the folder that contains the SMART `.txt` files:

```bash
tar -czvf drive-tests-YYYY-MM-DD.tar.gz *.txt
```

Example:

```bash
tar -czvf drive-tests-YYYY-MM-DD.tar.gz *.txt
```

This archives all `.txt` SMART files in the current folder.

<br/>

### 6.2 Copy the Archive to an Admin-Accessible Home Directory

```bash
cp drive-tests-YYYY-MM-DD.tar.gz /home/YOUR_ADMIN_USER/
chown YOUR_ADMIN_USER:YOUR_ADMIN_USER /home/YOUR_ADMIN_USER/drive-tests-YYYY-MM-DD.tar.gz
chmod 644 /home/YOUR_ADMIN_USER/drive-tests-YYYY-MM-DD.tar.gz
ls -lh /home/YOUR_ADMIN_USER/drive-tests-YYYY-MM-DD.tar.gz
```

Replace:

```text
YOUR_ADMIN_USER
```

with your actual TrueNAS admin username.

Do not publish the real username in a public SOP.

<br/>

### 6.3 Copy the Archive From Windows PowerShell

From Windows PowerShell:

```powershell
scp YOUR_ADMIN_USER@YOUR_NAS_IP:/home/YOUR_ADMIN_USER/drive-tests-YYYY-MM-DD.tar.gz "D:\Path\To\Destination\Folder\"
```

Replace:

```text
YOUR_ADMIN_USER
YOUR_NAS_IP
D:\Path\To\Destination\Folder\
```

with your real values on your private machine only.

<br/>

---

## 7. Recommended File Naming Standard

Use serial numbers in filenames.

Recommended pattern:

```text
BEFORE_SERIAL.txt
AFTER_SHORT_SERIAL.txt
SELFTEST_SHORT_SERIAL.txt
AFTER_LONG_SERIAL.txt
SELFTEST_LONG_SERIAL.txt
```

Example format:

```text
BEFORE_WD-SERIAL.txt
AFTER_SHORT_WD-SERIAL.txt
SELFTEST_SHORT_WD-SERIAL.txt
AFTER_LONG_WD-SERIAL.txt
SELFTEST_LONG_WD-SERIAL.txt
```

<br/>

---

## 8. Pass / Fail Review Checklist

Before trusting the drive, review:

| Check | Pass Condition | Notes |
|---|---|---|
| SMART overall-health | Passed | `smartctl -a` or `smartctl -x` |
| Short test | Completed without error | Check `smartctl -l selftest` |
| Long test | Completed without error | Most important SMART test |
| Reallocated sectors | Ideally 0 | Non-zero needs deeper review |
| Current pending sectors | 0 | Pending sectors are a serious warning sign |
| Offline uncorrectable | 0 | Non-zero is a bad sign |
| Serial number confirmed | Yes | Must match the physical drive |
| Logs saved | Yes | Save before/after results |

<br/>

---

## 9. Final Rule Before Installing Into a Pool

Before adding the drive to a pool, replacing a pool member, or trusting it for storage:

1. Confirm serial number.
2. Confirm WWN if available.
3. Confirm SMART short test passed.
4. Confirm SMART long test passed.
5. Save all SMART logs.
6. Store logs somewhere outside the NAS.
7. Label or document the physical drive location.

Do not proceed based only on `/dev/sdX`.
