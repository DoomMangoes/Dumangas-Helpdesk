from django.urls import path
from .views import UserRecordView, CategoryListView, ReportListView, CommentListView

urlpatterns = [
    path('user/', UserRecordView.as_view(), name='users'),
    path('category/', CategoryListView.as_view(), name='categories'),
    path('report/', ReportListView.as_view(), name='reports'),
    path('comment/', CommentListView.as_view(), name='comments'),
]