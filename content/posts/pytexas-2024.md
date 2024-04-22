---
title: 'PyTexas 2024'
description: ''
date: 2024-04-21
tags: []
categories: []
---

{{< toc >}}

## Day 1

### Keynote: The Design of Everyday APIs

- The Design of Everyday Things - Don Norman
- Good API design is **intuitive**, **flexible**, and **simple**.
- Intuitive:
  - Use domain nomenclature
  - Clumsy naming hints at clumsy abstractions
  - Provide symmetry
- Flexible:
  - Provide sane defaults
  - Minimize repetition
  - Be predictable and precise
  - Let users be lazy
- Simple:
  - Provide composable functions
  - Leverage language idioms
  - Provide convenience
- Provide a good README:
  ```
  # README
  ## Installation
  ## Get Started
  ## Learn More
  ```

### Python Code vs Pythonic Code

- Experts "recognize", beginners "reason"
- Python Power Moves
  - Decorators
  - Comprehensions
  - Generators
  - Slicing
- Why is python hard?
  - Python code != Pythonic code
  - Python code != <any other language's concepts>
  - Python is (too) easy
  - What memory
  - Python needs _lots_ of testing
  - All about those libraries...

### ContainerCraft: Mastering Efficient Integration Testing

- https://testcontainers.com/

### Anarchy to Order - Organizing Assorted Data with Python and LLMs

