# Generated by Django 4.2.1 on 2023-05-28 00:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('helpdeskapp', '0004_regularuser_is_superuser'),
    ]

    operations = [
        migrations.AlterField(
            model_name='report',
            name='originalPoster',
            field=models.CharField(max_length=150),
        ),
    ]