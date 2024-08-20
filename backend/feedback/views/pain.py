from rest_framework import generics, response, status
from django.db.models.query import QuerySet
from django.core import serializers
from rest_framework.views import APIView
import datetime
from ..models import Pain
from auth_api.models import CustomUser, Team, Company
from ..serializers import FeedbackSerializer, PainSerializer
from auth_api.serializers import UserSerializer
from django.http import HttpResponse, JsonResponse


class PainCreateView(APIView):
    queryset = Pain.objects.all()
    serializer_class = PainSerializer

    """
    create new Pain
    if Pain exists 
    from this user 
    and of today
    otherwise overwrite
    existing Pain
    """

    def post(self, request, *args, **kwargs):
        json_Pain_form_data = request.data
        # print(json_Pain_form_data)
        # replace email address with User object and create object; THIS IS POSSIBLE
        user_obj = CustomUser.objects.get(email=json_Pain_form_data.get("User"))
        json_Pain_form_data["User"] = user_obj
        # check if Pain exists from this user and of today
        today = datetime.date.today()
        Pain_queryset = Pain.objects.filter(
            User=user_obj.email,
            created_at__year=today.year,
            created_at__month=today.month,
            created_at__day=today.day,
        ).values()
        # print(Pain_queryset)
        if not Pain_queryset:
            Pain.objects.create(**json_Pain_form_data)
            return JsonResponse({"result": "success"})
        else:
            return JsonResponse(
                {"result": Pain_queryset.update(**json_Pain_form_data)}
            )
