# Generated by Django 4.2.1 on 2023-05-28 00:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('helpdeskapp', '0005_alter_report_originalposter'),
    ]

    operations = [
        migrations.AddField(
            model_name='comment',
            name='userType',
            field=models.CharField(default='Admin', max_length=5),
        ),
        migrations.AddField(
            model_name='report',
            name='userType',
            field=models.CharField(default='Admin', max_length=5),
        ),
    ]