from django.shortcuts import render

from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView

from .serializers import RegisterationSerializer, UserSerializer

from .models import Account

from rest_framework.authtoken.models import Token

from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.authentication import TokenAuthentication

from django.http import HttpResponse

from django.contrib.auth.hashers import make_password

from django.contrib.auth import get_user_model

# Create your views here.

class RegisetrationView(APIView):

    authentication_classes = [TokenAuthentication, ]
    permission_classes = [AllowAny, ]

    def post(self, request):
        serialized = RegisterationSerializer(data=request.data)
        data = {}
        if serialized.is_valid(): 
            account = serialized.save()

            data['response'] = 'success'
            data['email'] = account.email
            data['username'] = account.username
            token = Token.objects.get(user=account).key

            data['token'] = token
        else:
            data = serialized.errors

        return Response(data)
    '''
    def get(self, request):
        accounts = Account.objects.all()
        serialized = UserSerializer(accounts, many=True)

        return Response(serialized.data)
    '''

class CurrentUserInfo(APIView):

    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsAuthenticated, ]

    def get(self, request):
        user = request.user
        serializer = UserSerializer(user)
        data = serializer.data
        return Response(data)

    def put(self, request):
        user = request.user
        modified_user = request.data
        serializer = UserSerializer(user, data=modified_user)
        data = {}
        if serializer.is_valid():
            serializer.is_active = True
            password = make_password(request.data['password'])
            account = serializer.save(password=password, is_active=True)

            data['username'] = account.username
            data['email'] = account.email            
            return Response(data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class UserInfo(APIView):
    permission_classes = [AllowAny, ]
    authentication_classes = [TokenAuthentication]

    def get(self, request, *args, **kwargs):
        id = kwargs.get('id', 'Default Value If Not Found')
        User = get_user_model()

        user = User.objects.get(id=id)
        serializer = UserSerializer(user)
        data = serializer.data
        del  data['password']
        return Response(data)