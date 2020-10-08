from api.settings.common import *

SECRET_KEY = config('SECRET_KEY')
DEBUG = config('DEBUG', default=False, cast=bool)

# ALLOWED_HOSTS = config('ALLOWED_HOSTS', cast=Csv())
ALLOWED_HOSTS = ['*']

EMAIL_BACKEND = config('EMAIL_BACKEND', default='')
EMAIL_HOST = config('EMAIL_HOST', default='localhost')
EMAIL_PORT = config('EMAIL_PORT', default=25, cast=int)
EMAIL_HOST_PASSWORD = config('EMAIL_HOST_PASSWORD', default='')
EMAIL_HOST_USER = config('EMAIL_HOST_USER', default='')
EMAIL_USE_TLS = config('EMAIL_USE_TLS', default=False, cast=bool)


# Database Settings Module

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.mysql',
#         'NAME': config('DB_NAME'),
#         'USER': config('DB_USER'),
#         'PASSWORD': config('DB_PASSWORD'),
#         'HOST': config('DB_HOST'),
#         'PORT': '',
#         'OPTIONS': {
#             'charset': 'utf8mb4',
#             'autocommit': True,
#             'use_unicode': True,
#             'init_command': 'SET storage_engine=INNODB,character_set_connection=utf8mb4,collation_connection=utf8mb4_unicode_ci',
#             'init_command': "SET sql_mode='STRICT_TRANS_TABLES'"
#         },
#     }
# }

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql',
#         'NAME': config('DB_NAME_PS'),
#         'USER': config('DB_USER_PS'),
#         'PASSWORD': config('DB_PASSWORD_PS'),
#         'HOST': config('DB_HOST_PS'),
#         'PORT': config('DB_PORT_PS'),
#         # 'OPTIONS': {
#         #     'charset': 'utf8mb4',
#         #     'autocommit': True,
#         #     'use_unicode': True,
#         #     'init_command': 'SET storage_engine=INNODB,character_set_connection=utf8mb4,collation_connection=utf8mb4_unicode_ci',
#         #     'init_command': "SET sql_mode='STRICT_TRANS_TABLES'"
#         # },
#     }
# }


# Static Files
STATIC_URL = '/static/'
MEDIA_URL = '/media/'

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static_proj'),
]
STATIC_ROOT = os.path.join('static_cdn', 'static_root')
MEDIA_ROOT = os.path.join('static_cdn', 'media_root')
