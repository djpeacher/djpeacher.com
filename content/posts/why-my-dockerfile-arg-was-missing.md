---
title: Why My Dockerfile ARG Was Missing
date: 2023-06-13
---

I was doing some cleanup in a Dockerfile today when I noticed one of the packages was not on the correct version. It was on the latest version despite the fact there was an `ARG` pinning it...or so I thought. After some sleuthing, I found this helpful [Stack Overflow post](https://stackoverflow.com/a/56748289) that explained and pointed me in the [right direction](https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact).

Turns out...

> "An `ARG` declared before a `FROM`...can’t be used in any instruction after a `FROM`."

So the reason my package was installing the latest version was because the `ARG` didn't exist! Conveniently, it also didn't error, which is why it went unnoticed 🙃

The solution? Move the `ARG` down one line after the `FROM`.

```
# Bad
ARG VERSION=1.2.3
FROM ...

# Good
FROM ...
ARG VERSION=1.2.3
```
