FROM python:3.12-alpine as base

WORKDIR /app

#SHELL ["/bin/sh", "-o", "pipefail", "-c"]

# Install dependencies
RUN apk update && apk add --no-cache \
    git \
    build-base \
    bash \
    curl \
    libffi-dev \
    python3-dev \
    libressl-dev \
    libxml2-dev \
    libxslt-dev \
    python3 \
    py3-pip \
    py3-lxml \
    yaml-dev \
    rust \
    gcc \
    musl-dev \
    cargo


# RUN pip install --upgrade pip setuptools

# Create virtual environment
RUN python3 -m venv /venv

# Activate virtual environment
ENV PATH="/venv/bin:$PATH"

# Install dependencies
RUN pip install asyncua

# clean the cache
RUN rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache \
    && rm -rf /root/.cargo \
    && rm -rf /root/.rustup \
    && rm -rf /tmp/*

COPY *.py ./

CMD ["python3", "app.py"]
