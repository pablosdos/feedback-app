from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken import views
from feedback.views.feedback import FeedbackCreateView, FeedbackListView
from feedback.views.pain import PainCreateView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('feedback-app-api/', include('auth_api.urls', namespace='auth_api')),
    path('feedback-app-api/feedbacks/', FeedbackCreateView.as_view(), name='feedback-create'),
    path('feedback-app-api/pains/', PainCreateView.as_view(), name='pain-create'),
    path('feedback-app-api/feedbacks/<str:email_or_group>/', FeedbackListView.as_view(), name='feedback-get-by-email'),
    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
]

admin.site.site_header = 'CoopMetrics Administration'