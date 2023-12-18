ARG PYTHON_BUILD_VERSION=3.11

FROM python:$PYTHON_BUILD_VERSION-slim AS BASE
WORKDIR /app

ENV PIP_DEFAULT_TIMEOUT=100 \
    # Allow statements and log messages to immediately appear
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    # disable a pip version check to reduce run-time & log-spam
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    # cache is useless in docker image, so disable it to reduce image size
    PIP_NO_CACHE_DIR=1

# Update and install dependencies
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends python3-dev gcc libc-dev vim curl postgresql-client && \
    # Clean up
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Add a non-root user
    groupadd -g 999 python && \
    useradd -r -u 999 -g python python

WORKDIR /app

# Python Dependencies
COPY --chown=python:python ./requirements.txt /app/
RUN pip install --upgrade pip \
    && pip install -r requirements.txt --no-cache-dir --compile

# Clean up
RUN apt-get -y purge gcc libc-dev python3-dev

# Add all application code from this folder, including deployment entrypoints
COPY --chown=python:python ./ /app

# Create staticfiles folder
RUN mkdir -p staticfiles && \
    chown -R python:python staticfiles

# Make entrypoints executable
RUN chmod +x /app/deployment/server-entrypoint.sh && \
    chmod +x /app/deployment/worker-entrypoint.sh

USER 999

EXPOSE 8000
CMD [ "/app/deployment/server-entrypoint.sh" ]
