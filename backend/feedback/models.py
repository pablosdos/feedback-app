from django.db import models
from django.conf import settings

ESTIMATION = {
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
    motivation = models.IntegerField(choices=ESTIMATION)
    muskulaere_erschoepfung = models.IntegerField(choices=ESTIMATION)
    koerperliche_einschraenkung = models.IntegerField(choices=ESTIMATION)
    schlaf = models.IntegerField(choices=ESTIMATION)
    stress = models.IntegerField(choices=ESTIMATION)
    def __str__(self):
        return self.name


