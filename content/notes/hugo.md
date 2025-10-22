---
title: "Hugo"
date: 2025-10-17
draft: false
tags: ["hugo", "markdown", "learning"]
summary: "Personal notes and tips for building Hugo sites efficiently."
ShowToc: true
---

## ✍️ Formatting Tricks
To center a column in Markdown tables:
```bash
|:--------:|
```
This centers the column text.


## 🖥️ Commands I Use Often
```bash
hugo server -D
hugo new content/blog/new-post.md
```

## 📝 Things to Note
- Never run ```hugo``` from inside ```/content/```
- ```paginate``` was replaced by ```pagination.pagerSize```

Now when you run the server, you’ll have:

[http://localhost:1313/notes/template](http://localhost:1313/notes/template)

## 📑 HTML
Getting Hugo to list pages in descending order date (newest --> oldest), vs. ascending order

1. Open ```themes/PaperMod/layouts/_default/list.html``` since we're using the PaperMod theme
2. Change ```{{- range $index, $page := $paginator.Pages }}``` to ```{{- range $index, $page := $paginator.Pages.ByDate.Reverse }}```

