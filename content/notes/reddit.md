---
title: "Reddit JSON"
date: 2026-04-08
draft: false
tags: ["reddit","research","json","python", "data analysis"]
summary: "Technical notes on Reddit JSON and working with Reddit datasets"
ShowToc: true
---

## REDDITS JSON STRUCTURE

`post = data[0]["data"]["children"][0]["data"]`

### same thing as above, just less confusing
`title = post["title"]`
`subreddit = post["subreddit"]`



## mental model of how Reddit structures JSON
```bash
data (list)
├── [0] → post folder
│    └── data
│         └── children (list)
│              └── [0] → actual post
│                   └── data
│                        └── title
```
