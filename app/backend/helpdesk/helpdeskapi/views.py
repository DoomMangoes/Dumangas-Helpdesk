from django.shortcuts import render
from rest_framework import generics

# Create your views here.

from helpdeskapp import models
from .serializers import CategorySerializer

class CategoryList(generics.ListCreateAPIView):
    queryset = models.Category.objects.all()
    serializer_class = CategorySerializer

#class CategoryDetail(generics.RetrieveUpdateDestroyAPIView):
 #  queryset = models.Category.objects.all()
  #   serializer_class = CategorySerializer
