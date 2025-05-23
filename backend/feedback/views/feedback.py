from rest_framework import generics, response, status
from django.db.models.query import QuerySet
from django.core import serializers
from rest_framework.views import APIView
import datetime
from ..models import Feedback
from auth_api.models import CustomUser, Team, Company
from ..serializers import FeedbackSerializer
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


# API endpoint for feedbacks listing
class FeedbackListView(generics.ListAPIView):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer

    def list(self, request, *args, **kwargs):
        email_or_group_id: str = self.kwargs["email_or_group"]
        today: datetime.date = datetime.date.today()
        if self.request.GET.get("arithmetic_mean") == "True":
            group_name: str = str(Team.objects.filter(id=email_or_group_id)[0])
            list_of_this_weeks_group_feedbacks: list = []
            start_date = today - datetime.timedelta(days=7)
            end_date = today
            for single_date in daterange(start_date, end_date):
                group_feedback_of_today: dict = {}
                qs_of_selected_day: QuerySet[Feedback] = Feedback.objects.filter(
                    User__team=email_or_group_id
                ).filter(created_at__date=single_date)
                motivation_value: int = 0
                muskulaere_erschoepfung_value: int = 0
                koerperliche_einschraenkung_value: int = 0
                schlaf_value: int = 0
                stress_value: int = 0
                member_of_group_count: int = qs_of_selected_day.count()
                for query in qs_of_selected_day:
                    motivation_value += query.motivation
                    muskulaere_erschoepfung_value += query.muskulaere_erschoepfung
                    koerperliche_einschraenkung_value += query.koerperliche_einschraenkung
                    schlaf_value += query.schlaf
                    stress_value += query.stress
                group_feedback_of_today["group_id"] = int(email_or_group_id)
                group_feedback_of_today["group_name"] = group_name
                group_feedback_of_today["motivation"] = round(motivation_value/member_of_group_count)
                group_feedback_of_today["muskulaere_erschoepfung"] = (
                    round(muskulaere_erschoepfung_value/member_of_group_count)
                )
                group_feedback_of_today["koerperliche_einschraenkung"] = (
                    round(koerperliche_einschraenkung_value/member_of_group_count)
                )
                group_feedback_of_today["schlaf"] = round(schlaf_value/member_of_group_count)
                group_feedback_of_today["stress"] = round(stress_value/member_of_group_count)
                group_feedback_of_today["created_at"] = single_date
                list_of_this_weeks_group_feedbacks.append(group_feedback_of_today)
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
    