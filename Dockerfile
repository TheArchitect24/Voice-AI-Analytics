FROM python:3.11-slim

WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    postgresql-client \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
