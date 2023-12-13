---
title: 'DjangoCon US 2022'
date: '2022-10-19'
aliases:
  - /posts/djangocon-us-22-day-1
  - /posts/djangocon-us-22-day-2
  - /posts/djangocon-us-22-day-3
---

{{< toc >}}

## Day 1

### The Django Admin Is Your Oyster: Let’s Extend Its Functionality

- Don't make it easy for attackers to find your admin page...don't use `/admin`.
- Override `ModelAdmin.get_search_results` to speed up searching.
- Remember to use `prefetch_related` and `select_related` to reduce DB queries.
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

### Documenting Django Code in 2022

- [https://diataxis.fr](https://diataxis.fr): A framework for authoring technical documentation.

### You Don't Need Containers to Run Django in Production

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

### Herding your database queries: diagnosing, improving and guarding performance of DB interactions in your Django apps

- [Blog Post](https://engineering.pathai.com/herding-your-database-queries-in-django)
- Tools like `django-debug-toolbar` and `django-silk` are great for diagnosing rogue queries, but there can be cases where these tools are not going to help directly (e.g. with a js frontend).
- To solve this, they rolled their own [custom middleware](https://github.com/Path-AI/django-request-stats-example/blob/main/req_stats/middleware.py) to analyze queries per request and output the result to the terminal.

  ```
  Received request GET /library/books/, status 200, db_query_count=29, db_query_time_ms=136.421, duration_ms=192.56
  ```

- After you optimize your queries, you can protect yourself from regression with unit tests by taking advantage of [django_assert_max_num_queries](https://pytest-django.readthedocs.io/en/latest/helpers.html#django-assert-max-num-queries).
- You can also use [coverage context](https://coverage.readthedocs.io/en/6.4.3/contexts.html) to check new endpoints that are created and don't have unit tests.

### The Django Jigsaw Puzzle: Aligning All the Pieces

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

### Nurturing a "Legacy" Codebase

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

## Day 2

### Keeping track of architectural-ish decisions in a sustainable way

- The Problem
  - **Is there a problem?** Image a new coworker asks why a particular decision was made, but no one knows. We lose relevant information of the decision making process (e.g. context and alternatives considered).
  - **Why is this a problem?** We cannot reliably reflect on our decisions, onboard new people, or evolve.
  - **What's causing this?** Perhaps our tools are not specifically designed to capture changes, nor why they changed.
- Architectural Decisions: The thing we need to capture.
  - **Architectural Decisions (AD)**: A software design choice...that is architecturally significant. It's an AD if you need to ask:
    - Should we meet to discuss this?
    - What framework should we use?
    - Could we use [shiny-new-thing] for this?
  - **Architecturally Significant Requirement (ASR)**: A requirement that has a measurable effect.
- [Architectural Decision Record](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions) (ADR) [[also](https://18f.gsa.gov/2021/07/06/architecture_decision_records_helpful_now_invaluable_later/)]: The tool we can use to capture.
  - **What is an ADR?** A short, practical to fill, text file describing a specific AD. Like a journal entry to future developers.
  - **Who is it for?** Primarily for developers and technology staff.
  - **What's in it?**:
    - Context: Why did this need to happen? What need to be considered?
    - Options: What were the options? What were the pros/cons of each?
    - Consequences: What will happen as a result?
    - Status: Has the decision been implemented or superseded?
  - **Where does it live?** Close to code (benefits from peer reviewing and discoverability), wiki, or something else.
- Takeaways:
  - Leads teams to consensus.
  - Prevents knowledge hoarding.
  - Gets new maintainers up to speed.
  - Not one person with critical knowledge.
  - Shows maintainers if a change they'd like to do has been considered previously.
  - Can be used as justification to stakeholders.

### Django Migrations: Pitfalls and Solutions

- Migrations and Branches
  - Rewinding migrations only works if the relevant migration files are in the codebase, regardless of applied migrations.
  - This can cause problems when switching branches with divergent migrations. Solutions:
    - Reverse migrations before switching branches.
    - Restore a backup from before you ran either branch's migrations.
    - Use backward compatible migrations.
  - A similar problem occurs when trying to merge two branches with divergent migrations. Solution:
    - `python manage.py makemigration -merge`
- Reversible Migrations
  - Migrations are not time travel...database backups are!
  - Common rewind errors include, using `RunPython` with no reverse function, removing a constraint if data has been added that violates that constraint, or deleting a field that is non-null and has no default.
  - You can improve reversibility by backing up your database, set fields as nullable for some time before deleting them, and using a reverse function with `RunPython` (or at least use `noop`).
- Backwards Compatible Migrations
  - The Deployment Race Condition: When, during deployment, the codebase and database will be out of sync! This can cause errors on your site if a request comes in while they are out of sync.
  - Assuming you are adding to the database more often than removing, you can reduce the frequency of this issue by migrating the database first, then deploying your new code.
  - For all other cases, you should try to create backwards compatible migration, i.e. migrations that once applied still work with you old code before that it gets updated.
  - Some migrations trivially backwards compatible:
    - Ops with no DB schema change (RunPython, changing choices, squashing migrations, etc.)
    - Adding a nullable field.
    - Adding a model.
    - Removing/Relaxing a constraint.
    - Adding a constraint that all existing data/code already meets.
    - Removing a model that isn't referenced.
  - Others, are not. For those, we want to try and get those to "look" like the above list.
    - You can make some migration noops by using legacy database names.
      - To rename a field, set `db_column` to the old name, and django will not update the database.
      - To rename a model, set `db_table` to old name, and django will not update the database.
      - You can even move models between apps an avoid schema changes by using `db_table` and `SperateDatabaseAndState`.
    - You can decompose some migrations into two deploys.
      - Adding a constraint: First deploy code that satisfies constraint, then deploy migration to update data.
      - Removing a model: First deploy code that remove all references, then deploy migration to remove the model.
      - Remove a field: First deploy code that deprecates the field using `django-deprecate-fields` and remove all code references, then deploy migration to remove the field.
    - For all other, more complicated, cases, use scheduled downtime (maintenance mode).
      - Split/Merge fields/models.
      - Change field types.
      - Do "true" field/model renames.
      - Compress multiple releases into one.
- Failed Migrations
  - If your migrations fail, be aware that:
    - You should abort your deployment.
    - Each migration is atomic, but the group of them are not.
    - If your migrations are not backwards compatible, your users will be getting errors (unless you are in maintenance mode).
    - If your migrations are not backwards compatible, your database will be in an incompatible state, and you can't use `manage.py shell`.
  - To fix this:
    - Avoid this to begin with by testing against production data!
    - Correct data with `manage.py shell`, assuming your migrations were backwards compatible.
    - Push the broken migration onto the server (because you should have aborted the deployment), and reverse them (assuming they were reversible).
    - Restore database to a backup.
    - `manage.py dbshell`

### Django Through the Years

Not much to say about this, other than it was a very fun history lesson! ❤️

### Just enough ops for developers

My main takeaway here was the following [fastapi analogy](https://fastapi.tiangolo.com/async/):

- CPU = Cook
- Process = Cashier
- Request = Customer

### Your First Deployment Shouldn't Be So Hard!

Django is great, until you get to deployment, at which point there are a billion different ways to do it. This can be a barrier to entry for new developers and for experienced developers who need to prototype rapidly...enter `django-simple-deploy`.

Prerequisites:

- A simple Django project.
- Use requirements.txt, Poetry, or Pipenv.
- Use Git.
- Have the target platform's CLI installed with an active account.

```
$ pip install django-simple-deploy
# Add simple deploy to INSTALLED APPS.
$ manage.py simple_deploy --platform fly_io --automate-all
# Profit!
```

## Day 3

### Async Django: The practical guide you've been awaiting for.

- Async is exciting, but be aware that using async will make your application more complex.
- `import asyncio`: Python's implementation of an async runtime that Django uses.

  ```
  import asyncio
  async def foo():
    ...
    await bar()

  async def main():
    tasks = [asyncio.create_task(foo()) for range(5)]
    # Important! Wait for all tasks to complete.
    await asyncio.gather(*tasks)

  asyncio.run(main())
  ```

- Can you use this for background tasks?
  - Kind off...if it fails, there is no built-in statuses, retires, or error handling.
  - It depends...on how you are running Django (WSGI or ASGI). With WSGI, hitting an async view spins up an event loop, but will disappear when then view exits (like the example above).
- Aggregate Views (what you did before GraphQL):

  ```
  import httpx
  import asyncio

  async def aggregate_view(): # pseudo code
    async with httpx.AsyncClient() as client:
      response_a, response_b = asyncio.gather(
        client.get(view_a_url),
        client.get(view_b_url),
      )
    return JsonResponse({
      'response_a': response_a.json(),
      'response_b': response_b.json(),
    })
  ```

- Chat App (four ways):
  - Polling (HTMX): Simple, but doesn't scale, isn't responsive, and can lead to self DDOS.
  - Long Polling (HTMX + Channels): Responsiveness, but creates a lot connections.
  - Server-Sent Events (HTMX + Channels): Better, keeps the connection open.
  - WebSockets (HTMX + Channels): Also keeps the connection open, but allows two-way communication.

### Why large Django projects need a data (prefetching) layer

- "DRY isn't helpful if you need to be careful."
- Django REST Framework loves DRY, but has high change amplification as a side effect.
- Change Amplification: The expected number of places in the codebase that needs to be modified during an atomic change to the software.
- An example of this in DRF is needing to prefetch in serializers.

  ```
  class MovieSerializer(ModelSerializer):
    # data that requires prefetching

  # You have to remeber to prefetch for each view using MovieSerializer.
  class MovieListView(ListAPIView):
    queryset = Movie.objects.prefetch_related("directors")
    serializer_class = MovieSerializer

  class MovieDetailView(ListAPIView):
    queryset = Movie.objects.prefetch_related("directors")
    serializer_class = MovieSerializer
  ```

- You could do one of two things to combat this:
  1. Use non-DRF serializers that are very **explicit** about prefetching.
  - `django-virtual-models`.
  2. Or keep DRF, but:
  - Warn about missing prefetches for each serializer.
  - Automatically run necessary prefetches.
  - Automatically prevent unnecessary ones.
  - Keep serializer nesting support.
  - Keep `SerializerMethodField` support.
- TLDR: Use tools to be **explicit** about the data you expect from the DB. Otherwise you'll suffer from performance regressions and your read logic will break frequently.

### A pythonic full-text search

- PostgreSQL added full text search in 2008.
- Django added [full text search](https://docs.djangoproject.com/en/4.1/ref/contrib/postgres/search/) in 2016.
- Paolo has a [great article](https://www.paulox.net/2017/12/22/full-text-search-in-django-with-postgresql/) outlining the various search features.

### Home on the range with Django - getting comfortable with ranges and range fields

- Ranges are everywhere!
- Support for [ranges](https://docs.djangoproject.com/en/4.1/ref/contrib/postgres/fields/#range-fields) was added for PostgreSQL Django in 2015.
- The typical approach is to us "start" and "stop" fields, but that gets complicated fast.
  - The DB doesn't know these two fields are related.
  - You have to manually add bounding/validation/constraint logic.
  - Queries can get weird/complicated.
- Ranges fix all this!
  - 1 field that stores lower, upper, and boundary information.
  - Automatically validates/constrains values.
  - Easy/Intuitive queries.
- Ranges (Math):
  - Ranges = Intervals, Inclusive = Closed, Exclusive = Open
  - (exclusive, exclusive) - (1, 3) - 2
  - [inclusive, exclusive) - [1, 3) - 1, 2 `The default for Django ranges!`
  - (exclusive, inclusive] - (1, 3] - 2, 3
  - [inclusive, inclusive] - [1, 3] - 1, 2, 3
- There are lots of very useful query filters!
  - `__overlap`, `__contains`, `__adjacent_to`, `__fully_lt/gt`, etc.
- Django supports a number of different value types via `pysycopg2.extra`.
  - You can also create custom types! Example: IP ranges!
- Pitfalls
  - Limited Django Admin support.
  - You have to use `Cast` when using `F()`.
  - You have to use `Lower` and `Upper` database functions to access values.
- Resources
  - `psycopg2.extras`
  - `django-range-merge`
  - `django-generate-series`
