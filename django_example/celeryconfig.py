broker_url = 'redis://localhost:6379'
result_backend = 'redis://localhost:6379'

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