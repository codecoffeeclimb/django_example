# Django + Celery + Docker

This is a template project as a starting point to build Django app with Celery async task queue. It provides basic Docker production setup:

- Web Server
Runs Nginx and Gunicorn to serve Django web app.

- Worker
Runs Celery worker to process asynchronous tasks.

- Master Worker
Runs Celerybeat triggering periodic tasks and Flower monitoring dashboard.

