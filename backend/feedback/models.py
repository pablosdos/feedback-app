from django.db import models
from django.conf import settings

from auth_api.models import Company, Team

ESTIMATION = {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5
}

class Feedback(models.Model):
    User = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, to_field="email"
    )
    company = models.ForeignKey(Company, on_delete=models.CASCADE, blank=True, null=True)
    team = models.ForeignKey(Team, on_delete=models.CASCADE, blank=True, null=True)
    # default created_at field
    created_at = models.DateTimeField(auto_now_add=True)
    # created_at field for adding mock data feedbacks to database
    # created_at = models.DateTimeField(auto_now=False, auto_now_add=False,blank=True, null=True)
    motivation = models.IntegerField(choices=ESTIMATION)
    muskulaere_erschoepfung = models.IntegerField(choices=ESTIMATION)
    koerperliche_einschraenkung = models.IntegerField(choices=ESTIMATION)
    schlaf = models.IntegerField(choices=ESTIMATION)
    stress = models.IntegerField(choices=ESTIMATION)
    def __str__(self):
        return self.User.email
        
class Pain(models.Model):
    User = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, to_field="email"
    )
    company = models.ForeignKey(Company, on_delete=models.CASCADE, blank=True, null=True)
    team = models.ForeignKey(Team, on_delete=models.CASCADE, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    # created_at = models.DateTimeField(auto_now=False, auto_now_add=False,blank=True, null=True)
    head = models.BooleanField(blank=False, null=False)
    neck = models.BooleanField(blank=False, null=False)
    leftShoulder = models.BooleanField(blank=False, null=False)
    leftUpperArm = models.BooleanField(blank=False, null=False)
    leftElbow = models.BooleanField(blank=False, null=False)
    leftLowerArm = models.BooleanField(blank=False, null=False)
    leftHand = models.BooleanField(blank=False, null=False)
    rightShoulder = models.BooleanField(blank=False, null=False)
    rightUpperArm = models.BooleanField(blank=False, null=False)
    rightElbow = models.BooleanField(blank=False, null=False)
    rightLowerArm = models.BooleanField(blank=False, null=False)
    rightHand = models.BooleanField(blank=False, null=False)
    upperBody = models.BooleanField(blank=False, null=False)
    lowerBody = models.BooleanField(blank=False, null=False)
    leftUpperLeg = models.BooleanField(blank=False, null=False)
    leftKnee = models.BooleanField(blank=False, null=False)
    leftLowerLeg = models.BooleanField(blank=False, null=False)
    leftFoot = models.BooleanField(blank=False, null=False)
    rightUpperLeg = models.BooleanField(blank=False, null=False)
    rightKnee = models.BooleanField(blank=False, null=False)
    rightLowerLeg = models.BooleanField(blank=False, null=False)
    rightFoot = models.BooleanField(blank=False, null=False)
    abdomen = models.BooleanField(blank=False, null=False)
    vestibular = models.BooleanField(blank=False, null=False)
    def __str__(self):
        return self.User.email