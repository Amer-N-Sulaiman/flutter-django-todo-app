from django.db import models
from django.contrib.auth import get_user_model


# Create your models here.

class Todo(models.Model):
    
    title = models.CharField(max_length=40)
    body = models.TextField(max_length=250)

    important = models.BooleanField(default=False)
    author = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)