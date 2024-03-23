from .serializers import UserSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from django.contrib.auth.models import User
from rest_framework import generics
from django.http import HttpResponse
from django.shortcuts import get_object_or_404, render
from .forms import registerUser
from .models import CustomUser


class UserRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """

    permission_classes = [IsAdminUser]

    def get(self, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST,
        )


def createUser(request):
    template_name = "users/register.html"
    form = registerUser(request.POST or None)
    context = {"form": form}

    if form.is_valid():

        email = form.cleaned_data.get("email")
        password = form.cleaned_data.get("password")
        name = form.cleaned_data.get("fullname")

        info = {"email": email, "password": password, "fullname": name}

        CustomUser.objects.create_user(**info)
        context["form"] = registerUser()

    return render(request, template_name, context)


class UserDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer
    lookup_url_kwarg = "email"
    lookup_field = "email"