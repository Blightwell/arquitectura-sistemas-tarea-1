FROM ubuntu
MAINTAINER melgarejo

RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install python
RUN apt-get -y install python-pip
RUN pip install virtualenv
#RUN git clone https://github.com/gnarula/django-ribbit.git
RUN git clone https://github.com/Blightwell/arqsis_tarea_1.git
RUN virtualenv --no-site-packages ribbit_env
RUN /bin/bash -c "source /ribbit_env/bin/activate"

#RUN pip install django==1.6.11
#RUN pip install South
#->
#RUN pip install -r requirements.txt

#Agrega ',' a TEMPLATE_DIR -- YA NO ES NECESARIO DEBIDO A QUE ESTA BIEN EN EL REPO.
#RUN /bin/bash -c "sed -i '114s/$/,/' django-ribbit/ribbit/settings.py"
#RUN /bin/bash -c "sed -i '114s/$/,/' arqsis_tarea_1/ribbit/settings.py"
#WORKDIR ./django-ribbit

WORKDIR ./arqsis_tarea_1

#RUN ls
#Por alguna razon, no se actualiza requirements.txt un error que tenia antes, y no puedo limpiar la cache manualmente, deberia ser con requierements.txt como entregable final
RUN pip install -r requirements.txt
#RUN pip install django==1.6.11
#RUN pip install South

RUN python manage.py syncdb --noinput
RUN python manage.py migrate ribbit_app

#RUN python manage.py runserver
#->
CMD python manage.py runserver 0:$PORT
