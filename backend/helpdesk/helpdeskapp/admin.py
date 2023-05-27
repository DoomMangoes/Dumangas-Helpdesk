from django.contrib import admin
from .models import Category, Report, Comment

# Register your models here.
admin.site.register(Category)
admin.site.register(Report)
admin.site.register(Comment)
