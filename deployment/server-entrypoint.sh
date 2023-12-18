#!/bin/sh

echo "Collecting static files.."
python manage.py collectstatic --noinput

if [ "$RUN_MIGRATIONS" = "True" ]; then
    echo "Running migrations..."
    until python manage.py migrate
    do
        echo "Waiting for db to be ready..."
        sleep 2
    done
fi

echo "Starting app server..."
python -m gunicorn railway_django_stack.wsgi:application \
    --bind 0.0.0.0:8000 \
    --log-level info \
    --config python:deployment.gunicorn_config \
    --forwarded-allow-ips "*"
