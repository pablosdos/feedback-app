from .models import Feedback
from rest_framework import serializers


class FeedbackSerializer(serializers.ModelSerializer):

    class Meta:
        model = Feedback
        fields = (
            "User",
            "motivation",
            "muskulaere_erschoepfung",
            "koerperliche_einschraenkung",
            "schlaf",
            "stress",
            "created_at",
        )
