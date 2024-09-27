---
title: "DjangoCon US 2024"
description: ""
date: 2024-09-23
tags: []
categories: []
---

I wasn't able to attend in person this year or take too many notes due to work, but I was able to enjoy a few great talks in between things! Here's to next year! 🤞🏼

{{< toc >}}

## Day 1

### Choosing Wisely: SPA vs. HTMX for Your Next Web Project

- Three options: Static HTML, Progressive Enhancements, SPA
    - ← more server data, short user sessions
    - → more client data, long user sessions
- Static HTML is fast and simple, but not very interactive.
- SPAs are interactive, but expensive and complicated.
- PEs provide the best of both worlds.

### Error Culture

> [Error culture] accepts error notifications and ignores them, encouraging a reactive firefighting culture, instead of a proactive culture of problem-solving.

- Are you in error culture?
    - Is your deleted items filled with lots of emails from no-reply style email addresses that you didn't even read...you just deleted them?
    - Do you have a rule that just deletes emails?
    - Do you get alerts and have no idea why or what to do about them?
    - Are people rewarded for waiting until problems they knew about are big enough to alert everyone about and then resolve them?

> Don't take down a fence unless you know why it was put up. -- Chesterson's Fence

- Ask yourself these questions when managing alerts:
    - Is the alert important?
    - Is the alert actionable?
    - Who is the alert for?
- Venn Diagram:
    - !Actionable + Important + Right People = Confusion
    - Actionable + !Important + Right People = Time Waste
    - Actionable + Important + !Right People = Frustration
    - Actionable + Important + Right People = Best Case

 ### Product 101 for Techies and Tech Teams

- What your PM really wants:
    - A team that is interested in the strategy
    - Genuine interest in solving problems
    - Empathy with end users
- PM responsibilities
    - Empower their team with strategic insights
    - Translate strategy into proposed actionables
- Team responsibilities
    - Take interest in the strategy
    - Pay attention to details and quality
    - Care for the user experience, from start to finish
- Becoming a product-minded engineer
    - Be interested in the business and its user base
    - Stay curious
    - Provide relevant input
    - Be an ally to your PM

 ### Passkeys: Your password-free future

- django-allauth now supports passkeys!

The magical incatation! 🪄

```
# The main setup.
MFA_SUPPORTED_TYPES = ["webauthn"]
MFA_PASSKEY_LOGIN_ENABLED = True
MFA_WEBAUTHN_ALLOW_INSECURE_ORIGIN = True
MFA_PASSKEY_SIGNUP_ENABLED = True

# Allow email recovery.
ACCOUNT_EMAIL_REQUIRED = True
ACCOUNT_EMAIL_VERIFICATION = "mandatory"
ACCOUNT_EMAIL_VERIFICATION_BY_CODE_ENABLED = True

# Allow creation without username.
ACCOUNT_AUTHENTICATION_METHOD = "email"
ACCOUNT_USERNAME_REQUIRED = False
```

### The art of (not) redirecting

> Your URLs are a mirror to the soul of your code.

- Naming is hard, so:
    - Design as best as you can.
    - Break as little as possible.
    - Avoid 404s at all costs.
- Status codes that will help!
    ```
    302_FOUND
    301_MOVED_PERMANENTLY
    307_TEMPORARY_REDIRECT
    308_PERMANENT_REDIRECT
    ```
- The art of not redirecting (or how to design URLs):
    - **Readable**: People will read them, some will even type them by memory.
        - ❌ `/u/d/1/c/~q/page`
        - ✔️ `/user/profile`
    - **Predictable**: People should be able to guess-navigate your site by rewriting
URLs.
        - ✔️ `/user/profile/`
        - ✔️ `/user/settings/`
        - ✔️ `/user/security/`
    - **Concise**: Straight to the point, no redundancy.
        - ❌ `/user/user-settings/security-settings`
        - ✔️ `/user/settings/security`
    - **Complete**: Every part must lead to somewhere, or at least redirect to somewhere else.
        - ✔️ `/user/settings/security`
        - ✔️ `/user/settings`
        - ✔️ `/user`
    - **Consistent**: Single language, single style.
        - ❌ `/current_user/Seguridad/multi-factorAuth`
        - ✔️ `/current-user/security/multi-factor-auth`
    - **Beautifu**l: Well at least not ugly.
