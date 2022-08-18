---
title: 'Quick Hugo Deploy with GitHub Actions'
description: If you want a quick (and free) way to deploy your Hugo site, using GitHub Action is a great option!
date: 2022-08-18
---

Once you have your [Hugo](https://gohugo.io) project setup, all you need to do is push the following GitHub Action to deploy! {{< twa rocket >}}

```
name: Build
on:
  push:
    branches: [main]
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: true
          fetch-depth: 0
      - uses: peaceiris/actions-hugo@v2
      - run: hugo --minify
      - uses: JamesIves/github-pages-deploy-action@v4
        with:
          branch: gh-pages
          folder: public
```

{{< html >}}

<figure><figcaption>.github/workflows/build.yml</figcaption></figure>
{{< /html >}}

This action does three things each time you push to `main`:

1. Pulls your repository, including all submodules.
2. Builds your site with the Hugo CLI.
3. Deploys the build to GitHub Pages via the `gh-pages` branch.

That's it. After a few moments, your site should now be live at:

```
https://<username>.github.io/<repository>/
```

If you want a custom domain for this site, you can [configure a custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages) with GitHub Pages.
