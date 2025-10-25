---
title: "Hugo Website"
date: 2025-10-24T12:26:32-07:00
draft: false
summary: "Building and customizing eryklabs.com using Hugo, PaperMod, and Cloudflare for my portfolio and documentation site."
tech: ["Hugo", "PaperMod", "Markdown", "GitHub Pages", "Cloudflare"]
tags: ["webdev", "portfolio", "hugo"]
role: "Designer / Developer"
links:
  repo: "https://github.com/eryklabs/eryklabs-site"
  demo: "https://eryklabs.com"
cover:
  image: "/images/hugo/hugo-logo-wide.svg"     # global images stored in /static/images folder
  caption: "Live Hugo server preview"
---

## 🎯 Objective
To design and deploy a minimal, high-performance personal website and knowledge base using Hugo and PaperMod — optimized for cybersecurity, engineering, and creative projects.

---

## 🔧 Environment / Tools

| Component | Purpose |
|------------|----------|
| **Hugo Extended v0.136+** | Static site generator |
| **PaperMod Theme** | Clean, fast, minimal theme for portfolios |
| **GitHub Pages** | Free hosting + build automation |
| **Cloudflare DNS** | Custom domain + SSL |
| **VS Code + Git** | Content creation and version control |
| **Windows PowerShell** | Local Hugo server + automation scripts |

---

## 📐 Methodology

1. **Local Setup**
   - Installed Hugo Extended on Windows  
   - Created new site:  
     ```bash
     hugo new site eryklabs
     ```
   - Added PaperMod theme as a Git submodule  
   - Customized theme settings in `config.toml`

2. **Version Control**
   - Initialized Git repo  
   - Connected to GitHub for auto-deploys with GitHub Actions  

3. **Deployment**
   - Configured Cloudflare DNS (`A`, `CNAME`, and `TXT` for SPF/DKIM/DMARC)
   - Tested build via:
     ```bash
     hugo server -D
     ```

4. **Customization**
   - Modified home layout, colors, and menu structure  
   - Added **Projects**, **Progress Logs**, and **Notes** sections  
   - Configured custom social icons, analytics, and contact page  

---

## 🔎 Results

| Metric | Result |
|--------|:--------:|
| Build Time | < 500 ms |
| PageSpeed Score | 98% |
| GitHub Deploy Time | ~20s |
| Domain | eryklabs.com (live) |

### Visual Preview
![Local Hugo Preview](/images/hugo-local-preview.png)

---

## 💡 Lessons Learned

- Hugo’s structure (content → layout → static → public) is intuitive once understood.  
- PaperMod’s YAML front matter supports flexible metadata and clean summaries.  
- Learned to automate build/deploy workflow using **GitHub Actions**.  
- Understanding **relative vs absolute links** and how `baseURL` affects image paths was key.  
- Discovered how to use **shortcodes**, **partials**, and **archetypes** to standardize pages.  

---

## ➡️ Next Steps

- Add automated changelog / progress log section for projects.  
- Implement tagging and search functionality.  
- Create shell script to auto-run `cd` + `hugo server -D` for local preview.  
- Explore integration with **Cloudflare Pages** for faster build and cache purge automation.  
- Add a “dark/light mode toggle” in header.  

---

## 📍 References

- [Hugo Documentation](https://gohugo.io/documentation/)
- [PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki/)
- [Cloudflare Pages Setup](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/)
- [GitHub Actions for Hugo](https://github.com/peaceiris/actions-hugo)

---

## 📝 Notes

| Topic | Explanation |
|--------|-------------|
| **`tech:`** | Displays key technologies used on the project card (e.g., Hugo, Markdown, GitHub). |
| **`tags:`** | Groups related content under `/tags/` pages. |
| **`cover.image:`** | Place in same folder as this `index.md` for automatic PaperMod rendering. |
| **`summary:`** | Appears on home and list pages under title. |

---

## ✅ Result

Running:

```bash
hugo server -D
