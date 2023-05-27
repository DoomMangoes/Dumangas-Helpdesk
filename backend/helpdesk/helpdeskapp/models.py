from django.db import models

# Create your models here.

class Category(models.Model):
    categoryName = models.CharField(max_length=32, primary_key= True)

    def __str__(self):
        return self.categoryName
