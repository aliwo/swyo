FROM python:3.12.6 AS builder

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /swyo

COPY ./poetry.lock ./pyproject.toml ./

RUN set -eux; \
    pip --no-cache-dir install "poetry==1.8.1"; \
    poetry config virtualenvs.create false; \
    poetry install --no-root --no-interaction

FROM python:3.12.6-slim

WORKDIR /swyo

COPY --from=builder /usr/local/lib/python3.12/site-packages/ /usr/local/lib/python3.12/site-packages/

COPY ./app ./app
COPY ./main.py ./

CMD ["python3", "main.py"]
