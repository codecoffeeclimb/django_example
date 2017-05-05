FROM ubuntu

RUN apt-get update
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y gunicorn
RUN apt-get install -y nginx
RUN apt-get install -y supervisor

# Setup django
WORKDIR /django_example
ADD . /django_example
RUN pip install -r requirements.txt
RUN python manage.py collectstatic --noinput

# Setup nginx
RUN rm /etc/nginx/sites-enabled/default
COPY production/web/django.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/django.conf /etc/nginx/sites-enabled/django.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Setup supervisord
RUN mkdir -p /var/log/supervisor
COPY production/web/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY production/web/gunicorn.conf /etc/supervisor/conf.d/gunicorn.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]