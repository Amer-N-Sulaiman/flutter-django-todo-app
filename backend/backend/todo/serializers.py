from rest_framework import serializers
from .models import Todo
class TodoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Todo

        fields = (
            'id',
            'title',
            'body',
            'important',
            'author'
        )

    def save(self):
        todo = Todo(
            title = self.validated_data['title'],
            body = self.validated_data['body'],
            important = self.validated_data['important'],
            author = self.author
        )

        todo.save()

        return todo