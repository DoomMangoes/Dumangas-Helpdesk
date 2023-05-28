from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class RegularUser(models.Model):
    username = models.CharField(max_length=150,primary_key= True)
    password =  models.CharField(max_length=150)
    is_superuser = models.BooleanField(default=False)

class Category(models.Model):
    categoryName = models.CharField(max_length=32, primary_key= True)

    def __str__(self):
        return self.categoryName
    
class Report(models.Model):
    reportID = models.CharField(max_length=256, primary_key=True)
    reportTitle = models.TextField()
    reportBody = models.TextField()
    originalPoster = models.CharField(max_length=150)
    userType = models.CharField(max_length=5, default="Admin")
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    date = models.DateField()

class Comment(models.Model):
    commentID = models.CharField(max_length=256, primary_key=True)
    commentBody = models.TextField()
    originalPoster = models.CharField(max_length=150)
    userType = models.CharField(max_length=5, default="Admin")
    parentID = models.ForeignKey(Report, on_delete=models.CASCADE)
    date = models.DateField()




