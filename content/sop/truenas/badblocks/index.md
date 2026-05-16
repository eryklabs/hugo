---
title: "Badblocks SOP"
date: 2026-05-15T12:00:00-07:00
draft: false
summary: "Running short and long SMART tests on new or replacement HDDs before trusting them in TrueNAS."
description: "TrueNAS SOP for identifying new drives, saving baseline SMART logs, running short and long SMART tests, and exporting the results for review."
showtoc: true
tocopen: true
---

## *<span style="color: #00ff7f">1. Prep for running `badblocks` (+ tmux)</span>*

***<span style="color: #ffff00">NOTE: badblocks will erase everything on the drive!!! Do not run if you have any data you value on the drive, or have created a pool!</span>***

Also - <span style="color: #ffff00">`/dev/sdX` is not stable!</span>

`/dev/sda`, `/dev/sdb`, etc. are assigned in whatever order the kernel enumerates devices at boot. After a reboot, an HBA reset, or a hot-swap, a drive that was sda yesterday can be sdc today. <span style="color: #ffff00">Running `badblocks -w /dev/sda` against the wrong drive is how you wipe a pool member.</span>

Always work via `/dev/disk/by-id/`. Those paths are bound to the drive's serial number / WWN and follow the drive across reshuffles.

<br>

*<span style="color: #00ff7f">1.1 Identify the exact replacement drives first</span>*

Do not trust old `/dev/sdX` names.

```bash
lsblk -d -o NAME,MODEL,SERIAL,WWN,SIZE,ROTA,TRAN
smartctl -i /dev/sdX
```

Write down:

`/dev/sdX = serial ______ = WWN ______ = physical bay ______`

Only continue when you know exactly which two drives are the replacements.

<br>

*<span style="color: #00ff7f">1.2 Make a log folder on a real path</span>*

Use the folder you already made:

```bash
mkdir -p /root/drive-tests/2026-05-15/badblocks
cd /root/drive-tests/2026-05-15/badblocks
pwd
```

<br>

Confirm you are there:

```bash
pwd
```

<br>


*<span style="color: #00ff7f">1.3 (Optional but recommended) Disable scheduled SMART tests in the UI</span>*

`System Settings -> Data Protection -> S.M.A.R.T. Tests`

(Since the SMART tests can interfere with the badblocks process)

<br>


*<span style="color: #00ff7f">1.4 Confirm drives and capture a BEFORE SMART snapshot per drive</span>*

Identify the drives by serial, not by `sdX`:
- `lsblk -d -o NAME,MODEL,SERIAL,WWN,SIZE,ROTA,TRAN`

<br>

Confirm none of the target drives are part of an existing pool:
```sh
zpool status
```

<br>

Capture a BEFORE SMART snapshot per drive

```sh
mkdir -p /root/drive-tests/$(date +%F)/badblocks
cd /root/drive-tests/$(date +%F)/badblocks

SERIAL=<DRIVE_SERIAL>
MODEL=<DRIVE_MODEL>     

smartctl -x /dev/disk/by-id/ata-${MODEL}_${SERIAL} \
  | tee BEFORE_${SERIAL}.txt
```


<br>

*<span style="color: #00ff7f">1.5 Disable scheduled SMART tests</span>*

SMART scheduled tests. If TrueNAS already has a SMART task scheduled (System Settings → Data Protection → S.M.A.R.T. Tests), it'll fire during your badblocks run and slow it down or get queued behind I/O. Worth disabling before, re-enabling after.

<br> 

## *<span style="color: #00ff7f">2. Start tmux</span>*





