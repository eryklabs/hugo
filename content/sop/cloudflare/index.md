---
title: "Cloudflare Pages - Standard Operating Procedures (SOPs)"
date: 2025-11-05T09:00:00-07:00
draft: false
summary: "Cloudflare Pages: Step-by-step procedure to host Hugo sites for free using Cloudflare Pages."
description: "A complete SOP for connecting a GitHub-hosted Hugo site to Cloudflare Pages for free hosting."
showtoc: true
cover:
image: "/images/cloudflare/cloudflare-pages.svg"
alt: "Cloudflare Pages SOP"
caption: "Hugo Deployment via Cloudflare Pages"
relative: false
---

This SOP defines the exact process for hosting a Hugo site for free using Cloudflare Pages, starting from the point where your Hugo site is already pushed to GitHub.

<br/>


## Push Hugo Site to Cloudflare for Free Hosting (Cloudflare Pages)

### 1️⃣  Prepare Your Hugo Repo on GitHub

Make sure:

Your site’s repo (e.g., `eryklabs`) contains the full Hugo project — not just the public/ folder.

There’s a valid `hugo.toml` or `config.toml` file in the root.

Your Hugo theme is either:

included as a **Git submodule**, or

copied into `/themes/`.

Check by running locally:

```bash
hugo server
```

If it builds correctly, it’s ready.

<br/>

### 2️⃣  Go to Cloudflare Pages

- Visit: https://dash.cloudflare.com/

- Log in (or create a free account).

Then:

1. Search "Pages" in the top right search box. Click on "Workers and Pages", and select the "Pages" tab.

2. Click “Import an existing Git repository.”

3. Choose “Connect to Git.”

4. Select GitHub, authorize access, and choose your Hugo repo.
- *(Note: "Install & Authorize" for "Only select repositories". Granting access to "All repositories" leads to unnecessary exposure. In my case I only chose the `eryklabs` repository.)*

5. Follow the steps for "Deploy a site from your account."

<br/>

### 3️⃣  Configure the Build Settings

When Cloudflare asks for build options, set them exactly like this:

|Setting	|Value|
|------------|----------|----------|----------|
Framework preset	|`Hugo`|
Build command	|`hugo`|
Build output directory	|`public`|
Environment variable	|`HUGO_VERSION = 0.151.0` (or whatever version you use locally)|

If you’re using **Hugo extended** (for SCSS, etc.), use:

```ini
HUGO_VERSION = 0.151.0
HUGO_ENV = production
```

Then click **Save and Deploy**.

<br/>

### 4️⃣  Wait for the Build

Cloudflare will automatically:

- Pull your repo from GitHub

- Run the Hugo build

- Host it on a free .pages.dev subdomain (like eryklabs.pages.dev)

If it succeeds, the log will end with something like:

```nginx
Site successfully built and deployed!
```

<br/>

### 5️⃣  Connect Your Custom Domain

Once the `.pages.dev` version works:

1. In the Pages project dashboard → “Custom domains” (Next to "Metrics")

2. Click “Set up a custom domain”

3. Enter your domain: eryklabs.com

4. Cloudflare will give you DNS records to add:

- `CNAME www → eryklabs.pages.dev`

- Optional: `A` record for the root (`@`) if needed

If your domain is already on Cloudflare DNS, it’s automatic.

*(Note: Make sure your domain is managed by Cloudflare DNS, for this to work correctly)*

<br/>

### 6️⃣  Connect Your Custom Domain

Redirect `www` to Root (or vice versa)

Sidebar → Click `Rules` → Create Rule → Redirect Rules:

To make `www.eryklabs.com` → `eryklabs.com`:

Select `Redirect from WWW to root [Template]`

<br/>

### 7️⃣  Verify HTTPS and Cache

Cloudflare automatically gives:

- Free HTTPS (no certificate setup needed)

- CDN caching and DDoS protection

<br/>

### 8️⃣  Optional (but Recommended) - Edit hugo.toml:

Add this to your `hugo.toml`:

```toml
baseURL = "https://eryklabs.com/"
```

Then rebuild and push again:

```bash
git add hugo.toml
git commit -m "update baseURL for deployment"
git push
```





