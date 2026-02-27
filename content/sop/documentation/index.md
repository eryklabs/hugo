---
title: "GitHub Pages - Standard Operating Procedures (SOPs)"
date: 2025-11-05T09:00:00-07:00
draft: false
summary: "GitHub Pages: Step-by-step deployment procedures for hosting Hugo sites on GitHub."
description: "A complete SOP for deploying, updating, and maintaining Hugo sites using GitHub Pages."
showtoc: true
cover:
  image: "/images/github/github.svg"
  alt: "GitHub Pages SOP"
  caption: "Hugo Deployment via GitHub Pages"
  relative: false
---

These SOPs define the standard process for hosting and maintaining Hugo static sites through **GitHub Pages**.  
This covers both the **manual** and **automated (GitHub Actions)** workflows.

<br/>

---

## 1. **<span style="color:#00ff7f;">Initial Setup</span>**

1️⃣ Create a new repository on GitHub.  
Name it whatever you want — e.g. `eryklabs` or `my-hugo-site`.  

2️⃣ In your local machine, initialize your Hugo site (if not already done):

```bash
hugo new site my-hugo-site
```

## 2. **<span style="color:#00ff7f;">Push Updates to GitHub (Hugo Site)</span>**

This SOP covers the exact steps to commit and push changes (content, config, or theme updates) from your local Hugo site to GitHub.

Remember to make sure you have `cd`'d into your Hugo directory.
- `cd C:\folder\folder\eryklabs`

<br/>

### 1️⃣ Check Status

Before pushing, verify what’s changed:

```bash
git status
```
- Red files = modified or deleted but not staged

- Green files = staged (ready to commit)

<br/>

### 2️⃣ Stage Changes

To stage all new and modified files:

```bash
git add .
```

*(What this code does is "Add (stage) all changes in the current directory and its subdirectories to the next commit.")
- *(The "." means current directory, and everything inside of it, recursively.)*

Or, to stage specific files:

```bash
git add content/sops/hugo.md
git add config.toml
```

<br/>

### 3️⃣ Commit with a Clear Message

Commit all staged files:

```bash
git commit -m "Update SOPs and fix image paths"
```

Commit message format (recommended):

```vbnet
<category>: <short description>

Examples:
git commit -m "content: updated hugo commands section"
git commit -m "config: fixed baseURL for github pages"
git commit -m "images: replaced outdated hugo logo"
git commit -m "sops: added github push procedure"

```
<br/>

### 4️⃣ Push to GitHub (Main Branch)

Push your changes to the main branch:

```bash
git push origin main
```

If you’re using another branch (e.g. dev):
```bash
git push origin dev
```

<br/>

### 5️⃣ (Optional) Pull Latest Changes Before Next Edit

Before making more edits or switching devices, always sync your repo:

```bash
git pull origin main
```

This ensures you’re working on the most current version and prevents merge conflicts.

<br/>

### ✅ Summary

|Step	|Command	|Description|
|------------|----------|----------|
1|	git status	|Review what changed|
2|	git add .	|Stage all changes|
3|	git commit -m "..."	|Commit with message|
4|	git push origin main	|Push updates|
5|	git pull origin main	|Sync next time|
