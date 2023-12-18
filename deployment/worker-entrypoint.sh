#!/bin/sh
celery -A railway_django_stack worker --beat -l INFO