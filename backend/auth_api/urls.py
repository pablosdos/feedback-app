from django.urls import path
from .views import UserRecordView, UserDetailView

app_name = 'api'
urlpatterns = [
    path('user/', UserRecordView.as_view(), name='users'),
    path('users/<str:email>/', UserDetailView.as_view(), name='feedback-get-by-email'),

]
