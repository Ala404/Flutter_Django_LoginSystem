from django.urls import path
from . import views

from knox import views as knox_views
from users.views import LoginView

urlpatterns = [
     path('login/', LoginView.as_view(), name='knox_login'),
     path('logout/', knox_views.LogoutView.as_view(), name='knox_logout'),
     path('register/', views.RegisterAPI.as_view(), name='register'),
     
]
