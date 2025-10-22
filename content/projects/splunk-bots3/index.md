---
title: "Projects Template"
date: 2025-10-16T12:26:32-07:00
draft: false
summary: "Spunk Bots Example"
tech: ["Hugo", "Go", "Splunk"]
tags: ["Template"]
role: ""
links:
  repo: ""
  demo: ""
cover:
  image: "cover.jpg"     # put alongside index.md
  caption: ""
---

## 🎯 Objective
State exactly what problem or goal the project addressed.  
Example: “Detect DNS exfiltration in the Splunk BOTS v3 dataset.”

---

## 🔧 Environment / Tools
List system setup and versions.

| Component | Purpose |
|------------|----------|
| Splunk 9.2 | SIEM and data analysis |
| Python 3.11 | Scripting and data parsing |
| Wireshark | Network packet inspection |

---

## 📐 Methodology
Explain *how* you approached the problem.

1. Describe setup or data ingestion.
2. Show key commands or configs in fenced code blocks:

   ```bash
   index=botsv3 sourcetype=dns earliest=-24h
   ```
   
3. Mention reasoning, patterns, or troubleshooting steps.

## 🔎 Results

Summarize measurable output, screenshots, or outcomes.

| Metric | Result |
|--------|:--------:|
| Queries built	| 12 |
| True positives | 	8 |
| False positives |	1 |

Include images:
![DNS exfiltration graph](/images/dns-exfiltration-example.png)

## 💡 Lessons Learned

Bullet or paragraph format works fine.

- Discovered that DNS queries with TXT records are common indicators.

- Learned how to filter out false positives using field qtype.

## ➡️ Next Steps

What would you add, automate, or scale?

- Automate query generation with Python.

- Integrate with an alerting system.

## 📍 References

- [Splunk BOTS v3 Dataset Docs](https://github.com/splunk/botsv3)

- [Wireshark Filters Cheat Sheet](https://wiki.wireshark.org/DisplayFilters)



<!--- optional for use

---
<br/>

## 📝️ Notes

| Topic | Explanation |
|--------|-------------|
| **`tech:`** | purely informational; use it to display your stack (e.g., Splunk, Docker).  It’s not a taxonomy unless you define it in `hugo.toml`. |
| **`tags:`** | these appear under `/tags/.../` and can group all templates, projects, etc. |
| **`ShowToc:`** | shows an auto-generated table of contents. |
| **`Images:`** | store them in `/static/images/` and reference with `/images/...`. |

---

## ✅ Result

When you run:

```bash
hugo server -D
```

You’ll get a proper **project page with TOC, cover image, and summary**, and it will also appear under:

/tags/template/
/categories/projects/

if `draft: false`.


--->
