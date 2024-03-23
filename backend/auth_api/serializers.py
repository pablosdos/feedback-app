from .models import CustomUser
from feedback.models import Feedback
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator


class UserSerializer(serializers.ModelSerializer):

    feedbacks = serializers.SerializerMethodField('add_feedbacks_of_user')

    def add_feedbacks_of_user(self, user_email):
        return Feedback.objects.filter(User=user_email).values()

    # def create(self, validated_data):
    #     user = CustomUser.objects.create_user(**validated_data)
    #     return user

    class Meta:
        model = CustomUser
        fields = (
            "first_name",
            "last_name",
            "email",
            "password",
            "feedbacks",
        )
        validators = [
            UniqueTogetherValidator(
                queryset=CustomUser.objects.all(), fields=["email"]
            )
        ]
