from django.urls import path
from . import views

from rest_framework.authtoken.views import obtain_auth_token

app_name = 'account'

urlpatterns = [
    path('registeration/', views.RegisetrationView.as_view(), name='registration'),
    path('login/', obtain_auth_token, name='login'),
    path('currentUserinfo/', views.CurrentUserInfo.as_view(), name='currentUserInfo'),
    path('userInfo/<int:id>/', views.UserInfo.as_view(), name='currentUserInfo')
]
