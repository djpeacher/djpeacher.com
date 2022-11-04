---
title: 'DjangoCon US 2022: Day 2'
date: '2022-10-18'
description: 'My notes from #djangocon 🦀 day 2.'
---

## [Keeping track of architectural-ish decisions in a sustainable way](https://2022.djangocon.us/talks/keeping-track-of-architectural-ish-in-a/)

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

## [Django Migrations: Pitfalls and Solutions](https://2022.djangocon.us/talks/django-migrations-pitfalls-and-solutions/)

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

## [Django Through the Years](https://2022.djangocon.us/talks/django-through-the-years/)

Not much to say about this, other than it was a very fun history lesson! ❤️

## [Just enough ops for developers](https://2022.djangocon.us/talks/just-enough-ops-for-developers/)

My main takeaway here was the following [fastapi analogy](https://fastapi.tiangolo.com/async/):

- CPU = Cook
- Process = Cashier
- Request = Customer

## [Your First Deployment Shouldn't Be So Hard!](https://2022.djangocon.us/talks/your-first-deployment-shouldn-t-be-so/)

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
