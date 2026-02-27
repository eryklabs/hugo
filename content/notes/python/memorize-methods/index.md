---
title: "How to Memorize Python Methods (4-Question Method)"
date: 2026-01-23
draft: false
summary: "A practical framework for learning and recalling Python methods."
tags: ["python", "learning", "methods"]
showtoc: true
---

## The 4-Question Method

You don’t memorize method lists. That’s a waste of time.

You memorize patterns.

Here’s the only mental model that works long-term:

<br/>

***The 4-Question Method (this is the core skill)***

Every time you touch a variable, ask in this order:

1️⃣ <span style="color: #00d28f;">What type is this?</span>

```python
type(message)
```
<br/>

If you don’t know the type, you’re guessing. 

<br/>

*Do this to figure out the type:*

```python
print(type(message))
```

<br/>

or in PyCharm:

- hover over `message`
- or temporarily insert the print

You must see output, e.g.:

`<class 'str'>`

Don't proceed until you've figured out the type.

<br/>

2️⃣ <span style="color: #00d28f;">What problem am I trying to solve?</span>

Examples:

- Break text apart → `split`

- Glue text together → `join`

- Clean text → `strip`, `replace`

- Inspect text → `startswith`, `isdigit`

<br/>

Methods exist because these problems are common.

<br/>

3️⃣ <span style="color: #00d28f;">Does this problem belong to the object or the algorithm?</span>

<br/>

Rule:

- If the action is about the data itself, it’s probably a **method**

- If it’s about logic across many things, it’s probably a **function**

<br/>

Examples:

```python
message.split()      # about THIS string
len(message)         # general operation
sorted(items)        # general algorithm
```

<br/>

4️⃣ <span style="color: #00d28f;">Ask Python what’s available (no memory required)</span>

<br/>

In REPL / PyCharm:

```Python
dir(message)
```

This is not cheating. This is how professionals work.

You’ll see:

```Python
split
replace
strip
lower
upper
startswith
endswith
```

Your brain will naturally start recognizing:

“Oh, text cleanup → string methods”