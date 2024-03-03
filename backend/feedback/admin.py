from django.contrib import admin
from .models import Feedback

class FeedbackAdmin(admin.ModelAdmin):
    list_display = [field.name for field in Feedback._meta.get_fields()]


admin.site.register(Feedback, FeedbackAdmin)
