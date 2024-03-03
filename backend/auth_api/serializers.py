from .models import CustomUser
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = CustomUser.objects.create_user(**validated_data)
        return user

    class Meta:
        model = CustomUser
        fields = (
            "first_name",
            "last_name",
            "email",
            "password",
        )
        validators = [
            UniqueTogetherValidator(
                queryset=CustomUser.objects.all(), fields=["email"]
            )
        ]
