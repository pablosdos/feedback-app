from django.contrib import admin
from django.db.models import QuerySet
from django.contrib.auth import get_user_model
from django.utils.translation import gettext_lazy as _

from .models import Feedback, Pain

User = get_user_model()


# CUSTOM USER FILTER (ONLY USERS FROM GROUP OF TEAMLEAD)
class TeamUserFilter(admin.SimpleListFilter):
    title = "User"  # or use _('country') for translated title
    parameter_name = "User"

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
        "company",
        "team",
    ]
    # list_filter = [TeamUserFilter]

    def get_queryset(self, request):
        # init empty queryset
        summary_queryset: QuerySet = Feedback.objects.none()
        team: str = request.user.team
        company: str = request.user.company
        # if not has team or company, then superuser and return all users
        if not team and not company:
            return super().get_queryset(request)
        # then company admin and return all company coaches
        if not team and company:
            all_users_queryset = Feedback.objects.all()
            summary_queryset = summary_queryset | all_users_queryset.filter(
                company=company
            )
            return summary_queryset
        # for coaches himself and all users of team
        if team:
            all_users_queryset = Feedback.objects.all()
            summary_queryset = summary_queryset | all_users_queryset.filter(
                company=company, team=team
            )
            return summary_queryset
        # groups_of_user = request.user.groups.all()
        # if not groups_of_user:
        #     return super().get_queryset(request)
        # all_users_queryset = Feedback.objects.all()
        # summary_queryset = Feedback.objects.none()
        # for group in groups_of_user:
        #     summary_queryset = summary_queryset | all_users_queryset.filter(
        #         User__groups=group
        #     )
        # return summary_queryset

    @admin.display(ordering="User__fullname", description="User")
    def get_fullname(self, obj):
        return obj.User.fullname

    def groups_of_user_with_ordering(self, obj):
        groups_list: list = []
        for group in obj.User.groups.all():
            groups_list.append(group)
        return groups_list

    def created_at_renamed(self, obj):
        return obj.created_at

    groups_of_user_with_ordering.admin_order_field = "User__groups"
    created_at_renamed.admin_order_field = "created_at"
    created_at_renamed.short_description = "Feedback abgegeben am"


class PainAdmin(admin.ModelAdmin):
    readonly_fields = ["created_at"]
    list_display = [
        "User",
        "created_at",
    ]


admin.site.register(Feedback, FeedbackAdmin)
admin.site.register(Pain, PainAdmin)
