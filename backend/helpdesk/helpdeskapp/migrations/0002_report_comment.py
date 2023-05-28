# Generated by Django 4.2.1 on 2023-05-27 01:38

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('helpdeskapp', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Report',
            fields=[
                ('reportID', models.CharField(max_length=256, primary_key=True, serialize=False)),
                ('reportTitle', models.TextField()),
                ('reportBody', models.TextField()),
                ('date', models.DateField()),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='helpdeskapp.category')),
                ('originalPoster', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('commentID', models.CharField(max_length=256, primary_key=True, serialize=False)),
                ('commentBody', models.TextField()),
                ('date', models.DateField()),
                ('originalPoster', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('parentID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='helpdeskapp.report')),
            ],
        ),
    ]
