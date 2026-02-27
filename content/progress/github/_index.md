---
title: "GitHub Progress Log"
date: 2025-10-25T13:04:32-07:00
draft: false
summary: "Progress Log for GitHub Learning and Deployment"
tech: ["progress log", "github"]
tags: ["github"]
layout: "list"
showtoc: true
role: ""
links:
  repo: ""
  demo: ""
cover:
  image: "/images/github/github.svg"     
  caption: ""
---

![GitHub](/images/github/github.svg)

## 🌐 Overview
Tracking setup, learning, and deployment to GitHub, for future reference. 

---

### 📅 2025-10-25

**Step 1: Initialize Git in Hugo Site Folder**

```bash
cd C:\Projects\eryklabs   # ← your folder
git init
git add .
git commit -m "Initial commit"
```
<br/>

**Step 2: Create a GitHub repo**

Go to https://github.com/new

Repository name: hugo (or whatever matches your site name).

Leave it Public or Private (up to you).

Don’t initialize it with a README, .gitignore, or license — you already have a local repo.

Click Create repository.

<br/>

**Then run these commands:**

```powershell
git remote add origin https://github.com/YOUR_USERNAME/hugo.git   # ← I named it "hugo" because I'm using hugo to build my website
git branch -M main
git push -u origin main
```

<br/>

**STEP 3 – Verify**

After the push, go to your GitHub repo URL — it should now show your Hugo project files (config.toml, etc.). *(See image below)*

![Initial Commit to GitHub](/images/github/initial_commit.png)


<br/>

---


## Attribution

*GitHub logo courtesy of GitHub.com*