from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import Group

from .managers import CustomUserManager


class CustomUser(AbstractUser):
    username = None
    email = models.EmailField(_("email address"), unique=True)

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

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
        verbose_name = verbose_name_plural = "Teams"
