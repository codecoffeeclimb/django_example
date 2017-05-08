import logging
from django.http import HttpResponse

logger = logging.getLogger(__name__)


def index(request):
    logger.info('Here is some info.')
    return HttpResponse('Hello, world! This is a Django example.')


def error(request):
    raise Exception('Boo!')
    return HttpResponse('')