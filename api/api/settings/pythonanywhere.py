from api.settings.production import *

SECRET_KEY = config('SECRET_KEY')

ALLOWED_HOSTS = ['api.pythonanywhere.com', '.api.com']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': config('DB_NAME_PAW'),
        'USER': config('DB_USER_PAW'),
        'PASSWORD': config('DB_PASSWORD_PAW'),
        'HOST': config('DB_HOST_PAW'),
        'PORT': '',
        'OPTIONS': {
            'charset': 'utf8mb4',
            'autocommit': True,
            'use_unicode': True,
            'init_command': 'SET storage_engine=INNODB,character_set_connection=utf8mb4,collation_connection=utf8mb4_unicode_ci',
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'"
        },
    }
}

# Static Files
STATIC_URL = '/static/'
MEDIA_URL = '/media/'

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static_proj'),
]

STATIC_ROOT = '/home/blood_finder_api/static_cdn/static_root'
MEDIA_ROOT = '/home/blood_finder_api/static_cdn/media_root'
