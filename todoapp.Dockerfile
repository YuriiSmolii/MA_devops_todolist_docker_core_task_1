# --- build stage
ARG VERSION=3.12
FROM python:$VERSION as build

ENV PYTHONUNBUFFERED=1

RUN mkdir /todoapp
WORKDIR /todoapp
COPY . /todoapp/

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# --- run stage
FROM build as run

RUN python manage.py migrate
EXPOSE 8080

CMD python manage.py runserver 0.0.0.0:8080
STOPSIGNAL SIGTERM