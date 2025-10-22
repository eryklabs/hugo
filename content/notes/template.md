---
title: "Template - Notes"
date: 2025-10-16
draft: false
tags: ["template","hugo", "markdown", "learning"]
summary: "Personal notes and tips for building Hugo sites efficiently."
ShowToc: true
---

## Formatting Tricks
To center a column in Markdown tables:
```bash
|:--------:|
```
This centers the column text.


## Commands I Use Often
```bash
hugo server -D
hugo new content/blog/new-post.md
```

## Things to Note
- Never run ```hugo``` from inside ```/content/```
- ```paginate``` was replaced by ```pagination.pagerSize```

Now when you run the server, you’ll have:

[http://localhost:1313/notes/template](http://localhost:1313/notes/template)

