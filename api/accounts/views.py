from django.shortcuts import get_object_or_404, render
from rest_framework import viewsets
from rest_framework.generics import (
    ListCreateAPIView, RetrieveUpdateDestroyAPIView,
)
from .models import UserProfile
from django.contrib.auth.models import User
from .serializers import (
    UserSerializer, UserProfileSerializer, FormFieldValidationSerializer
)
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.http import Http404
from rest_framework.permissions import (
    AllowAny, IsAdminUser, IsAuthenticated, Http404, IsAuthenticatedOrReadOnly
)
from rest_framework.authentication import (
    TokenAuthentication, SessionAuthentication, BasicAuthentication, BaseAuthentication, CsrfViewMiddleware, CSRFCheck, RemoteUserAuthentication
)
from .permissions import (IsOwnerProfileOrReadOnly)
from rest_framework.exceptions import ParseError
import re


class FormFieldValidityView(APIView):
    authentication_classes = [BasicAuthentication, ]
    permission_classes = (AllowAny,)
    # serializer_class = FormFieldValidationSerializer

    def post(self, request, *args, **kwargs):
        # initial blueprint
        MODEL = User
        result = Response(
            data={'message': '', 'status': True})
        serializerform = FormFieldValidationSerializer(data=request.data)
        if not serializerform.is_valid():
            raise ParseError(detail="No valid values")
        # Get request data values
        field_name = request.data['field_name']
        field_value = request.data['field_value']
        required_field = False if request.data['required_field'] == 'false' else True
        if request.data['model_name'] == 'User':
            MODEL = User
        search_type = request.data['search_type'] if request.data['search_type'] != None else "iexact"
        # print(f"accounts : views (47) => field_value => {field_value}")
        if not field_name == None:
            if required_field == True and field_value == '':
                result = Response(
                    data={'message': f'{field_name} is required', 'status': False})
        if not field_value == None and not field_name == None:
            if field_name == 'username' or field_name == 'email':
                filter = field_name + '__' + search_type
                # print(
                #     f"accounts : views (61) => filter => {filter}: {field_value}")
                qs = MODEL.objects.filter(**{filter: field_value})
                if qs.exists():
                    result = Response(
                        data={'message': "Already taken", 'status': False})
                    return result
            if field_name == 'email':
                regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$'
                if(re.search(regex, field_value)):
                    result = Response(
                        data={'message': "", 'status': True})
                    return result
                else:
                    result = Response(
                        data={'message': "Please provide a valid email address", 'status': False})
                    return result
            if field_name == 'username':
                if (len(field_value) > 10):
                    result = Response(
                        data={'message': f"Maximum 10 characters allowed ! Currently using ({len(field_value)})", 'status': False})
                    return result
                allowed_chars = re.match(r'^[_A-z0-9. ]+$', field_value)
                if not allowed_chars:
                    result = Response(
                        data={'message': f"Only '_A-z0-9.' these characters and spaces are allowed.", 'status': False})
                    return result
            if field_name == 'password1':
                password_regex = re.compile(
                    "^(?=.*[a-z])(?=.*\d)[A-Za-z\d@$!#%*?&]{8,100}$")
                password_match = re.search(password_regex, field_value)
                if not password_match:
                    result = Response(
                        data={'message': "Password must be alpha-numeric and at least 8 characters", 'status': False})
                    return result
        return result


class UserList(APIView):
    """
    List all users, or create a new snippet.
    """
    # authentication_classes = [SessionAuthentication, BasicAuthentication]
    authentication_classes = [TokenAuthentication,]
    permission_classes = (AllowAny,)
    # permission_classes = (IsAuthenticated,)

    def get(self, request, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserProfileViewSet(RetrieveUpdateDestroyAPIView):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer
    # permission_classes = [IsOwnerProfileOrReadOnly, IsAuthenticated,]
    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsOwnerProfileOrReadOnly, ]
    # permission_classes = (AllowAny,)

    def get_object(self):
        slug = self.kwargs['slug']
        # slug = self.request.user.profile.slug
        obj = get_object_or_404(UserProfile, slug=slug)
        return obj



