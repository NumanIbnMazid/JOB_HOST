from api.settings.common import *

DEBUG = True
TEMPLATE_DEBUG = DEBUG

# ==================== Email Configuration ====================
EMAIL_BACKEND = config('EMAIL_BACKEND', default='')
EMAIL_HOST = config('EMAIL_HOST', default='localhost')
EMAIL_PORT = config('EMAIL_PORT', default=25, cast=int)
EMAIL_HOST_PASSWORD = config('EMAIL_HOST_PASSWORD', default='')
EMAIL_HOST_USER = config('EMAIL_HOST_USER', default='')
EMAIL_USE_TLS = config('EMAIL_USE_TLS', default=False, cast=bool)

# ==================== Security Modules ===================
CSRF_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'Strict'
SESSION_COOKIE_SECURE = True
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
SECURE_SSL_REDIRECT = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
X_FRAME_OPTIONS = 'DENY'
# set low, but when site is ready for deployment, set to at least 15768000 (6 months)
SECURE_HSTS_SECONDS = 1000000  # 300
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True

# Neededf for CorsHeader (accept connections from everywhere)
# CORS_ORIGIN_ALLOW_ALL = True

CORS_ALLOW_HEADERS = (
    'x-requested-with',
    'content-type',
    'accept',
    'origin',
    'authorization',
    'x-csrftoken',
    'token',
    'x-device-id',
    'x-device-type',
    'x-push-id',
    'dataserviceversion',
    'maxdataserviceversion'
)
CORS_ALLOW_METHODS = (
    'GET',
    'POST',
    'PUT',
    'PATCH',
    'DELETE',
    'OPTIONS'
)
