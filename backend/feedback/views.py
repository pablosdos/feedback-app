from rest_framework import generics
from django.core import serializers
from rest_framework.views import APIView
import datetime
from .models import Feedback
from auth_api.models import CustomUser
from .serializers import FeedbackSerializer
from auth_api.serializers import UserSerializer
from django.http import HttpResponse, JsonResponse

# GENERICS ALTERNATIVE
# class FeedbackCreateView(generics.CreateAPIView):
#     queryset = Feedback.objects.all()
#     serializer_class = FeedbackSerializer

#     # check/print body of request
#     def post(self, request, *args, **kwargs):
#         print(request.data)
#         return self.create(request, *args, **kwargs)


class FeedbackCreateView(APIView):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer

    """
    create new feedback
    if feedback exists 
    from this user 
    and of today
    otherwise overwrite
    existing feedback
    """

    def post(self, request, *args, **kwargs):
        json_feedback_form_data = request.data
        # print(json_feedback_form_data)
        # replace email address with User object and create object; THIS IS POSSIBLE
        user_obj = CustomUser.objects.get(email=json_feedback_form_data.get("User"))
        json_feedback_form_data["User"] = user_obj
        # check if feedback exists from this user and of today
        today = datetime.date.today()
        feedback_queryset = Feedback.objects.filter(
            User=user_obj.email, created_at__year=today.year,created_at__month=today.month, created_at__day=today.day
        ).values()
        # print(feedback_queryset)
        if not feedback_queryset:
            Feedback.objects.create(**json_feedback_form_data)
            return JsonResponse({"result": "success"})
        else:
            return JsonResponse({"result":feedback_queryset.update(**json_feedback_form_data)})


class FeedbackDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
