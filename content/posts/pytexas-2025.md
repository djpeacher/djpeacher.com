---
title: PyTexas 2025
description: ''
date: 2025-04-15
tags: []
categories: []
---

{{< toc >}}

## Day 1

### Keynote: Mariatta

❤️

### Reducing the "Oops Factor": Pipelines for Securing your Python Development Lifecycle on a budget

- More projects are having security issues, especially now with AI and vibe coding.
- A "swish cheese" approach to securing your codebase, most of which can be integrated into your CI pipeline.
  - Secret Detection: [gitleaks](https://github.com/gitleaks/gitleaks)
  - Dependency Scanning: [pip-audit](https://github.com/pypa/pip-audit)
  - SAST (Static Analytis Security Testing): [bandit](https://github.com/PyCQA/bandit)
  - DAST (Dynamic Analysis Security Testing): Dastardly / Tenable
  - YOU

### The Pythonic Ideal in The Age of Generative AI

- AI ← LLM ← Coding Assistant
- An experienced engineer is defined by their experiences, not by the duration of their role.
- Pros/Cons of using a coding assistants:

| Coding assistant | Beginners | Experienced |
| --- | --- | --- |
| Write code fast | Con | Pro (for boilerplate) |
| Write code beyond skill level | Pro/Con | Pro/Con |
| Explain code | Pro | Pro |
| Find bugs | Pro/Con | Pro/Con |
| Hallucinate | Con | Con |
| Vibe coding | Con | Con |
| Viable pair programmer | - | Pro |
| Ethical issues | - | Con |

- If you are a beginner, write code first, then use AI to explore when stuck, but make sure to understand the generated code.
- If you are experienced, let AI write the boring stuff (boilerplate, consistent code, etc.), and level up by prompting for code beyond your comfort zone (ask for options).
- If you are a teacher, use AI from the start. Ask it to suggest alternatives to existing code.
- Will AI replace you? Maybe. It will if you refuse to evolve with it.
- Is pythonic code dead? Maybe. But be kind to future developers (including yourself).
- Takeaways:
  - LLMs are just fancy autocomplete
  - If we over-rely on AI when first learning, we run the risk of not gaining the experience needed to grow.
  - AI is a tool, nothing more.
- Advice:
  - Don't panic
  - Learn your craft
  - Embrace AI
  - Teach the next generation
  - Keep it pythonic

### Generators: The Unsung Hero of Async Programming

- The `GeneratorExit` exception can be to cleanup generators.
- You can send data back into a generator using `.send(x)` and `x = yield y`.

### Demystifying AI Agents with Python Code

- What are AI agents?
> "agent = llm + memory + planning + tools + while loop" – Tweet

- You can give the ChatGPT API memory by including the previous messages in subsequent API requests.
- You can tell the ChatGPT API to use tools (functions), to do things like searching the web, that returns structured data.
  - You can use `.signature()` to generate the function specs for these tools.
- Tools like [crewAI](https://github.com/crewAIInc/crewAI) abstract all this away.

### Python Untethered: Building Robust Embedded Systems
- What are embedded systems?
> "...[an] embedded system is a device that contains a computer that the average person would not consider being a computer." – Reddit

### Lighting Talks

- `pip install interrogate` for docstring coverage.

## Day 2

### Keynote: Jay Miller

- Contributing to open source and community are similar.
  - You have an idea and want to share it with others.
  - When you give away your ideas, they only tend to get better.
- "Creating a new open source package (and community) is like adopting a puppy." - Pamela Fox
- Let people know what help you need, and vice versa.
- Autocorrect "LGTM" to "Looks good to me, thank you!" and don't say "just x".
- There is always more that you could have done, but if you are doing something, it is helpful.
- Respect everyone's capacity.
- Ambition + Inspration = Scope Creep

### Building a Test Framework From Scratch (Or Not)!

- What is a testing framework? A programming structure for coding automated test cases, executing them as a suite, and reporting their results.
- Just use `pytest`.

### Place-making and Productivity: Build Maintainable Broad-scale Tools With a Small Team
- `pain = n_teams * size_team * n_tools * n_migrations * (1 + r_turnover)`

### Verbs, Not Nouns: Writing Documentation Users Want to Read

- Two types: Reference / Tutorial
- Reference (Nowns): Comprehensive, focuses on the product, quick retrieval
  - e.g. man pages, api reference, code coments, readme files.
- Tutorial (Verbs): Not comprehensive, focus on the user, and read beginning to end
  - e.g. tutorials, how-tos, walkthroughs, use cases
- Outline your doc first:
  - What do you want user to do?
  - Ask the users, if you can
  - Write down everything
  - Define discrete steps
  - Prioritize the use cases
- Advice
  - Look for the verbs
  - Focus on what the users want to do
  - Move the verbs up front

### Lighting Talks

- LLMs are like APIs. You make a request, and they return data, but with "moods".
- Micromentor with SLQAR: Show up, listen, question, act, recharge.
- How to say thanks to Python People:
  - Level 0: Actually say thanks
  - Level 1: Say thanks in public
  - Level 2: Show your support
  - Level 3: Contribute/volunteer
  - Level 4: Contribute money
  - Level 5: Nominate them for awards
- Be kind to your screen sharing partner. Just share the window or tab.
- "Make friends, not connections" - Kojo