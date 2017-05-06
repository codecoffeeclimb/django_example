# Django + Celery + Docker

This is a template project to build Django app with Celery async task queue. It provides basic Docker production setup to run

- Web server runs Nginx and Gunicorn to serve Django web app.

- Worker runs celeryd to process asynchronous tasks, celerybeat to trigger periofical tasks and flower monitoring dashboard.


# Usage

Note that this example use Redis as Celery broker, and following example assumes you have a local Redis running and can be accessed from docker (see https://redis.io/topics/security).

Build docker images:
```
docker build -t django  .
```

Run web server, worker, and master worker (with celerybeat and flower) in one docker image:
```
docker run -p 80:80 -p 5555:5555 \
  -e "CELERY_BROKER_URL=redis://$(ipconfig getifaddr en0)" \
  -e "WEB_SERVER=true" \
  -e "WORKER=true" \
  -e "MASTER_WORKER=true" django
```

Open http://localhost and http://localhost:5555 to check out, you should see some debug tasks running every 30s. In production, you may want to run web server and worker separtely.
