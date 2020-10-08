from rest_framework import serializers
from rest_auth.serializers import UserDetailsSerializer
from .models import UserProfile
from django.contrib.auth.models import User
from rest_framework.validators import UniqueTogetherValidator
from rest_auth.serializers import TokenSerializer
from django.contrib.auth import get_user_model
from rest_auth.registration.serializers import RegisterSerializer
from allauth.account.adapter import get_adapter
from allauth.account.utils import setup_user_email


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = (
            'id', 'username', 'email', 'first_name', 'last_name', 'date_joined', 'is_active'
        )


class UserProfileTokenSerializer(UserDetailsSerializer):

    profile_id = serializers.IntegerField(source="profile.id")
    profile_slug = serializers.CharField(source="profile.slug")

    class Meta(UserDetailsSerializer.Meta):
        Model = User
        fields = ('id', 'profile_id', 'profile_slug')


class CustomTokenSerializer(TokenSerializer):
    user = UserProfileTokenSerializer(read_only=True)

    class Meta(TokenSerializer.Meta):
        fields = ('key', 'user')


class UserProfileSerializer(serializers.ModelSerializer):
    user__id = serializers.IntegerField(source="user.id")
    user__username = serializers.CharField(source="user.username")
    user__email = serializers.CharField(source="user.email")
    user__password = serializers.CharField(source="user.password")
    user__first_name = serializers.CharField(source="user.first_name")
    user__last_name = serializers.CharField(source="user.last_name")
    user__date_joined = serializers.DateTimeField(source="user.date_joined")
    user__is_staff = serializers.BooleanField(source="user.is_staff")
    user__is_active = serializers.BooleanField(source="user.is_active")
    user__is_superuser = serializers.BooleanField(source="user.is_superuser")
    user__last_login = serializers.DateTimeField(source="user.last_login")
    # Class Methods
    # get_dynamic_name = serializers.CharField(source="user.profile.get_dynamic_name")
    # get_dynamic_name = serializers.CharField(source="user.profile.get_dynamic_name")
    profile_get_dynamic_name = serializers.CharField(source="get_dynamic_name")
    profile_get_contact_number = serializers.CharField(source="get_contact_number")

    class Meta:
        model = UserProfile
        # fields = '__all__'
        fields = [
            'user__id', 'user__username', 'user__email', 'user__password', 'user__first_name', 'user__last_name', 'user__date_joined', 'user__is_staff', 'user__is_active', 'user__is_superuser', 'user__last_login',
            'id', 'slug', 'account_type', 'gender', 'dob', 'blood_group', 'contact_country_code', 'contact_number', 'address', 'city', 'state', 'zip_code', 'country', 'religion', 'marital_status', 'about', 'created_at', 'updated_at',
            'profile_get_dynamic_name', 'profile_get_contact_number'
        ]


class CustomRegisterSerializer(RegisterSerializer):
    account_type = serializers.ChoiceField(
        choices=[
            'Job Seeker', 'Employer'
        ],
    )

    # def get_cleaned_data(self):
    #     data_dict = super().get_cleaned_data()
    #     print(f"accounts : serializers (72) => data_dict => {data_dict}")
    #     data_dict['account_type'] = self.validated_data.get(
    #         'account_type', '')
    #     return data_dict

    # def save(self, request):
    #     self.cleaned_data = self.get_cleaned_data()
    #     print(f"accounts : serializers (79) => self.cleaned_data => {self.cleaned_data}")
    #     adapter = get_adapter()
    #     user = adapter.new_user(request)
    #     adapter.save_user(request, user, self)
    #     setup_user_email(request, user, [])
    #     user.profile.account_type = self.cleaned_data.get('account_type')

    #     user.save()
    #     return user


class FormField(object):
    def __init__(self, **kwargs):
        for field in ('field_value'):
            setattr(self, field, kwargs.get(field, None))

class FormFieldValidationSerializer(serializers.Serializer):
    field_name = serializers.CharField(required=True)
    field_value = serializers.CharField(required=True)
    required_field = serializers.BooleanField(required=False)
    model_name = serializers.CharField(required=False)
    search_type = serializers.CharField(required=False)
