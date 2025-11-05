---
title: "AutoHotkey (AHK) - Standard Operating Procedures (SOPs)"
date: 2025-11-03T17:32:32-07:00
draft: false
summary: "AHK: Reference notes and step-by-step systems for keyboard automation, macros, and workflow shortcuts."
description: "Practical AHK scripts, templates, and automation standards for Windows productivity."
showtoc: true
cover:
  image: "/images/ahk/ahk-logo.png"
  alt: "AutoHotkey Logo"
  relative: false
---

These SOPs serve as a reference and memory base for using AutoHotkey: mapping shortcuts, automating repetitive sequences, and controlling Windows programs with precision.

<!-- {{< figure src="/images/ahk/ahk-logo.png" alt="AHK Logo" title="" >}} --> 

<br/>

---


## 1. Startup and Script Management

### 1. Open AHK Script
Right-click any `.ahk` file → **Run Script**  
To edit → **Edit Script** (opens in Notepad or your preferred editor).

### 2. Launch AHK on Windows Startup
Create a shortcut to your AHK script and place it in:

`C:\Users<username>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`

## 2. Useful Syntax and General Overview
 
### 1. Common Keycodes

`^` = Ctrl

`!` = Alt

`+` = Shift

`#` = Win

Example:
`#n::Run, notepad.exe` → Press Win+N to open Notepad.

### 2. Common Workflow Examples

|Action	| Command	| Example |
|------------|----------|----------|----------|
Send text	| `Send, text`	| `Send, Hello World`
Open program|	`Run, path`	| `Run, C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe`
Reload script|	`^!r::Reload` 	| Ctrl+Alt+R reloads your active script
Exit script|	`^!q::ExitApp`	| Ctrl+Alt+Q quits AHK
Comment a line|	`;` |	`; This is a comment`

### 3. Useful Built-in Variables


|Variable	| Description |
|------------|----------|----------|----------|
|`%A_ScriptDir%` |	Directory of the running script|
|`%A_Desktop%` |	Path to the user desktop |
|`%A_Temp%` |	Path to Windows temporary folder |
|`%A_Hour%, %A_Min%, %A_Sec%` |	Current time |


<br/>

---

<br/>

## 3. Useful Scripts / Shortcuts / Macros I've Made

### 1. Markdown
#### 1. <span style="color: #00d28f;">Ctrl + Alt + B</span> = Insert Break, Line Separator, and Break

```AHK
; ===========================================
; Inserts line break separator block for Markdown/HTML spacing (edit 11/3/25)
; Explanation:
; 	^!b = Ctrl + Alt + B (no major software conflicts)
; 	SendRaw = sends text exactly as written (without interpreting symbols)
; 	`n = newline
; ===========================================

^!b::SendText("<br/>`n`n---`n`n<br/>")	; ^!b:: = Ctrl + Alt + B
```
<br/>

This will insert the following text:

```markdown
<br/>

---

<br/>
```
<br/>

This is very useful for formatting, when creating notes in Joplin, or creating content within Hugo (such as this very page). 
I found myself typing out `<br/>` `---` `<br/>` a bunch of times over and over, so this saves a lot of time within those programs (and anywhere markdown is used). 


<br/>

---

<br/>

## Reference Links

<a href="https://www.autohotkey.com/docs/" target="_blank" rel="noopener noreferrer">Official AHK Documentation</a>

<a href="https://www.autohotkey.com/boards/" target="_blank" rel="noopener noreferrer">AutoHotkey Forum</a>

<a href="https://github.com/Lexikos/AutoHotkey_L" target="_blank" rel="noopener noreferrer">AHK GitHub Repository</a>