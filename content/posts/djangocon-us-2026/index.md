---
title: "DjangoCon US 2026"
description: ""
date: 2026-08-31
tags: []
categories: []
draft: true
---

We are so back!

I couldn't attend DjangoCon last year in-person and I wasn't even able to attend virtually due to work. Thankfully I was able to make it this year and I had a wonderful time! I even got to take some great photos! Till next year! 🚀

{{< toc >}}

## Day 1

### Boldly Go, Building Worlds: Is there Room for me on the Bridge?
- How to be a builder?
	- Do the work in public.
	- Make room for people who don't have a seat at the table.
	- Stay accountable to your crew.
- How to build a team? Have a shared mission, goals, roles and responsibilities, ground rules, decision-making, and effective group processes.
- Make it so.

### GeoDjango at City Scale: Spatial Data for Urban Systems
- Note to self: Check out GeoDjango!

### Pragmatic AI: How to gain trust with user-centered AI adoption
- No AI dependencies.
- Have a responsible approach to AI.
- Be model and provider agnostic.
- Only include the right AI.
- Always allow the human to be in the loop.

### Lighting Talks
- django-absurd

### Search-as-you-type for 54 Million Names: PostgreSQL + Django for Fuzzy Name Matching at Scale

- Use Daitch-Mokotoff algorithm for phonetic text searching.
- Use Levenshtein algorithm for fuzzy string searching.
- Use indexes.

### Agents All the Way Down: How AI Coding Agents Changed How I Write Django
A really great story about how Josh has integrated AI into his workflow. I particualy emphathized with how AI has reduced his stress levels.

## Day 2

### Keynote: Emails from my Grandad
- Great advice on how we receive feedback (e.g. in code reviews) and how we should react to it. I'll be watching this one again.

### Batteries vs. Speed: The Django/FastAPI Debate
- Value team knowledge.
- Measure your workload.
- Buy batteries for leverage.
- Build when ownership is worth it.
- Choose constraints, not hype.

### The Testing Pyramid in Practice for Django
- Know the difference between `SimpleTestCase` and `TestCase`.

### Who Goes There? Actively Detecting Intruders With Cyber Deception Tools
- Assume you have been breached, especially now with AI constantly scrapping for secrets.
- Place honey/canary tokens everywhere to detect intruders that report when they have been accessed.
- Put them in private places, where no one is supposed to have access to.
- See canarytokens.org, canary.tools, github/honeytoken-putter
- Bonus: Places "context bombs" next to these tokens that tell the agents to do something explicitly bad that the provider auto classifiers block further action. Unproven, but nice to have.

### Open Spaces
I attended both the AI open spaces. The first one was about how our work has changed due to AI and how that makes us feel. The second was geared more towards the AI workflow everyone has landed on.

It was very interesting seeing the differences in opinions between these two sessions. That said, it was a much more relaxed and welcoming environment than "online spaces". I hope open spaces return next year!

## Day 3

### Keynote: Django 6: The Most Exciting Release Ever
- Python modern email API
- Content Security Policy
- Background Tasks
- Tempalte Partials

### Auto-prefetching with model field fetch modes in Django 6.1
- Before: Deferred model fields had to be fetched with `selected_related` or `prefetch_selected` to avoid "N +1" problems.
- After: You can set a `.fetch_mode(models.FETCH_PEERS)` to fetch these instances on demand.
- Status quo is `.FETCH_ONE` and there's also an option to raise when attempted to access an unloaded deferred field with `.FETCH_RAISE`.

### Enter the Ecosystem: Contributing to Django Open Source Projects
- A great introduction to contributing to open source projects by my coworker Andrew Selzer!

### Wishlist granted: HTMX without betraying your Django views
- TLDR: HTMX is great and you should continue to use it!
- v3 → v4: Tag inheritance is disabled by default now. You can disable it in v3 with the `disabledInheritance: true` setting.

### But did you know the browser already does that?
- Checkout "Baseline" for CSS browser compatibility statues.
- TLDR there's a lot of new powerful CSS features I've never heard about!

## Chicago

{{< gallery >}}