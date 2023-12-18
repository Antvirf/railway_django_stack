"""
URL configuration for railway_django_stack project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

import railway_django_stack.example_views as example_views

urlpatterns = [
    path("", example_views.index, name="index"),
    path("healthcheck/", example_views.health_check, name="health_check"),
    path("test-task/", example_views.test_task, name="test_task"),
    path("admin/", admin.site.urls),
]
