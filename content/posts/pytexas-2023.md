---
title: 'PyTexas 2023'
date: '2023-04-02'
aliases:
  - /posts/pytexas-23-day-1
  - /posts/pytexas-23-day-2
---

{{< toc >}}

## Day 1

### Keynote: Walking the Line

_Amazing keynote, and I will definitely watch it again when it's uploaded to YouTube!_

- Make small, incremental, and easy to understand changes.
- Test often and fail quickly.
- Orient yourself by checking an expected failure.

### A Tale of Two Typings

- Legacy code is simply code without ~~tests~~ types.
- Define your types, don't just inline them.

### Trust Fall: Hidden Gems in MLFlow that Improve Model Credibility

_The talk focused on machine learning, but I think this can still apply outside of that._

- Build trust through documentation and reproducibility.

### Exploring Socio-technical Security Concerns in Critical Open-source Python Repositories

- Catalyst: Someone intentionally introduced bad code into Linux for a research paper.
- Pull requests power open source contributions.
- FOSS needs to be careful what gets merged in.

### A BuildEngineer in a buildless lang

- Improve development by reducing stylistic diffs and increasing semantic diffs.

### Recursion for Beginners: A Beginner's Guide to Recursion

- All recursive solutions have an iterative solution.
- Unless you are dealing with trees, avoid recursion.

### Improving code without losing your mind

- https://blog.alexewerlof.com/p/tech-debt-day/
- We tend to focus on getting features out the door.
- Like an artist, programmers should improve -- refactor -- their art.
- Set aside time to improve -- refactor -- your code.
- Make code understandable and obvious.

### Lightning Talks

- Make code obvious. Otherwise, make it familiar. Otherwise, make it well-documented. Start by making it obvious!
- For demos/testing, you can `pip install` packages directly inside of the Python Interpreter!

```python
>>> import pip
>>> pip.main(["install", "django"])
```

## Day 2

### Keynote: Full-Stack Python

- Python is the ~~second~~ best language for [doing] everything [together].
- **Simple** is better than **complex**.
- **Python** transforms us from **programmers** into **problem solvers**.
- Aside from HTML/CSS, the entire stack can be built with Python!
- HTMX 😍

### Unlocking the Power of Health Data: An Introduction to FHIR and Python

- Healthcare coordination is a mess, with no interoperability.
- Enter the Electronic Health Record, but it had low adoption because it was only a syntactic protocol.
- Enter HL7FHIR which was syntactic, semantic, and even had an API scheme.

### Having fun with application design

- **Empathize** -- Curiosity about your users.
- **Define** -- Understand a problem.
- **Ideate** -- Creativity in idea generation.
- **Prototype** -- Build the right thing.
- **Test** your assumptions.

### How to Build and Ship More Secure Python Apps with Sigstore

- You wouldn't pickup and chew gum (FOSS) from a wall would you? Would you!?
- Attacks on FOSS are increasing, and Sigstore hopes to fix this.
- [ttl.sh](https://ttl.sh/), an anonymous and ephemeral Docker image registry.

### HoloViz: Visualization and Interactive Dashboards in Python

- [HoloViz](https://holoviz.org/), a framework for developing data visualization dashboards.

### Put your Pants on and lint all your Python code!

- [Pants](https://www.pantsbuild.org/), a fast, scalable, user-friendly build and developer workflow.
- [Ruff](https://beta.ruff.rs/docs/), an extremely fast Python linter.

### Using Python for Digital Investigations

- Digital Investigations (open-source research), research that uses info that is publicly available.
- Research sources include public geospatial, media, user-generated, and archive data.
- Open-source research and software have similar names, different histories, and both use Python as their language of choice.

### Lightning Talks

- Schools, when compared to industry, focus on code instead of other import aspects like tests, documentation, and collaboration.
- Book Recommendations
  - Being Geek: The Software Developer's Career Handbook
  - A Philosophy of Software Design
  - Think Like a Programmer: An Introduction to Creative Problem Solving
- Single click to select by character, double click to select by word, triple click to select by line!
