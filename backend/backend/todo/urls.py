from django.urls import path

from . import views

app_name = 'todo'

urlpatterns = [
    path('list/', views.TodoList.as_view(), name='list'),
    path('openlist/', views.OpenTodoList.as_view(), name='openList')
]