- The art of redirecting (or how to avoid 404s at all costs):
    - `django.contrib.redirects`, but that only works for static routes.
    - For dynamic routes, they first used a middleware that mapped their old namespace to a new namespace.
    - This only works for a single mapping, but what if you want to change them again? They implemented `path(..., old=[...])`.

### ❤️ Django: the web framework that changed my life

## Day 2

### Keynote: How To Be A Developer and Other Lies We Tell Ourselves

> To be a better developer is to be a better person to others.

### Lightning Talks

- [Django Commons](https://github.com/django-commons)!
- [Twelve rules for job applications and interviews](https://vurt.org/articles/twelve-rules/) by Daniele Procida

### ❤️ Finding 2.0

- The hesitation to call your project 2.0 is a lot like imposter syndrome.
- How to find your 2.0:
    - **Intention**. Intention to find your 2.0.
    - **Assessment**. Where is your starting point.
    - **Vision**. What is your destination.
    - **Acceptance**. Prepare for breaking changes.
    - **Plan**. Plan each version with a release date!
- When to start?

> Now is better than never -- The Zen of Python

> Change is coming. Change is inevitable. The question isn't if we are going to change, but how. Because we're either going to change by design or by disaster -- Annie Leonard

> Don't wait for disaster, 2.0 is not sacred.


### You got that nice tech salary, now what?

- You got that nice tech salary, now what?
    - Set financial goals
    - Determine savings needs ([nesteggly.com](https://nesteggly.com))
    - Determine current expenses (last 3-6 months) ([ynab.com](https://ynab.com))
        - Determine fixed, adjustable, and unexpected expenses.
        - Be aware of "Hedonic Treadmill": A permanent increase in expenses for a temporary increase in pleasure.
            - Example: buying better coffee and not being able to go back
    - Define a monthly budget
    - Check-in every 3-6 months
    - Max out your tax-advantaged accounts
    - Index funds
    - Term life insurance
    - Check out /r/personalfinance/wiki
- But where do we put our money to grow?!
    - Not your savings account (but do have 3-6 months of expenses there!)
    - Use any employer match.
    - Max out tax-advantaged accounts
        - Roth/Traditional IRA
        - 401k
    - Purchase low-cost, broad market, index funds.
        - 50% US stocks
        - 30% International stocks
        - 20% Bonds
        - Stocks = Higher reward, riskier
        - Bonds = Lower reward, less risky
        - Index funds track a collection of stocks index funds that outperform managed funds.

### How to design and implement extensible software with plugins

- [pluggy](https://github.com/pytest-dev/pluggy)
- [DJP: Django Plugins](https://djp.readthedocs.io/en/latest/)

## Day 3

### ❤️ Keynote: The Fellowship of the Pony

### ❤️ Hidden gems of Django 5.x

### ❤️ A Brief History of Django

### Django User Model: Past, Present, and Future

> "We should push the user model back to being Django's responsibility and address that leak." -- Carlton Gibson

- Universal Concerns
    - User Contract
    - Separation of authentication from authorization
    - Forms
- django-allauth solves many of these problems.
- My Current Approach
    1. Custom user model
    2. User profile model on 'User'
    3. Use 'django-allauth' 3rd party package
    - Custom user model (empty) + django-allauth = my preference

 ### API Maybe: Bootstrapping a Web Application circa 2024

> Lean into Django.

> Django has always been the framework for perfectionists with deadlines. When those deadlines are financial, all the more so. Django is the perfect web framework for our post-zero percent interest rate world.

 > Locality of Behavior is a starting point not a destination

 > [Locality of behavior] is a tool, not an end in itself.

 - Tools to achieve locality of behavior:
    - [Neapolitan](https://github.com/carltongibson/neapolitan)
    - [django-template-partials](https://github.com/carltongibson/django-template-partials)
    - [HTMX](https://htmx.org/)
    - [Alpine.js](https://alpinejs.dev/)
    - [Tailwind CSS](https://tailwindcss.com/)
