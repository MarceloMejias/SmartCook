# smartcook/urls.py

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('culinary.urls')),  # Incluye las URLs de la API
]