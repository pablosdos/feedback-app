from django.contrib import admin
from auth_api.models import CustomUser, Team, Company, Roles
from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group
from django.db.models import QuerySet
try:
    from rest_framework.authtoken.models import TokenProxy as DRFToken
except ImportError:
    from rest_framework.authtoken.models import Token as DRFToken

User = get_user_model()


class UserAdmin(admin.ModelAdmin):

    list_display = ("fullname", "email", "groups_of_user_with_ordering", "company", "team")

    exclude = [ "first_name", "last_name", "user_permissions"]

    # list_filter = [DecadeBornListFilter, "is_staff" "is_superuser"]
    # ordering = ('role_of_user', 'groups_of_user')

    # the list for the admin user listing
    def get_queryset(self, request):
        # init empty queryset
        summary_queryset: QuerySet = User.objects.none()
        team: str = request.user.team
        company: str = request.user.company
        # if not has team or company, then superuser and return all users
        if not team and not company:
            return super().get_queryset(request)
        # then company admin and return all company coaches
        if not team and company:
            all_users_queryset = User.objects.all()
            summary_queryset = summary_queryset | all_users_queryset.filter(
                company=company
            )
            return summary_queryset
        # for coaches himself and all users of team
        if team:
            all_users_queryset = User.objects.all()
            summary_queryset = summary_queryset | all_users_queryset.filter(
                company=company,
                team=team
            )
            return summary_queryset

    # the role of a row (user)
    def groups_of_user_with_ordering(self, obj):
        groups_list: list = []
        for group in obj.groups.all():
            groups_list.append(group)
        return groups_list

    # def role_of_user(self, obj):
    #     if obj.is_superuser:
    #         return "Superadmin"
    #     if obj.is_staff:
    #         return "Teamleiter"
    #     if obj.groups.all():
    #         return "Gruppen-Klient"
    #     return "Allgemeiner Klient"

    groups_of_user_with_ordering.admin_order_field = "groups"
    groups_of_user_with_ordering.short_description = "Role of user"

class TeamAdmin(admin.ModelAdmin):
    list_display = ["name", "company"]

        # the list for the admin user listing
    def get_queryset(self, request):
        # init empty queryset
        summary_queryset: QuerySet = Team.objects.none()
        team: str = request.user.team
        company: str = request.user.company
        # if not has team or company, then superuser and return all users
        if not team and not company:
            return super().get_queryset(request)
        # then company admin and return all company coaches
        if not team and company:
            all_users_queryset = Team.objects.all()
            summary_queryset = summary_queryset | all_users_queryset.filter(
                company=company
            )
            return summary_queryset

# admin.site.unregister(User)
admin.site.register(User, UserAdmin)


# admin.site.register(CustomUser, UserAdmin)
admin.site.register(Team, TeamAdmin)
admin.site.register(Company)
# admin.site.unregister(Group)
admin.site.unregister(DRFToken)

admin.site.unregister(Group)
admin.site.register(Roles)