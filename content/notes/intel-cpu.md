---
title: "Intel CPUs"
date: 2025-11-09
draft: false
tags: ["hardware", "computing", "intel", "cpus"]
summary: "Technical notes, architecture breakdowns, and generation reference for Intel CPUs."
ShowToc: true
---

## Overview

Intel CPUs are divided into product tiers (i3, i5, i7, i9) and generations (e.g., 12th Gen “Alder Lake”, 13th Gen “Raptor Lake”, 14th Gen “Meteor Lake”).  


The first digit(s) in the CPU model number usually indicate the **generation**, while the suffix defines the **performance class**.

## How Intel CPU Naming Works

<span style="color: #00d28f">***1. Core tier: i3 / i5 / i7 / i9***</span>

This is the performance tier:

i3 = budget / entry-level (fewer cores, lower clocks)

i5 = mainstream (balanced price vs performance)

i7 = high-end consumer (more cores, higher turbo)

i9 = top-tier (maximum cores, clocks, cache)

<br/>

<span style="color: #00d28f">***2. Generation number***</span>

The first two digits after the dash show the generation (for most modern CPUs):

Example: i5-13600K

“13” → 13th generation (Raptor Lake, released 2022–2023)

Example: i7-9700K

“9” → 9th generation (Coffee Lake Refresh, released 2018–2019)

If it’s an older model (before 10th gen), it might only have one digit:

i5-8400 → 8th gen

i7-4790K → 4th gen

From 10th gen onward, Intel switched to five-digit model numbers, like 10400, 12400, etc.

<br/>

<span style="color: #00d28f">***3. SKU (model) number***</span>

The next two or three digits after the generation show the specific model within that generation.
Example:

i5-13600K → model “600” (mid-tier within i5 lineup)

i5-13400 → lower-end

i5-13900K → high-end (close to i9 performance)

Higher model numbers usually = more cores or better clocks.

<br/>

<span style="color: #00d28f">***4. Suffix letters (very important)***</span>

Letters after the number describe the type of chip:

K = unlocked (you can overclock)

KF = unlocked + no integrated graphics

F = locked + no integrated graphics

<span style="color: #00d28f">T = low-power desktop version</span> &larr; *(Note: Ideal for Low-Power Homelabs - what we're using)*

H = high-performance laptop chip

U = ultra-low-power laptop chip

G = includes discrete-class graphics

E / TE = embedded / industrial versions

<br/>

<span style="color: #00d28f">*Example:*</span>

i7-13700K → 13th-gen unlocked desktop CPU

i5-13400F → 13th-gen locked desktop, no iGPU

i7-12700H → 12th-gen laptop CPU, high performance

<br/>

<span style="color: #00d28f">***5. Quick comparison***</span>

|Example CPU	|Gen	|Tier	|Suffix	|Meaning|
|--------------|----------|----------|----------|---|
i3-12100 |	12th	|Entry	|none	|budget desktop|
i5-13500|	13th	|Mid	|none	|solid midrange desktop|
i7-13700K	|13th	|High	|K	|unlocked desktop|
i9-14900KF	|14th	|Top	|KF	|overclockable, no iGPU|
i5-1135G7	|11th	|Mid	|G7	|laptop, integrated Iris Xe GPU|

<br/>

<span style="color: #00d28f">***6. In short***</span>

The prefix (i3/i5/i7/i9) tells you the tier.

The first two digits tell you the generation.

The next two–three digits tell you the model ranking.

The suffix letter(s) tell you the type (desktop, laptop, low power, unlocked, etc).
