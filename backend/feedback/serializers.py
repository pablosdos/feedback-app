from .models import Feedback
from rest_framework import serializers


class FeedbackSerializer(serializers.ModelSerializer):
    group_of_user = serializers.SerializerMethodField()

    class Meta:
        model = Feedback
        fields = (
            "User",
            "group_of_user",
            "motivation",
            "muskulaere_erschoepfung",
            "koerperliche_einschraenkung",
            "schlaf",
            "stress",
            "created_at",
        )

    def get_group_of_user(self, obj):
        if obj.User.groups.all():
            return str(obj.User.groups.all()[0])
        else:
            return ''