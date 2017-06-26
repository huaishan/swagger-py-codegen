# -*- coding: utf-8 -*-
from __future__ import absolute_import, print_function

from tornado import gen
from . import ApiHandler
from .. import schemas


class {{ name }}(ApiHandler):

    {%- for method, ins in methods.items() %}

    @gen.coroutine
    def {{ method.lower() }}(self{{ params.__len__() and ', ' or '' }}{{ params | join(', ') }}):
        {%- for request in ins.requests %}
        print(self.{{ request }})
        {%- endfor %}

        {% if 'response' in  ins -%}
        raise gen.Return(self.success({{ ins.response.0 }}))
        {%- else %}
        pass
        {%- endif %}
    {%- endfor -%}

