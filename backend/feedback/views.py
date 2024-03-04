from rest_framework import generics
from .models import Feedback
from .serializers import FeedbackSerializer


class FeedbackCreateView(generics.CreateAPIView):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer

    # check/print body of request
    # def post(self, request, *args, **kwargs):
    #     print(request.data)
    #     return self.create(request, *args, **kwargs)
