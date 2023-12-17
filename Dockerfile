FROM python:3.10-alpine

RUN apk add --no-cache shadow

RUN useradd wagtail

EXPOSE 8000

ENV PYTHONUNBUFFERED=1 \
    PORT=8000

RUN apk update && apk add --no-cache \
    build-base \
    postgresql-dev \
    mariadb-connector-c-dev \
    jpeg-dev \
    zlib-dev \
    libwebp-dev

WORKDIR /app/

COPY ./manage.py ./manage.py
COPY ./pyproject.toml ./pyproject.toml
COPY ./README.md ./README.md
COPY ./blog_cms/ ./blog_cms/
COPY ./apps/ ./apps/


RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi


RUN chown wagtail:wagtail /app

COPY --chown=wagtail:wagtail . .

USER wagtail

RUN mkdir /app/staticfiles

CMD set -xe; python manage.py migrate --noinput && python manage.py collectstatic --noinput --clear && gunicorn blog_cms.wsgi:application