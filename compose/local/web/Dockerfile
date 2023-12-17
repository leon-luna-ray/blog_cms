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

COPY ./pyproject.toml ./pyproject.toml
RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

COPY ./compose/local/web/entrypoint /entrypoint 
RUN sed -i 's/\r$//g' /entrypoint
RUN chmod +x /entrypoint

COPY ./compose/local/web/start /start
RUN sed -i 's/\r$//g' /start
RUN chmod +x /start

WORKDIR /app

ENTRYPOINT ["/entrypoint"]