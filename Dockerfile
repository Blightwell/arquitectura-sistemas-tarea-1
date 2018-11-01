FROM ubuntu
MAINTAINER melgarejo
RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install python
RUN apt-get -y install python-pip
RUN apt-get -y install nano
RUN pip install virtualenv
RUN git clone https://github.com/gnarula/django-ribbit.git
RUN virtualenv --no-site-packages ribbit_env
RUN /bin/bash -c "source /ribbit_env/bin/activate"

RUN pip install "django<1.7"
RUN pip install South

#se agrego a sig. cmd
#RUN /bin/bash -c "cd django-ribbit"
RUN /bin/bash -c "sed -i '114s/$/,/' django-ribbit/ribbit/settings.py"

WORKDIR ./django-ribbit
#funciona con --noinput, pero no se crea ninguna cuenta superuser
RUN python manage.py syncdb --noinput
#RUN python manage.py syncdb

#
#RUN python manage.py

#RUN chmod a+x manage.py
#RUN ./manage.py syncdb --noinput
#RUN echo "from django.contrib.auth.models import User; User.objects.create_superuser('myadmin', 'myemail@example.com', 'hunter2')" | python manage.py shell

#no puedo
RUN python manage.py migrate ribbit_app
#RUN python manage.py runserver

CMD python manage.py runserver 0:$PORT
