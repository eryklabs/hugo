---
title: "Homelab"
date: 2025-10-17T12:26:32-07:00
draft: false
summary: "Homelab for learning cybersecurity, networking, and experimenting"
tech: ["homelab", "Go", "Splunk"]
tags: ["homelab"]
role: ""
links:
  repo: ""
  demo: ""
cover:
  image: "cover.jpg"     # put alongside index.md
  caption: ""
---

## 🎯 Objective
To create a functional homelab not only for learning, but for practical uses in security, home networking, and real-world applications.

---

## 🔧 Environment / Tools
List system setup and versions.

| Component | Purpose |
|------------|----------|
| HP EliteDesk 800 G4 Mini i7-8700T 2.4GHz 16GB RAM | Main Server |
| Python 3.11 | Scripting and data parsing |
| Wireshark | Network packet inspection |

---

## 📐 Methodology

Researching and implementing the following services:

1. Pi-Hole
	- Blocking ads

  

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
