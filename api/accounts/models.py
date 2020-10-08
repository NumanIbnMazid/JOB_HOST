from django.db import models
from django.conf import settings
from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from .choices import (
    GENDER_CHOICES, BLOOD_GROUP_CHOICES, ACCOUNT_TYPE_CHOICES, MARITAL_STATUS_CHOICES,
    JOB_LEVEL_CHOICES, EMPLOYMENT_TYPE_CHOICES, SALARY_SCHEDULE_CHOICES,
    EDUCATION_LEVEL_CHOICES, EDUCATION_RESULT_CHOICES, SKILL_EXPERIENCE_CHOICES, 
    LANGUAGE_PROFICIENCY_CHOICES, LANGUAGE_DIFFICULTY_LEVEL_CHOICES
)
from .utils import upload_project_files_path
from util.utils import random_time_str
from rest_framework.authtoken.models import Token
from middlewares.middlewares import RequestMiddleware
from django.core.validators import MinValueValidator
from decimal import Decimal
from django.db.models import Q
from multiselectfield import MultiSelectField

# Create your models here.


class UserProfile(models.Model):

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, unique=True, related_name='profile', verbose_name='user'
    )
    slug = models.SlugField(
        unique=True, verbose_name='slug'
    )
    account_type = models.CharField(
        max_length=20, blank=True, null=True, choices=ACCOUNT_TYPE_CHOICES, verbose_name='account type'
    )
    gender = models.CharField(
        choices=GENDER_CHOICES, blank=True, null=True, max_length=10, verbose_name='gender'
    )
    dob = models.DateField(
        blank=True, null=True, verbose_name='DOB'
    )
    blood_group = models.CharField(
        max_length=10, blank=True, null=True, choices=BLOOD_GROUP_CHOICES, verbose_name='blood group'
    )
    contact_country_code = models.CharField(
        max_length=5, blank=True, null=True, verbose_name='contact country code'
    )
    contact_number = models.CharField(
        max_length=20, blank=True, null=True, verbose_name='contact number'
    )
    address = models.TextField(
        max_length=200, blank=True, null=True, verbose_name='address'
    )
    city = models.CharField(
        blank=True, null=True, max_length=100, verbose_name='city'
    )
    state = models.CharField(
        blank=True, null=True, max_length=100, verbose_name='state/province'
    )
    zip_code = models.IntegerField(
        blank=True, null=True, verbose_name='zip code'
    )
    country = models.CharField(
        blank=True, null=True, max_length=100, verbose_name='country'
    )
    religion = models.CharField(
        blank=True, null=True, max_length=100, verbose_name='religion'
    )
    marital_status = models.CharField(
        choices=MARITAL_STATUS_CHOICES, blank=True, null=True, max_length=15, verbose_name='marital status'
    )
    about = models.TextField(
        max_length=300, blank=True, null=True, verbose_name='about'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = ("User Profile")
        verbose_name_plural = ("User Profiles")
        ordering = ["-user__date_joined"]

    def username(self):
        return self.user.username

    def get_username(self):
        if self.user.first_name or self.user.last_name:
            name = self.user.get_full_name()
        else:
            name = self.user.username
        return name

    def get_smallname(self):
        if self.user.first_name or self.user.last_name:
            name = self.user.get_short_name()
        else:
            name = self.user.username
        return name

    def get_dynamic_name(self):
        if len(self.get_username()) < 13:
            name = self.get_username()
        else:
            name = self.get_smallname()
        return name

    def get_contact_number(self):
        country_code = '' if self.contact_country_code == None else self.contact_country_code
        contact_number = '' if self.contact_number == None else self.contact_number
        contact = country_code + contact_number
        return contact

    def __str__(self):
        return self.user.username

# Career Info Model
class CareerInfo(models.Model):
    profile = models.OneToOneField(
        UserProfile, on_delete=models.CASCADE, unique=True, related_name='career_profile', verbose_name='profile'
    )
    objective = models.TextField(
        max_length=1000, blank=True, null=True, verbose_name='career objective'
    )
    present_designation = models.CharField(
        max_length=255, blank=True, null=True, verbose_name='present designation'
    )
    desired_designation = models.CharField(
        max_length=255, blank=True, null=True, verbose_name='desired designation'
    )
    present_salary = models.DecimalField(
        decimal_places=2, max_digits=10, validators=[MinValueValidator(
            Decimal(0.00)
        )], null=True, blank=True, verbose_name='present salary'
    )
    desired_salary = models.DecimalField(
        decimal_places=2, max_digits=10, validators=[MinValueValidator(
            Decimal(0.00)
        )], null=True, blank=True, verbose_name='desired salary'
    )
    desired_salary_currency = models.CharField(
        max_length=50, null=True, blank=True, verbose_name='desired salary currency'
    )
    desired_salary_schedule = models.CharField(
        choices=SALARY_SCHEDULE_CHOICES, max_length=50, null=True, blank=True, verbose_name='desired salary schedule'
    )
    present_job_level = models.CharField(
        choices=JOB_LEVEL_CHOICES, blank=True, null=True, max_length=100, verbose_name='present job level'
    )
    desired_job_level = MultiSelectField(
        choices=JOB_LEVEL_CHOICES, blank=True, null=True, max_length=255, verbose_name='desired job level'
    )
    present_employment_type = models.CharField(
        choices=EMPLOYMENT_TYPE_CHOICES, blank=True, null=True, max_length=100, verbose_name='present employment type'
    )
    desired_employment_type = MultiSelectField(
        choices=EMPLOYMENT_TYPE_CHOICES, blank=True, null=True, max_length=255, verbose_name='present employment type'
    )
    special_qualification = models.TextField(
        max_length=500, blank=True, null=True, verbose_name='special qualification'
    )
    willing_to_relocate = models.BooleanField(
        default=False, verbose_name='willing to relocate'
    )
    willing_to_travel = models.BooleanField(
        default=False, verbose_name='willing to travel'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = ("Career Information")
        verbose_name_plural = ("Career Information")
        ordering = ["-profile__user__date_joined"]

    def __str__(self):
        return self.profile.user.username


# Work Experience
class WorkExperience(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='work_experience_profile', verbose_name='profile'
    )
    job_title = models.CharField(
        max_length=100, verbose_name='job title'
    )
    company = models.CharField(
        max_length=150, verbose_name='company'
    )
    address = models.CharField(
        max_length=255, verbose_name='address'
    )
    country = models.CharField(
        max_length=60, blank=True, null=True, verbose_name='country'
    )
    company_business = models.CharField(
        max_length=100, verbose_name='company business'
    )
    department = models.CharField(
        max_length=100, verbose_name='department'
    )
    responsibilities = models.CharField(
        max_length=255, verbose_name='responsibilities'
    )
    area_of_experience = models.CharField(
        max_length=255, verbose_name='area of experience'
    )
    employment_type = models.CharField(
        choices=EMPLOYMENT_TYPE_CHOICES, max_length=100, verbose_name='employment type'
    )
    start_date = models.DateField(
        verbose_name="start date"
    )
    end_date = models.DateField(
        blank=True, null=True, verbose_name="end date"
    )
    is_current = models.BooleanField(
        default=False, verbose_name='is current'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = ("Work Experience")
        verbose_name_plural = ("Work Experiences")
        ordering = ["-profile__user__date_joined"]

    def __str__(self):
        return self.job_title


# Education
class Education(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='education_profile', verbose_name='profile'
    )
    level_of_education = models.CharField(
        choices=EDUCATION_LEVEL_CHOICES, max_length=100, verbose_name='level of education'
    )
    institute = models.CharField(
        max_length=255, verbose_name='institute'
    )
    address = models.CharField(
        max_length=255, verbose_name='address'
    )
    country = models.CharField(
        max_length=60, blank=True, null=True, verbose_name='country'
    )
    field_of_study = models.CharField(
        max_length=255, verbose_name='field of study'
    )
    result = models.CharField(
        choices=EDUCATION_RESULT_CHOICES, max_length=100, blank=True, null=True, verbose_name='result'
    )
    start_date = models.DateField(
         verbose_name="start date"
    )
    end_date = models.DateField(
        blank=True, null=True, verbose_name="end date"
    )
    achievement = models.CharField(
        max_length=255, blank=True, null=True, verbose_name='achievement'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
       auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = ("Education")
        verbose_name_plural = ("Educations")
        ordering = ["-profile__user__date_joined"]

    def __str__(self):
        return self.level_of_education


# Training
class Training(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='training_profile', verbose_name='profile'
    )
    title = models.CharField(
        max_length=255, verbose_name='title'
    )
    institute = models.CharField(
        max_length=255, verbose_name='institute'
    )
    address = models.CharField(
        max_length=255, verbose_name='address'
    )
    country = models.CharField(
        max_length=60, verbose_name='country'
    )
    topics_covered = models.CharField(
        max_length=255, verbose_name='topics covered'
    )
    start_date = models.DateField(
        verbose_name="start date"
    )
    end_date = models.DateField(
        blank=True, null=True, verbose_name="end date"
    )
    is_currently_enrolled = models.BooleanField(
        default=False, verbose_name='is currently enrolled'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = ("Training")
        verbose_name_plural = ("Trainings")
        ordering = ["-profile__user__date_joined"]

    def __str__(self):
        return self.title


# Skill
class Skill(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='skill_profile', verbose_name='profile'
    )
    title = models.CharField(
        max_length=255, verbose_name='title'
    )
    experience = models.CharField(
        choices=SKILL_EXPERIENCE_CHOICES, max_length=100, verbose_name='experience in year'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = ("Skill")
        verbose_name_plural = ("Skills")
        ordering = ["-profile__user__date_joined"]

    def __str__(self):
        return self.title


# Project
class Project(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='project_profile', verbose_name='profile'
    )
    title = models.CharField(
        max_length=255, verbose_name="title"
    )
    slug = models.SlugField(
        max_length=255, unique=True, verbose_name='slug'
    )
    tools_used = models.TextField(
        blank=True, null=True, max_length=1000, verbose_name="tools Used"
    )
    link = models.URLField(
        blank=True, null=True, verbose_name="link"
    )
    is_active = models.BooleanField(
        default=True, verbose_name='is active'
    )
    short_description = models.TextField(
        blank=True, null=True, max_length=2000, verbose_name="short description"
    )
    features = models.TextField(
        blank=True, null=True, verbose_name='features'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created At'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated At'
    )

    class Meta:
        verbose_name = "Project"
        verbose_name_plural = "Projects"
        ordering = ['-profile__user__date_joined']

    def __str__(self):
        return self.title


class ProjectAttachment(models.Model):
    project = models.ForeignKey(
        Project, on_delete=models.CASCADE, related_name='project_attachments', verbose_name='project'
    )
    slug = models.SlugField(
        max_length=255, unique=True, verbose_name='slug'
    )
    title = models.CharField(
        max_length=100, verbose_name='title',
    )
    file = models.FileField(
        upload_to=upload_project_files_path, verbose_name='file'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = "Project Attachment"
        verbose_name_plural = "Project Attachments"
        ordering = ['-project__profile__user__date_joined']

    def __str__(self):
        return self.project.title



# Language Proficiency
class LanguageProficiency(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='language_profile', verbose_name='profile'
    )
    language = models.CharField(
        max_length=100, verbose_name="language"
    )
    proficiency = models.CharField(
        max_length=100, choices=LANGUAGE_PROFICIENCY_CHOICES, verbose_name='proficiency'
    )
    listening = models.CharField(
        max_length=50, choices=LANGUAGE_DIFFICULTY_LEVEL_CHOICES, verbose_name='listening'
    )
    speaking = models.CharField(
        max_length=50, choices=LANGUAGE_DIFFICULTY_LEVEL_CHOICES, verbose_name='speaking'
    )
    reading = models.CharField(
        max_length=50, choices=LANGUAGE_DIFFICULTY_LEVEL_CHOICES, verbose_name='reading'
    )
    writing = models.CharField(
        max_length=50, choices=LANGUAGE_DIFFICULTY_LEVEL_CHOICES, verbose_name='writing'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = 'Language Proficiency'
        verbose_name_plural = 'Language Proficiencies'
        ordering = ['-profile__user__date_joined']

    def __str__(self):
        return self.language


# Online Resource
class OnlineResource(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='online_resource_profile', verbose_name='profile'
    )
    title = models.CharField(
        max_length=100, verbose_name='title'
    )
    url = models.URLField(
        verbose_name='url'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created At'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated At'
    )

    class Meta:
        verbose_name = "Online Resource"
        verbose_name_plural = "Online Resources"
        ordering = ['-profile__user__date_joined']

    def __str__(self):
        return self.title


# Publication
class Publication(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='publication_profile', verbose_name='profile'
    )
    title = models.CharField(
        max_length=100, verbose_name='title'
    )
    url = models.URLField(
        verbose_name='url'
    )
    date_published = models.DateField(
        verbose_name='date published'
    )
    description = models.TextField(
        blank=True, null=True, verbose_name='description'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created At'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated At'
    )

    class Meta:
        verbose_name = "Publication"
        verbose_name_plural = "Publications"
        ordering = ['-profile__user__date_joined']

    def __str__(self):
        return self.title


# Award
class Award(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='award_profile', verbose_name='profile'
    )
    title = models.CharField(
        max_length=100, verbose_name='title'
    )
    date_awarded = models.DateField(
        verbose_name='date awarded'
    )
    description = models.TextField(
        blank=True, null=True, verbose_name='description'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created At'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated At'
    )

    class Meta:
        verbose_name = "Award"
        verbose_name_plural = "Awards"
        ordering = ['-profile__user__date_joined']

    def __str__(self):
        return self.title


# Reference
class Reference(models.Model):
    profile = models.ForeignKey(
        UserProfile, on_delete=models.CASCADE, related_name='reference_profile', verbose_name='profile'
    )
    name = models.CharField(
        max_length=100, verbose_name='name'
    )
    about = models.TextField(
        max_length=1000, blank=True, null=True, verbose_name='about'
    )
    contact = models.CharField(
        max_length=50, blank=True, null=True, verbose_name='contact'
    )
    email = models.CharField(
        max_length=100, blank=True, null=True, verbose_name='email'
    )
    relation = models.CharField(
        max_length=100, verbose_name='relation'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created At'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated At'
    )

    class Meta:
        verbose_name = "Reference"
        verbose_name_plural = "References"
        ordering = ['-profile__user__date_joined']

    def __str__(self):
        return self.name


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    username = instance.username.lower()
    slug_binding = username+'-'+random_time_str()
    try:
        request = RequestMiddleware(get_response=None)
        request = request.thread_local.current_request
        account_type = request.POST.get("account_type")
        # print(f"accounts : models (99) => request => {request}")
        # print(f"accounts : models (100) => account_type => {account_type}")
        if created:
            # Create Token
            Token.objects.create(user=instance)
            # Create user profile
            profile = UserProfile.objects.create(
                user=instance, account_type=account_type, slug=slug_binding
            )
            # Create career info
            CareerInfo.objects.create(
                profile=profile
            )
    except AttributeError:
        if created:
            UserProfile.objects.create(
                user=instance, slug=slug_binding
            )
    instance.profile.save()
