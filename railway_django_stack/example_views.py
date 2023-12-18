from django.http import HttpResponse

from .celery import example_task


def index(request):
    return HttpResponse("Hello world! Your Django app is running.")


def health_check(request):
    return HttpResponse("OK")


def test_task(request):
    example_task.delay()
    return HttpResponse("Task triggered, see Celery logs")
