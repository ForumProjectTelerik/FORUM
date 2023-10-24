from models.model_user import User
from services import user_service,message_service
from fastapi import APIRouter, Header
from pydantic import BaseModel
from authentication.authenticator import get_user_or_raise_401

messages_router = APIRouter(prefix='/messages')


@messages_router.get('/',tags={'All messages'})
def get_messeges(x_token: str = Header()):
    user = get_user_or_raise_401(x_token)

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