```bash
tmux new -s burnin
```
- *<span style="color: #ffff00">(NOTE: You can't do this as `root` for some reason. Use `exit` to exit `root` and become `truenas_admin` user again)</span>*

<br>

To detach later:

```bash
Ctrl+b, then d
```
<br>
To reattach later:

```bash
tmux attach -t burnin
```
<br>
To list tmux sessions:

```bash
tmux ls
```
<br>




*<span style="color: #00ff7f">3.1 Create X panes for your X HDDs</span>*

Become root inside tmux
- `sudo -s`
	- Use sudo -s specificially. Not sudu su -, or sudo -i

 <br>
 
- Before creating panes
	- <span style="color: #00ff7f">Bump the scrollback buffer - the default 2000 lines will not hold 8 days of verbose output:</span>

		- `Ctrl-B + :`
		- Then paste: `set-option -g history-limit 100000`
		- Press `<Enter>`
		- <span style="color: #ffff00">*(Do this before splitting the panes!</span> Otherwise you'll have to do it for each pane)*

<br>

Then:

- `Ctrl + B, then %`

- `Ctrl + B, then "`

- repeat until X panes

- move between panes: `Ctrl + B + arrow keys`

- `Ctrl-B z` - toggle **zoom** on the current pane (useful when monitoring one drive closely)






<br> 



<br>

### *<span style="color: #00ff7f">3. Launch `badblocks` in each drive's pane</span>*

Paste the code below in each pane, making sure to fill in values for `<DRIVE_SERIAL>` and `<DRIVE_MODEL>` 

<br>

*<span style="color: #ffff00">Remember: Identify the drives by serial, not by sdX:</span> `lsblk -d -o NAME,MODEL,SERIAL,WWN,SIZE,ROTA,TRAN`*

<br>
 
```sh
SERIAL=<DRIVE_SERIAL>
MODEL=<DRIVE_MODEL>
DEV=/dev/disk/by-id/ata-${MODEL}_${SERIAL}
 
date | tee START_${SERIAL}.txt
 
badblocks -b 8192 -c 8192 -wsv \
  -o badblocks_${SERIAL}.txt \
  "${DEV}" 2>&1 \
  | tee console_${SERIAL}.log
 
date | tee END_${SERIAL}.txt
```

<br>

*(Note: If you're doing two drives, you'd run the `SERIAL=... / MODEL=... / smartctl` ... block twice with different serials. The `mkdir/cd` only needs to run once.)*

<br>

*Flag explanation:*
 
| Flag | Why |
|---|---|
| `-b 8192` | Block size in bytes. **Required for drives >16 TB.** badblocks uses signed 32-bit integers for block counts in places; a 24 TB drive at `-b 4096` overflows (~5.9 × 10⁹ blocks > 2³¹). You'll get `Value too large for defined data type`. 8 KB blocks halve the count and fit. |
| `-c 8192` | Blocks per chunk = 64 MB working set. `-c 32768` (256 MB) is fine if you have RAM to spare; throughput difference on HDDs is unmeasurable because they saturate sequential I/O at far smaller chunk sizes. |
| `-w` | Destructive write-mode test. Writes four patterns: 0xaa, 0x55, 0xff, 0x00 — full drive each pass — with a read-verify after each. |
| `-s` | Progress display. |
| `-v` | Verbose. |
| `-o file` | Writes only the list of bad blocks to `file`. Empty if none found. Separate from the `tee` log. |
| `2>&1` | **Critical.** badblocks writes progress to stderr. Without `2>&1`, `tee` only captures the start/end banners — most of your log will be empty and you'll have no record if the run dies mid-way. |

<br>
 
### *<span style="color: #00ff7f">3. (Optional) Monitoring pane</span>*
 
In a separate pane:
 
```sh
watch -n 300 'for s in <SERIAL1> <SERIAL2>; do
  echo "=== $s ===";
  smartctl -A /dev/disk/by-id/ata-<MODEL>_$s \
    | grep -E "Temperature_Celsius|Reallocated|Pending|Offline_Unc|UDMA_CRC";
done'
```
<span style="color: #ffff00">*(Note: Replace `<SERIAL1>` with the actual serial number of your drives. This example is for only two drives. Add/subtract according to your needs)*</span>

Refreshes every 5 minutes. Lets you catch a drive overheating or starting to throw pending sectors without interrupting the badblocks run.

<br>
 
### *<span style="color: #00ff7f">4. Detach and wait</span>*
 
- `Ctrl-B d` <span style="color: #00ff7f">to detach from tmux</span>
- `exit` <span style="color: #00ff7f">from the SSH session — tmux keeps running</span>
- `tmux ls` to list all active tmux sessions
- Reattach later with `tmux attach -t burnin`
Expected wall-clock time for 24 TB drives at ~260 MB/s sequential:
 
- Per write pass: ~25.6 hours
- 4 patterns × (1 write + 1 read) = ~205 hours ≈ **8.5 days per drive**
- Running multiple drives in parallel doesn't extend the per-drive time as long as the HBA, PSU, and cooling can sustain the aggregate load

<br/>

---

<br/>

## *<span style="color: #00ff7f">After the run</span>*

<br>

### 1. Capture AFTER snapshots
 
```sh
smartctl -x /dev/disk/by-id/ata-${MODEL}_${SERIAL} \
  | tee AFTER_BADBLOCKS_${SERIAL}.txt
```
 
<br>

 
### 2. Run a SMART long test
 
```sh
smartctl -t long /dev/disk/by-id/ata-${MODEL}_${SERIAL}
```
 
Polling time for 24 TB drives is ~43 hours. After it completes:
 
```sh
smartctl -x /dev/disk/by-id/ata-${MODEL}_${SERIAL} \
  | tee AFTER_LONG_${SERIAL}.txt
```
 
<br>

### 3. What to look for
 
Compare BEFORE / AFTER_BADBLOCKS / AFTER_LONG outputs. **None of these counters should have moved off zero:**
 
- `Reallocated_Sector_Ct`
- `Current_Pending_Sector`
- `Offline_Uncorrectable`
- `Reported Uncorrectable Errors` (Device Statistics)
- `UDMA_CRC_Error_Count` (anything here is a cable / backplane / HBA issue, not the drive)
- `Pending Defects log` (must be empty)
- Reallocated Event Count
Should still be `100`:
 
- `Helium_Level` (for helium-filled drives)
Worth noting but not fail conditions:
 
- `Read Recovery Attempts` — expect a small number (single to low double digits) for a clean drive. A drive that needed many times more retries than its siblings under identical workload is a yellow flag, not a failure. Statistically correlated with above-average failure rate.
- `Lifetime Max Temp` — should stay below the drive's spec (typically 60 °C). If a drive ran significantly hotter than its siblings under the same workload, that's a chassis airflow issue, not a drive issue.

<br>

### 4. Re-enable scheduled SMART tests
 
Undo the UI change from step 6.
 
<br>

## Common pitfalls
 
- **Forgetting `2>&1` before `tee`** — silently produces near-empty log files. The single most common mistake with this command.
- **Using `/dev/sdX` instead of `/dev/disk/by-id/`** — a kernel reshuffle between reboots wipes the wrong drive.
- **Not verifying the drive isn't in a pool first** — `zpool status` takes two seconds.
- **Running tmux as root on TrueNAS SCALE** — hits the sudoers regression. Run as admin, `sudo -s` inside.
- **Using `sudo su -` or `sudo -i`** — triggers the same `argv[0]` mismatch.
- **Default scrollback buffer in tmux** — 2000 lines is not enough for 8 days of verbose output. Bump it.
- **Leaving scheduled SMART tests on** — they'll queue behind I/O and slow things down.
- **Forgetting that `-b 4096` overflows on >16 TB drives** — use `-b 8192` minimum. Some guides written before large drives existed still recommend 4096.

<br>

## What this doesn't catch
 
Burn-in is a high-confidence check that a drive isn't infant-mortality material. It is not a guarantee.
 
- Firmware bugs that manifest only under random I/O, specific access patterns, or unusual command sequences
- Slow mechanical or media degradation that only shows up after months of use
- Power-loss-protection failures
- Specific issues with the drive's behavior during ZFS resilver or scrub workloads
- Bugs in the HBA or its firmware
ZFS RAID-Z2 / RAID-Z3 / mirror redundancy is still the right way to actually protect data. Burn-in just lowers the probability that one of your redundancy slots is occupied by a ticking drive on day one.

<br>
 
## References
 
- [`badblocks(8)`](https://man7.org/linux/man-pages/man8/badblocks.8.html)
- [`smartctl(8)`](https://www.smartmontools.org/browser/trunk/smartmontools/smartctl.8.in)
- [`tmux(1)`](https://man7.org/linux/man-pages/man1/tmux.1.html)
- TrueNAS forum thread on the tmux/sudo regression: search "Is tmux broken on EE?" on the TrueNAS Community Forums


