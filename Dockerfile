# Stage 1: Frontend Builder
FROM node:18-bullseye as frontend-builder
WORKDIR /app
COPY . .
WORKDIR /app/frontend
RUN yarn install && yarn build

# Stage 2: Main Image
FROM python:3.10-slim-buster
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update --yes --quiet && apt-get install --yes --quiet --no-install-recommends \
    build-essential \
    libpq-dev \
    libmariadbclient-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libwebp-dev \
 && rm -rf /var/lib/apt/lists/*

RUN addgroup --system django \
    && adduser --system --ingroup django django

COPY ./pyproject.toml ./pyproject.toml
RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

COPY ./compose/production/web/entrypoint /entrypoint
RUN sed -i 's/\r$//g' /entrypoint
RUN chmod +x /entrypoint
RUN chown django /entrypoint

WORKDIR /app

RUN mkdir /app/static
RUN mkdir /app/media

COPY . .
COPY --from=frontend-builder /app/frontend/build /app/frontend/build

RUN chown -R django:django /app
USER django

ENTRYPOINT ["/entrypoint"]
