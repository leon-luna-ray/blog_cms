FROM python:3.10-alpine

ENV VERSION=3.10
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONIOENCODING utf8
ENV PYTHONUNBUFFERED 1

RUN apk add --no-cache shadow

RUN apk update && apk add --no-cache \
    build-base \
    postgresql-dev \
    mariadb-connector-c-dev \
    jpeg-dev \
    zlib-dev \
    libwebp-dev \
    libffi-dev

WORKDIR /code/

COPY ./manage.py ./manage.py
COPY ./pyproject.toml ./pyproject.toml
COPY ./README.md ./README.md
COPY ./blog_cms/ ./blog_cms/

RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

EXPOSE 8000

CMD set -xe; \
    python manage.py collectstatic --noinput; \
    python manage.py migrate --noinput; \
    gunicorn blog_cms.wsgi:application --bind 0.0.0.0:8000
