from django.shortcuts import render

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser

from django.contrib.auth.models import User
from helpdeskapp.models import Category, Report, Comment, RegularUser

from .serializers import AdminUserSerializer, CategorySerializer, ReportSerializer, CommentSerializer, UserLoginSerializer, CheckUserSerializer, RegularUserSerializer

# Create your views here.

class AdminUserRecordView(APIView):
   
    def get(self, format=None):
        users = User.objects.all()
        serializer = AdminUserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = AdminUserSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )

class CategoryListView(APIView):

    def get(self, request):
        categories = Category.objects.all()
        serializer = CategorySerializer(categories, many= True)
        return Response(serializer.data)

    def post(self, request):
        serializer = CategorySerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class ReportListView(APIView):

    def get(self, request):
        reports = Report.objects.all()
        serializer = ReportSerializer(reports, many= True)
        return Response(serializer.data)

    def post(self, request):
        serializer = ReportSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class CommentListView(APIView):

    def get(self, request):
        comments = Comment.objects.all()
        serializer = CommentSerializer(comments, many= True)
        return Response(serializer.data)

    def post(self, request):
        serializer = CommentSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
class UserLoginView(APIView):
    
    def post(self, request):
        checkUserSerializer = CheckUserSerializer(data=request.data)
       
        if checkUserSerializer.is_valid():
            
            user = RegularUser.objects.get(username = checkUserSerializer.validated_data.get('username'))

            if(checkUserSerializer.validated_data.get('password') == user.password):
                check = True

            userLoginSerializer = UserLoginSerializer(data={'userCheck': check})
            userLoginSerializer.is_valid()
          

            return Response(
                userLoginSerializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": checkUserSerializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )
       
class UserRecordView(APIView):
   
    def get(self, request):
        users = RegularUser.objects.all()
        serializer = RegularUserSerializer(users, many=True)
        return Response(serializer.data)
    
    def post(self, request):
        serializer = RegularUserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



class AdminLoginView(APIView):
    
     def post(self, request):
        checkUserSerializer = CheckUserSerializer(data=request.data)
       
        if checkUserSerializer.is_valid():
            
            user = User.objects.get(username = checkUserSerializer.validated_data.get('username'))
            check = user.check_password(checkUserSerializer.validated_data.get('password'))

            
            userLoginSerializer = UserLoginSerializer(data={'userCheck': check})
            userLoginSerializer.is_valid()
          

            return Response(
                userLoginSerializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": checkUserSerializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )