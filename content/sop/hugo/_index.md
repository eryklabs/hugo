---
title: "Hugo - Standard Operating Procedures (SOPs)"
date: 2025-10-19T12:26:32-07:00
draft: false
summary: "Hugo: Documented step-by-step systems and procedures I’ve built or standardized."
description: "A collection of repeatable workflows for Hugo website builder."
showtoc: true
cover: 
  image: "/images/hugo/hugo-logo-wide.svg"
  alt: "Hugo SOPs for Building Websites"
  caption: "Hugo SOPs for Building Websites"
  relative: false
---




These SOPs serve as detailed, repeatable checklists for Hugo, a simple yet powerful website editor. 

{{< figure src="hugo-logo-wide.svg" alt="Hugo Logo" title="" >}}

<br/>

---

**<span style="color: #00ff7f">Most basic commands and sequences to remember:</span>**

<br/> 



## 1. Hugo Startup (Local)

Starting up your Hugo Site Locally

### 1. Open your terminal or PowerShell and cd into your site’s root directory — the one that contains config.toml, themes/, and content/.

`cd D:\path\to\your\hugo-site`

### 2. Start the local server

Run this command:

`hugo server`

or if you want it to automatically rebuild on file changes:

`hugo server -D`

### 3. Open in your browser

Once it starts, Hugo will print something like:

`Web Server is available at http://localhost:1313/`

Open that URL in your browser.

<br/>

---


## 2. Correct global image locations (for Cover Image in Frontmatter)

If you want images available globally (to any page or post), use:

`/static/images/`


So in your filesystem:

`C:\Projects\ProjectName\static\images\homelab\example.jpg`


Then anywhere in your Markdown:

`![My Logo](/images/logo.png)`


That will render correctly on both the local server and deployed site, because /static maps directly to the web root /.


For example, on this page, the Hugo logo is inserted via this code snippet in the frontmatter:

`cover:`

`image: "/images/hugo/hugo-logo-wide.svg"`

<br/>

---


## 3. Insert an image into the page

If you don’t need custom margins or width:

`![Example text](/images/image.jpg)`

Example used at the top of this page:

`![Hugo logo](/images/hugo/hugo-logo-wide.svg)`


<br/>

---

## 4. Insert code block 

**Like this:**

```
  ```bash
  hugo server -D```
```  
<br/>
  
**Explanation:**

Start of code block → 
``` 
```bash ```
```

tells Markdown “start a fenced code block” and “use Bash syntax highlighting.”
(The word bash is optional — it just enables color-coding for shell commands.)

<br/>

**Result:**

```bash
  hugo server -D
```
  
  
  <br/>
  
  ---
  
  ## 5. Make a hyperlink open in new tab
  
  **Option 1:**
  
  Markdown itself doesn't support opening links in a new tab. 
  
  To do so, we'll have to insert HTML inside Markdown, like so: 
  
  `Check out <a href="https://eryklabs.com" target="_blank" rel="noopener noreferrer">my site</a>.`
  
   **Option 2:**
   
   Make all external links open in new tabs automatically

Add this JavaScript snippet to your PaperMod footer partial or via custom JS (e.g., /assets/js/custom.js):

```html
<script>
document.querySelectorAll('a[href^="http"]').forEach(link => {
  if (!link.href.includes(window.location.hostname)) {
    link.setAttribute('target', '_blank');
    link.setAttribute('rel', 'noopener noreferrer');
  }
});
</script>
```
