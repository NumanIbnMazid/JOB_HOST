import time
import os
from rest_framework import serializers
from collections import OrderedDict

class ChoicesField(serializers.Field):
    """Custom ChoiceField serializer field."""

    def __init__(self, choices, **kwargs):
        """init."""
        self._choices = OrderedDict(choices)
        super(ChoicesField, self).__init__(**kwargs)

    def to_representation(self, obj):
        """Used while retrieving value for the field."""
        return self._choices[obj]

    def to_internal_value(self, data):
        """Used while storing value for the field."""
        for i in self._choices:
            if self._choices[i] == data:
                return i
        raise serializers.ValidationError(
            "Acceptable values are {0}.".format(list(self._choices.values())))


def get_filename_ext(filepath):
    base_name = os.path.basename(filepath)
    name, ext = os.path.splitext(base_name)
    return name, ext


def upload_profile_image_path(instance, filename):
    new_filename = "image_{datetime}".format(
        datetime=time.strftime("%Y%m%d-%H%M%S")
    )
    name, ext = get_filename_ext(filename)
    final_filename = '{new_filename}{ext}'.format(
        new_filename=new_filename, ext=ext)
    return "Profile-Picture/{final_filename}".format(
        final_filename=final_filename
    )


def upload_project_files_path(instance, filename):
    new_filename = "{title}_{datetime}".format(
        title=instance.project.title[:20],
        datetime=time.strftime("%Y%m%d-%H%M%S")
    )
    name, ext = get_filename_ext(filename)
    final_filename = '{new_filename}{ext}'.format(
        new_filename=new_filename, ext=ext)
    return "Projects/{title}/{final_filename}".format(
        title=instance.project.title[:20],
        final_filename=final_filename
    )
