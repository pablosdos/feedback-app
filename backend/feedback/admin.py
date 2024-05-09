from django.contrib import admin
from .models import Feedback
from auth_api.models import Roles
from django.contrib.auth.models import Group

try:
    from rest_framework.authtoken.models import TokenProxy as DRFToken
except ImportError:
    from rest_framework.authtoken.models import Token as DRFToken
from django.contrib.auth import get_user_model
from django.utils.translation import gettext_lazy as _

User = get_user_model()

# CUSTOM USER FILTER (ONLY USERS FROM GROUP OF TEAMLEAD)
class TeamUserFilter(admin.SimpleListFilter):
    title = 'User' # or use _('country') for translated title
    parameter_name = 'User'

    def lookups(self, request, model_admin):
        groups_of_user = request.user.groups.all()
        if not groups_of_user:
            users = set([c for c in User.objects.all()])
            return [(c.email, c.email) for c in users]
        all_users = User.objects.all()
        limited_users_list = User.objects.none()
        for selected_user in all_users:
            if selected_user.groups.all():
                selected_user_in_queryset = User.objects.filter(email=selected_user)
                limited_users_list |= selected_user_in_queryset
                # print(selected_user)
        return [(c.email, c.fullname) for c in limited_users_list]

    def queryset(self, request, queryset):
        feedback_queryset = Feedback.objects.all().filter(User__email=self.value())
        if self.value():
            return queryset.filter(User__email=self.value())

class FeedbackAdmin(admin.ModelAdmin):
    readonly_fields = ["created_at"]
    # list_display = [field.name for field in Feedback._meta.get_fields()]
    list_display = [
        "get_fullname",
        "created_at_renamed",
        "groups_of_user_with_ordering",
    ]
    list_filter = [TeamUserFilter]

    def get_queryset(self, request):
        groups_of_user = request.user.groups.all()
        if not groups_of_user:
            return super().get_queryset(request)
        all_users_queryset = Feedback.objects.all()
        summary_queryset = Feedback.objects.none()
        for group in groups_of_user:
            summary_queryset = summary_queryset | all_users_queryset.filter(User__groups=group)
        return summary_queryset

    @admin.display(ordering='User__fullname', description='User')
    def get_fullname(self, obj):
        return obj.User.fullname
    
    def groups_of_user_with_ordering(self, obj):
        groups_list: list = []
        for group in obj.User.groups.all():
            groups_list.append(group)
        return groups_list
    
    def created_at_renamed(self, obj):
        return obj.created_at

    groups_of_user_with_ordering.admin_order_field = 'User__groups'
    created_at_renamed.admin_order_field = 'created_at'
    created_at_renamed.short_description = 'Feedback abgegeben am'

class UserAdmin(admin.ModelAdmin):

    list_display = ("fullname", "email", "role_of_user", "groups_of_user_with_ordering")
    # list_filter = [DecadeBornListFilter, "is_staff" "is_superuser"]
    # ordering = ('role_of_user', 'groups_of_user')
    def get_queryset(self, request):
        groups_of_user = request.user.groups.all()
        if not groups_of_user:
            return super().get_queryset(request)
        all_users_queryset = User.objects.all()
        summary_queryset = User.objects.none()
        for group in groups_of_user:
            summary_queryset = summary_queryset | all_users_queryset.filter(groups=group)
        return summary_queryset

    def groups_of_user_with_ordering(self, obj):
        groups_list: list = []
        for group in obj.groups.all():
            groups_list.append(group)
        return groups_list
    
    def role_of_user(self, obj):
        if obj.is_superuser:
            return 'Superadmin'
        if obj.is_staff:
            return 'Teamleiter'
        if obj.groups.all():
            return 'Gruppen-Klient'
        return 'Allgemeiner Klient'

    groups_of_user_with_ordering.admin_order_field = 'groups'
    groups_of_user_with_ordering.short_description = 'Team des Users'

admin.site.unregister(User)
admin.site.register(User, UserAdmin)
admin.site.unregister(DRFToken)
admin.site.register(Feedback, FeedbackAdmin)
admin.site.unregister(Group)
admin.site.register(Roles)
