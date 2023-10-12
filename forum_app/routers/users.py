from pydantic import BaseModel
from data.models import User
from services import user_service
from fastapi import APIRouter

users_router = APIRouter(prefix='/users')


@users_router.get('/')
def get_users():

    users = user_service.read_users()

    result = []

    for data in users:
        data_dict = {
            "id_for_user": data[0],
            "email": data[1],
            "nickname": data[2],
            "password": hash(data[3]),
            "date_of_birth": data[4],
            "gender": data[5]
        }
         
        result.append(data_dict)

    return result