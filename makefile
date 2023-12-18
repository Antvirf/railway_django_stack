.PHONY: venv-create install

## ENV SETUP
venv-create:
	python -m venv venv

install:
	pip install -r requirements.txt

install-dev:
	pip install -r requirements-dev.txt

## DEVELOPMENT helpers
lint: 
	black .
	ruff check --fix . --ignore E501
	djlint . --reformat
	isort . --profile black

celery:
	celery -A railway_django_stack worker --beat -l INFO

redis:
	docker run -p 6379:6379 redis

