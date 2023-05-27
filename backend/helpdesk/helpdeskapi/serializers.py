from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from helpdeskapp import models


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

    class Meta:
        model = User
        fields = (
            'username',
            'password',
            'is_superuser'
        )
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=['username', 'email']
            )
        ]

class CategorySerializer(serializers.ModelSerializer):
    
    class Meta:
        fields=( 
            'categoryName',
        )
        model = models.Category

class ReportSerializer(serializers.ModelSerializer):
    
    class Meta:
        fields=( 
            'reportID','reportTitle','reportBody','originalPoster','category','date',
        )
        model = models.Report

class CommentSerializer(serializers.ModelSerializer):
    
    class Meta:
        fields=( 
            'commentID','commentBody','originalPoster','parentID','date',
        )
        model = models.Comment

class UserLoginSerializer(serializers.Serializer):

    userCheck = serializers.BooleanField(default = False)

class CheckUserSerializer(serializers.Serializer):
    username = serializers.CharField(max_length = 150)
    password = serializers.CharField(max_length = 150)
    