- Links in a graph are not enough, we need to label those links to create a knowledge graph.
- Graph databases (like [Neo4j](https://github.com/neo4j/neo4j)) does this!
  - No FKs, very flexible, label relationships

### Lessons Learned Maintaining Open-Source Python Projects

- **What is a maintainer?** They keep projects operational and in an appropriate condition.
- **What is not a maintainer?** Someone who adds new features or fixes issues...that would be a contributor.
- **What does a maintainer do?**
  - Ensures package and information about it is discoverable.
  - Ensures consumption and contribution is familiar.
  - Sets ground rules (hint: CODE_OF_CONDUCT.md).
  - Triages incoming bug reports (hint: use templates).
  - Grooms and rejects incoming feature requests (hint: think of long-term good rather than short term gain).
  - Reviews pull request (hint: require tests, changelogs, ruff code reformatting, and commit squashing when needed).
  - Cuts releases with a changelog (hint: think small and often. have version and deprecation policies).
  - Thanks contributors.
  - Ensures the projects architecture remains consistent.
  - Lets other people help (hint: CONTRIBUTING.md).
  - Ensure CI remains green and fast (hint: don't forget to rebuild docs, add pull request warning).
  - Fosters community (hint: issue tracker, slack/discord, social, stack overflow).
  - Mentors and convert good contributors to co-maintainers.
  - Ensures they can keep doing it (hint: priorities mental and physical health, it's okay to step away)
- **Why be a maintainer?**
  - Looks good on your CV.
  - Gives opportunities to meet people.
  - Mentoring experience.
- **How to be a maintainer?**
  - Pick something you use actively use on a semi-regular basis.
  - Read the docs in detail.
  - Practice by trying to solve an issue and reach out to the current maintainer.
  - Know communication is deceptively hard, we all have different communication styles.
    - Be polite and patient, and give people the benefit of doubt.

### Working with Audio in Python

- Very cool lesson on how digital audio works.
- [Pedalboard](https://github.com/spotify/pedalboard) provides useful abstractions around audio files.
- Always process audio files as a stream to handle any size of input.
- Use [numpy](https://github.com/numpy/numpy) for faster operations.

### Rest Easy with Jupyrest

- [Jupyrest](https://github.com/microsoft/jupyrest) turns jupyter notebooks into json APIs.

### Iterate, Iterate, Iterate!

- [more-itertools](https://github.com/more-itertools/more-itertools) 😍

### Voice Computing with Python in Jupyter Notebooks

- You can write faster (and avoid RSI) by using your voice instead of typing.
- You can be even faster by defining text replacement commands (e.g. "insert code block").

### Lightning Talks

- You can make LLMs smarter by feeding it new data in the system prompt.
- [Recurse Center: Social Rules](https://www.recurse.com/social-rules)
  - No well-actually’s
  - No feigned surprise
  - No backseat driving
  - No subtle -isms
- How to give a talk:
  1. Be Engaging
  2. Be Loud
  3. Be Big (60pt font)
  4. Be Prepared
  5. Be Considerate
- Tips for giving a good talk:
  - Tell a story
  - Find your signposts (break points)
  - Practice
  - The energy you give is energy you get
  - expect (and prepare for) the unexpected

## Day 2

### Keynote: Thriving with Python

- **How do we succeed in a polyglot world?** Choose the best language for the job.
- **How do we avoid the pitfalls?**
  - Avoid chasing speed. All languages have tradeoffs.
  - Avoid swooning at shiny. All languages will eventually bloat.
  - Avoid hype and FOMO. Pretend it's the news.

### 20 GOTO 10: How to Make Scrolling ASCII Art

> There will always be new forms of art.

- What is [Scroll Art](https://scrollart.org/)?
  - ASCII art
  - Terminal/console output of monospace text
  - Previously printed text scrolls up (and only up)
  - You can't erase the text you've printed
  - You can't move the cursor to arbitrary XY coordinates
- Why?
  - Easy to understand. Input is text, output is text.
  - Any computer can run them.
  - Easily accessible. Can us any language.
  - Easy way to start learning/teaching code.

### System Design on Easy Mode

- **Durable execution** is a higher level of abstraction for writing functions that are guaranteed to complete running.
- How? https://temporal.io/

### Building Efficient Containers for Python Applications

- Docker + Python is initially straightforward, but tricky to optimize.
- Why should I care?
  - Slower build times lead to decreased productivity and ability to fail fast.
  - Larger image sizes lead to more storage requirements and longer download times.
- How do we measure efficiency?
  - Image size
  - Build time (no cache)
  - Rebuild (no change)
  - Rebuild time (with code change)
  - Rebuild time (with dependency change)
- Possible Optimizations:
  - Layer Ordering: Order matters. Ex. install deps before copying code.
  - Pin deps & Disable pip cache: Deps have deps, pin those too. You don't need pip to cache inside an image.
  - Smaller Base Image: Removes build tools saving storage. Install only needed tools, install, and then remove tools.
  - Combining Layers: Chaining commands on same `RUN` can save on storage.
  - Multi-stage Build: Using `builder` stage to create venv to use in `runner` stage saves space from discarded `builder` stage.
  - Cache mount: Saving pip cache on your machine saves redownloads.
- Other best practices:
  - Always use a Python-specific .dockerignore file
  - Separate Dev and Prod dependencies
  - Use the latest Debian/Ubuntu/Redhat distribution to base from
  - Try to avoid specifying the Python patch version in the base image
  - Use CPU specific vs GPU specific image

### Always Use Sets

- Always use sets because they...
  - clearly communicate expectations
  - prevents unexpected drift in behavior
  - allow us to write algorithms based on discrete math
  - add clarity to the code through set operations
  - are faster than lists or tuples - even when 10 items are changed
  - worthwhile even if you have to sort or combine later
- Except...
  - when you are running out of memory
  - when you have a dict that is equally idiomatic

### Oh the (Methods) You Can (Make): By Dunder Seuss

- Very charming story time summary of the many...many dunder methods! ❤️

### Sanely Working With Legacy Code

- What is legacy code?
  - Code without documentation.
  - Code without tests.
  - Code with poorly written test that is hard to change.
  - Code which you are not familiar with and often not your idea.
  - Valuable code which you are not comfortable changing.
- The Plan
  - Begin with understanding the code we want to improve
  - Check that our understanding of the code matches what is expected
  - Add tests
  - Make changes
  - Communicate our changes to the code effective to others on our team

### Lightning Talks

- [flet.dev](https://flet.dev/), multi-platform apps
- Use `watchfiles` to auto run dev commands on save (e.g. linting, testing, etc.)
- Game Jam == Hackathon for games
