from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken import views
from feedback.views import FeedbackCreateView, FeedbackListView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('feedback-app-api/', include('auth_api.urls', namespace='auth_api')),
    path('feedback-app-api/feedbacks/', FeedbackCreateView.as_view(), name='feedback-create'),
    path('feedback-app-api/feedbacks/<str:email>/', FeedbackListView.as_view(), name='feedback-get-by-email'),
    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
]

admin.site.site_header = 'Feedback App Administration'