from rest_framework import serializers
from helpdeskapp import models

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Category
        fields = (
            'id',
            'categoryName',
        )
    