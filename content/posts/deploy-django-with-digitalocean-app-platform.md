---
title: 'Deploy Django with DigitalOcean App Platform'
date: 2023-06-22
tags: ['django-4.2']
---

I've tried a variety of different ways to deploy Django projects over the last five years, and they all seem a bit overcomplicated. I would very much like to focus less on the infrastructure part of web development, and more on making cool stuff, particularly with Django. To that end, I've been looking for a simple[^1] and cheap[^2] way to throw a Django projects onto the internet, and I think DigitalOcean's [App Platform](https://www.digitalocean.com/products/app-platform) is the best I've found so far.

The rest of this post is based[^3] on [DigitalOcean's tutorial](https://docs.digitalocean.com/tutorials/app-deploy-django-app/), but stripped down for anyone who just wants a TLDR on how to chuck a Django project[^4] onto the interwebs!

## Step 1: Install Python Packages

```
pip install django gunicorn psycopg2-binary dj-database-url
pip freeze > requirements.txt
```

## Step 2: Update `settings.py`

```
import os
import sys
import dj_database_url

SECRET_KEY = os.getenv("DJANGO_SECRET_KEY", 'django-insecure-xyz')

ALLOWED_HOSTS = os.getenv("DJANGO_ALLOWED_HOSTS", "127.0.0.1,localhost").split(",")

ADMIN_URL = os.getenv("ADMIN_URL", "admin/")

SECURE_HSTS_SECONDS = 31536000

if DEBUG is True:
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
            "NAME": os.path.join(BASE_DIR, "db.sqlite3"),
        }
    }
elif len(sys.argv) > 0 and sys.argv[1] != 'collectstatic':
    if os.getenv("DATABASE_URL", None) is None:
        raise Exception("DATABASE_URL environment variable not defined")
    DATABASES = {
        "default": dj_database_url.parse(os.environ.get("DATABASE_URL")),
    }

STATIC_URL = "/static/"
STATIC_ROOT = os.path.join(BASE_DIR, "staticfiles")
```

## Step 3: Deploy on App Platform

Navigate to the [App Platform](https://cloud.digitalocean.com/apps)[^5].

### Create App

1. Create App → Select Repo → Select Branch
2. Check "Autodeploy"

### Resources

#### Web Service

1. Edit Plan → Select "Basic" → Select "$5.00/mo -- Basic" → Back
2. Edit Web Service → Edit Run Command → Save

```
gunicorn --worker-tmp-dir /dev/shm <YOUR_PROJECT_NAME>.wsgi
```

#### Database

1. Add Resource → Database → Add
2. Create and Attach

#### Static Site

1. Add Resource → Detect from Source Code → Add
2. Select Provider → Select Repo/Branch → Check "Autodeploy" → Next
3. Edit new Web Service
4. Rename to `<PROJECT>-static` → Save
5. Update "Resource Type" to "Static Site" → Save
6. Update "Output Directory" to `staticfiles` → Save
7. Update "HTTP Request Routes" to `/static` → Save

### Environment Variables

1. Edit Web Service resource
2. Add the following environment variables:

{{< html >}}
<div style="overflow-x:auto;">
    <table style="margin: 0;">
        <thead>
            <tr>
                <th>Key</th>
                <th>Value</th>
                <th style="text-align:center">Encrypt</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>DATABASE_URL</td>
                <td>${db.DATABASE_URL}</td>
                <td style="text-align:center">N</td>
            </tr>
            <tr>
                <td>DJANGO_ALLOWED_HOSTS</td>
                <td>${APP_DOMAIN}</td>
                <td style="text-align:center">N</td>
            </tr>
            <tr>
                <td>DEBUG</td>
                <td>False</td>
                <td style="text-align:center">N</td>
            </tr>
            <tr>
                <td>ADMIN_URL</td>
                <td>your-secret-admin/</td>
                <td style="text-align:center">N</td>
            </tr>
            <tr>
                <td>DJANGO_SECRET_KEY</td>
                <td>your-secret-key</td>
                <td style="text-align:center">Y</td>
            </tr>
        </tbody>
    </table>
</div>
{{< /html >}}

3. Save

### Info

1. Rename project, if desired → Save

### Review

1. Click "Create Resources"

### Post Deploy

1. Navigate to "Console" tab
2. Run the following commands:

```
python manage.py migrate
python manage.py createsuperuser
```

---

That it, your Django project should now be live! 🚀 Hopefully I laid that out as simply as possible, but feel free to checkout out [DigitalOcean's tutorial](https://docs.digitalocean.com/tutorials/app-deploy-django-app/) if you'd like more detail.

[^1]: I wish it could be simpler, but this is the best I got so far.
[^2]: Basic plans start around $12/mo.
[^3]: I made a few improvements like adding `ADMIN_URL` and `SECURE_HSTS_SECONDS` to achieve a 100% score on [djcheckup.com](https://djcheckup.com/).
[^4]: Assumption: You have a _simple_ Django project.
[^5]: Assumption: You have committed the project to a git repo and have a DigitalOcean account.
