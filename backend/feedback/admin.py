from django.contrib import admin
from .models import Feedback


class FeedbackAdmin(admin.ModelAdmin):
    readonly_fields=['created_at']
    # list_display = [field.name for field in Feedback._meta.get_fields()]
    list_display = [
        "User",
        "created_at",
    ]


admin.site.register(Feedback, FeedbackAdmin)
