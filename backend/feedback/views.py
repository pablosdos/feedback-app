from rest_framework import generics, response, status
from django.db.models.query import QuerySet
from django.core import serializers
from rest_framework.views import APIView
import datetime
from .models import Feedback
from auth_api.models import CustomUser, Roles
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
            User=user_obj.email,
            created_at__year=today.year,
            created_at__month=today.month,
            created_at__day=today.day,
        ).values()
        # print(feedback_queryset)
        if not feedback_queryset:
            Feedback.objects.create(**json_feedback_form_data)
            return JsonResponse({"result": "success"})
        else:
            return JsonResponse(
                {"result": feedback_queryset.update(**json_feedback_form_data)}
            )


def daterange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + datetime.timedelta(n + 1)


class FeedbackListView(generics.ListAPIView):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer

    def list(self, request, *args, **kwargs):
        email_or_group_id: str = self.kwargs["email_or_group"]
        today: datetime.date = datetime.date.today()
        if self.request.GET.get("arithmetic_mean") == "True":
            group_name: str = str(Roles.objects.filter(id=email_or_group_id)[0])
            list_of_this_weeks_group_feedbacks: list = []
            start_date = today - datetime.timedelta(days=7)
            end_date = today
            for single_date in daterange(start_date, end_date):
                group_feedback_of_today: dict = {}
                qs_of_selected_day: QuerySet[Feedback] = Feedback.objects.filter(
                    User__groups=email_or_group_id
                ).filter(created_at__date=single_date)
                motivation_value: int = 0
                muskulaere_erschoepfung_value: int = 0
                koerperliche_einschraenkung_value: int = 0
                schlaf_value: int = 0
                stress_value: int = 0
                for query in qs_of_selected_day:
                    motivation_value = +query.motivation
                group_feedback_of_today["User"] = email_or_group_id
                group_feedback_of_today["group_name"] = group_name
                group_feedback_of_today["motivation"] = motivation_value
                group_feedback_of_today["muskulaere_erschoepfung"] = (
                    muskulaere_erschoepfung_value
                )
                group_feedback_of_today["koerperliche_einschraenkung"] = (
                    koerperliche_einschraenkung_value
                )
                group_feedback_of_today["schlaf"] = schlaf_value
                group_feedback_of_today["stress"] = stress_value
                group_feedback_of_today["created_at"] = single_date
                list_of_this_weeks_group_feedbacks.append(group_feedback_of_today)
            print(list_of_this_weeks_group_feedbacks)
            # return list_of_this_weeks_group_feedbacks
            return response.Response(list_of_this_weeks_group_feedbacks, status=status.HTTP_200_OK)
        queryset = self.get_queryset()
        serializer = FeedbackSerializer(queryset, many=True)
        return response.Response(serializer.data)

    def get_queryset(self):
        email_or_group_id: str = self.kwargs["email_or_group"]
        today: datetime.date = datetime.date.today()
        if self.request.GET.get("only_today") == "True":
            return Feedback.objects.filter(User_id=email_or_group_id).filter(
                created_at__date=today
            )
        return Feedback.objects.filter(User_id=email_or_group_id)
