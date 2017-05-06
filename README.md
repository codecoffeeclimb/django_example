# Django + Celery + Docker

This is a template project as a starting point to build Django app with Celery async task queue. It provides basic Docker production setup:

- Web Server runs Nginx and Gunicorn to serve Django web app.

- Worker runs celeryd to process asynchronous tasks, celerybeat to trigger periofical tasks and flower monitoring dashboard.


# Usage

Note that his example use Redis as Celery broker, and following example assumes you have a local Redis running and can be accessed from docker (see https://redis.io/topics/security).

Build docker images:
```
docker build -t django_web -f Dockerfile_web .
docker build -t django_worker -f Dockerfile_worker .
```

Run web, worker, and master worker (with celerybeat and flower):
```
docker run -p 80:80 -e "CELERY_BROKER_URL=redis://$(ipconfig getifaddr en0)" django_web
docker run  -p 5555:5555 -e "MASTER_WORKER=true" -e "CELERY_BROKER_URL=redis://$(ipconfig getifaddr en0)" django_worker
docker run  -e "MASTER_WORKER=false" -e "CELERY_BROKER_URL=redis://$(ipconfig getifaddr en0)" django_worker
```

Open http://localhost and http://localhost:5555 to check out! You should see a debug task get run every 30s.