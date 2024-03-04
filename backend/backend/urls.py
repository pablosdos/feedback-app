from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken import views
from feedback.views import FeedbackCreateView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('auth_api.urls', namespace='auth_api')),
    path('feedback-app-api/feedbacks/', FeedbackCreateView.as_view(), name='feedback-create'),
    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
]

admin.site.site_header = 'Feedback App Administration'