from rest_framework import serializers
from .models import Todo
class TodoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Todo

        fields = (
            'title',
            'body',
            'author'
        )

    def save(self):
        todo = Todo(
            title = self.validated_data['title'],
            body = self.validated_data['body'],
            author = self.author
        )

        todo.save()

        return todo