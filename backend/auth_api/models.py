from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import Group

from .managers import CustomUserManager


class Company(models.Model):
    name = models.CharField(max_length=127, blank=False, null=False)

    def __str__(self):
        return self.name


class Team(models.Model):
    name = models.CharField(max_length=127, blank=False, null=False)
    company = models.ForeignKey(Company, on_delete=models.CASCADE)

    def __str__(self):
        return self.name


class CustomUser(AbstractUser):
    username = None
    email = models.EmailField(_("email address"), unique=True)

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    objects = CustomUserManager()
    team = models.ForeignKey(Team, on_delete=models.CASCADE, blank=True, null=True)
    company = models.ForeignKey(Company, on_delete=models.CASCADE, blank=True, null=True)
    fullname = models.CharField(blank=False, null=False, max_length=150)

    def save(self, *args, **kwargs):
        user = super(CustomUser, self)
        user.set_password(self.password)
        super().save(*args, **kwargs)
        return user

    def __str__(self):
        return self.email

class Roles(Group):
    class Meta:
        proxy = True
        verbose_name = verbose_name_plural = "Roles"