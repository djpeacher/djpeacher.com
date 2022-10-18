---
title: 'DjangoCon US 2022: Day 1'
date: '2022-10-17'
description: 'My notes from #djangocon 🦀 day 1.'
---

## [The Django Admin Is Your Oyster: Let’s Extend Its Functionality](https://2022.djangocon.us/talks/the-django-admin-is-your-oyster-lets-its/)

- Don't make it easy for attackers to find your admin page...don't use `/admin`.
- Override `ModelAdmin.get_search_results` to speed up searching.
- Remember to use `prefetch_realted` and `select_related` to reduce DB queries.
- Add optional checkboxes to change forms to kickoff extra functions when saved.
  - You can also dynamically set help text for better UX.
- You can use multiple databases in a single admin.

  ```
  # Migrate
  $ python manage.py --database=sandbox

  # settings.py
  DATABASES = {
    'default': {...},
    'sandbox': {...}
  }

  # utils.py
  class SandboxAdminModel(admin.ModelAdmin):
    using = 'sandbox'

    def save_model(self, request, obj, form, change):
        obj.save(using=self.using)

    def delete_model(self, request, obj):
        obj.delete(using=self.using)

    def get_queryset(self, request):
        return super().get_queryset(request).using(self.using)

  # admin.py
  @admin.register(MySandboxModel)
  class MySandboxModelAdmin(SandboxModelAdmin):
    ...
  ```

- Extend `change_form.html` to add help text for the whole model, not just fields.

  ```
  # change_form.html
  {% extends "admin/change_form.html" %}

  {% block form_top %}
    {{ original.admin_help_text }}
  {% endblock %}

  # models.py
  class MyModel(models.Model):
    admin_help_text = "..."
  ```

- Create custom actions for bulk changes.

  ```
  # admin.py
  def increase_msrp_by_8_perc(modeladmin, request, queryset):
    ...

  @admin.register(Car)
  class CarAdmin(admin.ModelAdmin):
    actions = [increase_msrp_by_8_perc]
  ```

## [Documenting Django Code in 2022](https://2022.djangocon.us/talks/documenting-django-code-in-2022/)

- [https://diataxis.fr](https://diataxis.fr): A framework for authoring technical documentation.

## [You Don't Need Containers to Run Django in Production](https://2022.djangocon.us/talks/you-don-t-need-containers-to-run-django/)

- When **should** you use containers? When you have...
  - Thousands of programmers.
  - Millions of users.
  - Billions in valuation.
- There is a lot of FOMO around containers. For example, reproducibility is a big selling point for containers, but generally, this benefit is rarely taken advantage of.
- Some downsides of using containers are added [complexity](https://landscape.cncf.io) and cost.
- What do we want in production?
  - Secure environment.
  - Protection against malicious users.
  - Don't want to wake up in the middle of the night.
  - Seamless code updates.
- Web Server (WSGI vs ASGI):
  - WSGI is 20 years old...and it shows.
    - Limited concurrency.
    - Graphic: _Showed that as clients scale with `gunicorn`, response time gets worse. The graph represented a BEST case scenario._
  - ASGI is 5 years old...and it shows.
    - Unlimited concurrency (ignoring memory).
    - Graphic: _Showed that as clients scale with `uvicorn`, response time gets worse. The graph represented a WORST case scenario._
- Reverse Proxy (nginx):
  - Can help limit concurrency as needed.
  - nginx can handle 20 million RPM on a 8 core VM.
  - Caddy is a new/easier alternative, but nginx is tried and tested.
- Process Monitor (SystemD)
- Deployment (Git Deploy Config)
- Bonus Tip: Use software that offers LTS.

# [Herding your database queries: diagnosing, improving and guarding performance of DB interactions in your Django apps](https://2022.djangocon.us/talks/herding-your-database-queries-diagnosing/)

- [Blog Post](https://engineering.pathai.com/herding-your-database-queries-in-django)
- Tools like `django-debug-toolbar` and `django-silk` are great for diagnosing rogue queries, but there can be cases where these tools are not going to help directly (e.g. with a js frontend).
- To solve this, they rolled their own [custom middleware](https://github.com/Path-AI/django-request-stats-example/blob/main/req_stats/middleware.py) to analyze queries per request and output the result to the terminal.

  ```
  Received request GET /library/books/, status 200, db_query_count=29, db_query_time_ms=136.421, duration_ms=192.56
  ```

- After you optimize your queries, you can protect yourself from regression with unit tests by taking advantage of [django_assert_max_num_queries](https://pytest-django.readthedocs.io/en/latest/helpers.html#django-assert-max-num-queries).
- You can also use [coverage context](https://coverage.readthedocs.io/en/6.4.3/contexts.html) to check new endpoints that are created and don't have unit tests.

## [The Django Jigsaw Puzzle: Aligning All the Pieces](https://2022.djangocon.us/talks/the-django-jigsaw-puzzle-aligning-all/)

- (other) MVC == MVT (django)
  - Model == Model
  - View == Template
  - Controller == View
- The Django Admin is great, but if your `admin.py` is growing past 20 lines, you might be relying on it too much.
- `django-extensions`: One of the things it does is auto import models in the django shell.
- Don't use `/admin`!

```
                                        WSGI Server
                                        ┌────────────────────────────────────────────────┐
                                        │ Middlware                                      │
                                        │ ┌────────────────────────────────────────────┐ │
                                        │ │ Django app                                 │ │
         HTTP request                   │ │ ┌────────────────────────────────────────┐ │ │
        ─────────────► ┌──────────┐ ──► │ │ │ ┌────────┐     ┌─────┐     ┌──────┐    │ │ │   ┌─────────┐
Browser                │Web Server│     │ │ │ │URL conf│ ──► │     │ ─── │Models│ ───┼─┼─┼── │Databases│
        ◄───────────── └──────────┘ ◄── │ │ │ └────────┘     │     │     └──────┘    │ │ │   └─────────┘
         HTTP response      ▲           │ │ │                │Views│                 │ │ │
                            │           │ │ │                │     │     ┌─────────┐ │ │ │
                            ▼           │ │ │                │     │ ─── │Templates│ │ │ │
                         ┌──────┐       │ │ │                └─────┘     └─────────┘ │ │ │
                         │ File │       │ │ └────────────────────────────────────────┘ │ │
                         │System│       │ └────────────────────────────────────────────┘ │
                         └──────┘       └────────────────────────────────────────────────┘
```

## [Nurturing a "Legacy" Codebase](https://2022.djangocon.us/talks/nurturing-a-legacy-codebase/)

- What is a "legacy" codebase?
  - Code with, potentially forgotten, history.
  - Code that follow outdated conventions.
  - Usually still running in production.
- Should you evolve or rebuild? Ask yourself...
  - Does the code meet current requirements?
  - Are there frequent or sever production issues?
  - How healthy are the dependencies?
- Lets say you choose "evolve," what should you do?
  - Automated tests with good coverage.
  - Upgrade/Replace outdated dependencies.
  - Use a linter and/or `black` for code formatting.
  - Use `pre-commit` for cross-team consistency.
  - Make sure current devs understand the story of the code.
  - Help future devs by writing detailed commit messages along with an issue tracker.
  - Document!
  - Build a culture of leaving clues for the future!
