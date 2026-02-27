---
title: "Image Processing & Integration - Standard Operating Procedures (SOPs)"
date: 2025-11-07T12:00:00-07:00
draft: false
summary: "Automated, privacy-safe image preparation and uniform insertion for eryklabs.com."
description: "Step-by-step workflow for preparing, resizing, compressing, and inserting images into Hugo pages consistently."
showtoc: true
cover:
  image: "/images/hugo/image-majick-logo.svg"
  alt: "Image Processing SOP"
  caption: "Consistent, privacy-safe image workflow for Hugo"
  relative: false
---

These SOPs define the **exact system** for image preparation and insertion on eryklabs.com — ensuring privacy-safe, lightweight, and uniform visuals across all pages.

<br/>

---

## 1. **<span style="color:#00ff7f;">Objective</span>**

Create a single streamlined workflow to safely and consistently prepare images for eryklabs.com — including EXIF stripping, compression, and responsive resizing — using one PowerShell command.

<br/>

---

## 2. **<span style="color:#00ff7f;">Recommended Tool</span>**

Use **ImageMagick** — lightweight, free, and ideal for automation.

**Install (Windows):**
```powershell
winget install ImageMagick
