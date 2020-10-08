from django.urls import path, include
from rest_framework import routers
from .views import (
    UserList, UserProfileViewSet, FormFieldValidityView
)
from rest_framework.urlpatterns import format_suffix_patterns
from rest_framework.authtoken import views
from rest_framework.authtoken.views import (ObtainAuthToken, obtain_auth_token)

router = routers.DefaultRouter(trailing_slash=False)

# register router
# router.register('core-users', UserList)


urlpatterns = [
    path('', include('allauth.urls')),
    path('rest-auth/', include('rest_auth.urls')),
    path('rest-auth/registration/', include('rest_auth.registration.urls')),
    path('api-form-field-validity/',
         FormFieldValidityView.as_view(), name='field_field_validity'),
    # path('core/', include('rest_framework.urls', namespace='rest_framework')),
    path('api-token/', obtain_auth_token, name='obtain-token'),
    path('api-users/', UserList.as_view()),
    path(
        'api-user/profile/<slug>/', UserProfileViewSet.as_view(), name="user_profile"
    ),
]


urlpatterns = format_suffix_patterns(urlpatterns)
