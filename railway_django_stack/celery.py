import os

from celery import Celery

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "railway_django_stack.settings")

app = Celery("railway_django_stack")

app.config_from_object("django.conf:settings", namespace="CELERY")

# Load task modules from all registered Django apps.
app.autodiscover_tasks()


@app.task(bind=True, ignore_result=True)
def example_task(self):
    print("You've triggered the example task!")
