from django.db import models
from django.conf import settings

ESTIMATION = {
    0: 0,
    2: 1,
    3: 2,
    6: 3,
    8: 4,
    10: 5
}

class Feedback(models.Model):
    User = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, to_field="email"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    motivation = models.IntegerField(choices=ESTIMATION)
    muskulaere_erschoepfung = models.IntegerField(choices=ESTIMATION)
    koerperliche_einschraenkung = models.IntegerField(choices=ESTIMATION)
    schlaf = models.IntegerField(choices=ESTIMATION)
    stress = models.IntegerField(choices=ESTIMATION)
    def __str__(self):
        return self.User.email