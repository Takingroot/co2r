from common import *

environment = os.getenv('ENVIRONMENT', 'DEVELOP')

try:
    if environment == 'DEVELOP':
        from development import *
    elif environment == 'STAGING':
        from staging import *
    elif environment == 'PRODUCTION':
        from production import *
except ImportError:
    pass
