from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Category(models.Model):
    categoryName = models.CharField(max_length=32, primary_key= True)

    def __str__(self):
        return self.categoryName
    
class Report(models.Model):
    reportID = models.CharField(max_length=256, primary_key=True)
    reportTitle = models.TextField()
    reportBody = models.TextField()
    originalPoster = models.ForeignKey(User, on_delete=models.CASCADE)
    #userType = models.CharField(max_length=5)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    date = models.DateField()

class Comment(models.Model):
    commentID = models.CharField(max_length=256, primary_key=True)
    commentBody = models.TextField()
    originalPoster = models.ForeignKey(User, on_delete=models.CASCADE)
    #userType = models.CharField(max_length=5)
    parentID = models.ForeignKey(Report, on_delete=models.CASCADE)
    date = models.DateField()



