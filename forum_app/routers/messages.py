from data.models import User
from services import user_service,message_service
from fastapi import APIRouter
from pydantic import BaseModel


messages_router = APIRouter(prefix='/messages')


@messages_router.get('/')
def get_messeges():

    messages = message_service.read_messages()

    result = []
    for data in messages:
        data_dict = {
            "id": data[0],
            "owner_of_massage": data[1],
            "message_text": data[2]
        }
         
        result.append(data_dict)

    return result


