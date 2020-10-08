from allauth.account.adapter import DefaultAccountAdapter
from django.forms import ValidationError

class UsernameMaxAdapter(DefaultAccountAdapter):

    def clean_username(self, username, shallow=False):
        if len(username) >= 11:
            raise ValidationError('Please enter a username not greater than 10 characters.')
        return DefaultAccountAdapter.clean_username(self,username) # For other default validations.