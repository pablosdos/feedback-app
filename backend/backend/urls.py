from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('auth_api.urls', namespace='auth_api')),
    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
]

admin.site.site_header = 'Feedback App Administration'