---
title: 'DjangoCon US 2022: Day 3'
date: '2022-10-19'
description: 'My notes from #djangocon 🦀 day 3.'
---

## [Async Django: The practical guide you've been awaiting for.](https://2022.djangocon.us/talks/async-django-the-practical-guide-you-ve/)

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

## [Why large Django projects need a data (prefetching) layer](https://2022.djangocon.us/talks/why-large-django-projects-need-a-data/)

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

## [A pythonic full-text search](https://2022.djangocon.us/talks/a-pythonic-full-text-search/)

- PostgreSQL added full text search in 2008.
- Django added [full text search](https://docs.djangoproject.com/en/4.1/ref/contrib/postgres/search/) in 2016.
- Paolo has a [great article](https://www.paulox.net/2017/12/22/full-text-search-in-django-with-postgresql/) outlining the various search features.

## [Home on the range with Django - getting comfortable with ranges and range fields](https://2022.djangocon.us/talks/home-on-the-range-with-django-getting/)

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
