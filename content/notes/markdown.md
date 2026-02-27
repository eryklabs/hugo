---
title: "Markdown Language"
date: 2025-11-09
draft: false
tags: ["notes", "reference", "markdown", "formatting", "hugo", "joplin"]
summary: "References for using Markdown Language."
ShowToc: true
---

## Overview

Markdown is a lightweight markup language used to format text for notes, documentation, and websites. 


It converts plain text into structured HTML, making it ideal for fast, readable writing that looks clean in 
editors like Joplin and static site generators like Hugo. 


This note collects key syntax, shortcuts, and best practices for consistent formatting. 

---

## Key Details


- `**Bold**` for **emphasis**  
- `*Italics*` for *subtle context*  
- Inline ``` `code` ``` for commands or filenames  
- Left Arrow ( &larr;) with `&larr;` &nbsp;  *(See more below)*
- `&nbsp;` &nbsp; to &nbsp;  add &nbsp; an &nbsp; inline &nbsp; extra &nbsp; space


---

## Cheat Sheet / Quick Reference

### <span style="color: #00d28f">Arrows</span>

| Symbol | Description | Markdown Code |
|--------|--------------|----------------|
| ↑ | Up arrow | `&uarr;` |
| ↓ | Down arrow | `&darr;` |
| ← | Left arrow | `&larr;` |
| → | Right arrow | `&rarr;` |
| ↔ | Double-headed arrow | `&harr;` |

---

## Notes

Additional clarifications, context, or links:

- [Markdown entities list](https://www.w3schools.com/html/html_entities.asp)
- Works in HTML-rendered markdown (like Hugo).

---

## Commands I Use Often

```bash
# Example for Hugo
hugo new content/notes/new-note.md
hugo server -D
