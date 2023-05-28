from django.urls import path
from .views import AdminUserRecordView, CategoryListView, ReportListView, CommentListView, UserLoginView, UserRecordView, AdminLoginView

urlpatterns = [
    path('adminuser/', AdminUserRecordView.as_view(), name='adminusers'),
    path('user/', UserRecordView.as_view(), name='users'),
    path('category/', CategoryListView.as_view(), name='categories'),
    path('report/', ReportListView.as_view(), name='reports'),
    path('comment/', CommentListView.as_view(), name='comments'),
    path('userlogin/', UserLoginView.as_view(), name='userlogins'),
    path('adminlogin/', AdminLoginView.as_view(), name='adminlogins'),
    
]