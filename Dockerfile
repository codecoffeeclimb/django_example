# Docker build file for Django + Celery app. The following environment variables
# need to be set to decide the purpose of the image:
#
# 1) WEB_SERVER (true|false): if run web server.
# 2) MASTER_WORKER (true|false): if run celerybeat and flower.
# 3) WORKER (true|false): if run celeryd.
#
# For example, the follwoing command will run everything in one docker image:
#
# docker run -p 80:80 -p 5555:5555 \
#   -e "CELERY_BROKER_URL=redis://$(ipconfig getifaddr en0)" \
#   -e "WEB_SERVER=true" \
#   -e "WORKER=true" \
#   -e "MASTER_WORKER=true" django

FROM ubuntu

RUN apt-get update
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y gunicorn
RUN apt-get install -y nginx
RUN apt-get install -y supervisor

# Setup django
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
RUN python manage.py collectstatic --noinput

# Setup nginx
RUN rm /etc/nginx/sites-enabled/default
COPY production/nginx/django.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/django.conf /etc/nginx/sites-enabled/django.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Setup supervisord
RUN mkdir -p /var/log/supervisor
COPY production/supervisor/*.conf /etc/supervisor/conf.d/

EXPOSE 80 5555

CMD ["/usr/bin/supervisord"]