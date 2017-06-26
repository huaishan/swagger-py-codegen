# -*- coding: utf-8 -*-
from __future__ import absolute_import

import math
from core import RequestHandler
from .. import UserInfo
from ..validators import request_validate, response_filter


class ApiHandler(RequestHandler):
    on_initialize_decorators = [response_filter, request_validate]

    def get_current_user(self):
        authorization = self.request.headers.get('Authorization', '')
        user_id = self.request.headers.get('user_id')

        return UserInfo(user_id, authorization, self.blueprint)

    @staticmethod
    def success(data=None, code=200, msg=""):
        return {"code": code, "message": msg, "data": data}

    @staticmethod
    def failed(code=500, msg="Server error."):
        return {"code": code, "message": msg}

    @staticmethod
    def paginator(total, data, limit):
        return {
            "code": 200,
            "message": "",
            "data": data,
            "data_total": total,
            "page_total": math.ceil(total/limit)
        }
