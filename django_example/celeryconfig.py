import os


broker_url = os.environ.get('CELERY_BROKER_URL', 'redis://127.0.0.1:6379')
result_backend = broker_url

task_serializer = 'json'
result_serializer = 'json'
accept_content = ['json']
enable_utc = True


beat_schedule = {
    'debug-every-30-seconds': {
        'task': 'django_example.celery.debug_task',
        'schedule': 30.0,
    },
}