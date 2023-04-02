---
title: 'PyTexas 2023: Day 1'
date: '2023-04-01'
description: 'My notes from #pytexas 🐍 day 1.'
---

## [Keynote: Walking the Line](https://www.pytexas.org/schedule/keynotes#brandon-rhodes)

_Amazing keynote, and I will definitely watch it again when it's uploaded to YouTube!_

- Make small, incremental, and easy to understand changes.
- Test often and fail quickly.
- Orient yourself by checking an expected failure.

## [A Tale of Two Typings](https://www.pytexas.org/schedule/talks#a-tale-of-two-typings)

- Legacy code is simply code without ~~tests~~ types.
- Define your types, don't just inline them.

## [Trust Fall: Hidden Gems in MLFlow that Improve Model Credibility](https://www.pytexas.org/schedule/talks#trust-fall-hidden-gems-in-mlflow-that-improve-model-credibility)

_The talk focused on machine learning, but I think this can still apply outside of that._

- Build trust through documentation and reproducibility.

## [Exploring Socio-technical Security Concerns in Critical Open-source Python Repositories](https://www.pytexas.org/schedule/talks#exploring-socio-technical-security-concerns-in-critical-open-source-python-repositories)

- Catalyst: Someone intentionally introduced bad code into Linux for a research paper.
- Pull requests power open source contributions.
- FOSS needs to be careful what gets merged in.

## [A BuildEngineer in a buildless lang](https://www.pytexas.org/schedule/talks#a-buildengineer-in-a-buildless-lang)

- Improve development by reducing stylistic diffs and increasing semantic diffs.

## [Recursion for Beginners: A Beginner's Guide to Recursion](https://www.pytexas.org/schedule/talks#recursion-for-beginners-a-beginners-guide-to-recursion)

- All recursive solutions have an iterative solution.
- Unless you are dealing with trees, avoid recursion.

## [Improving code without losing your mind](https://www.pytexas.org/schedule/talks#improving-code-without-losing-your-mind)

- https://blog.alexewerlof.com/p/tech-debt-day/
- We tend to focus on getting features out the door.
- Like an artist, programmers should improve -- refactor -- their art.
- Set aside time to improve -- refactor -- your code.
- Make code understandable and obvious.

## Lightning Talks

- Make code obvious. Otherwise, make it familiar. Otherwise, make it well-documented. Start by making it obvious!
- For demos/testing, you can `pip install` packages directly inside of the Python Interpreter!

```python
>>> import pip
>>> pip.main(["install", "django"])
```
