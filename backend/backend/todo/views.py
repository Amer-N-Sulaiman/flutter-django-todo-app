from django.shortcuts import render

from rest_framework.views import APIView
from rest_framework.response import Response

from django.http import HttpResponse
from .serializers import TodoSerializer
from .models import Todo

from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny

from rest_framework.authtoken.models import Token


# Create your views here.

class TodoList(APIView):

    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user = request.user
        todos = Todo.objects.filter(author=user)
        serializer = TodoSerializer(todos, many=True)

        return Response(serializer.data)

    def post(self, request):
        
        serializer = TodoSerializer(data=request.data)
 
        data = {}
        user = request.user
        if serializer.is_valid():
            serializer.author = user
            todo = serializer.save()

            data['title'] = todo.title
            data['body'] = todo.body
            data['important'] = todo.important
            data['author'] = todo.author
        else:
            data = 'there was an error'
        return Response(data)


class OpenTodoList(APIView):
    permission_classes = [AllowAny, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        todos = Todo.objects.all()
        serializer = TodoSerializer(todos, many=True)

        return Response(serializer.data)
