from fastapi import APIRouter, Query, Header, Response
from pydantic import BaseModel
from my_models.model_user import User
from services import user_service,message_service
from authentication.authenticator import get_user_or_raise_401



messages_router = APIRouter(prefix='/messages', tags=['Everything available for Messages'])


@messages_router.get('/')
def get_messages():

    messages = message_service.read_messages()

    result = []
    for data in messages:
        data_dict = {
            "id": data[0],
            "messageOwner": data[1],
            "messageText": data[2]
        }
         
        result.append(data_dict)

    return result


@messages_router.post('/send_message')
def send_message(message_text : str = Query(),
                 receiver_username: str = Query(),
                 x_token: str = Header()):
    
    log_user = get_user_or_raise_401(x_token)
    sender_username = user_service.find_username_by_token(x_token)
    if not user_service.check_username_exist(receiver_username): 
        return Response(status_code=400, content='No user found!')
    if sender_username == receiver_username:
        return Response(status_code=400, content='You cant send message to yourself!')
    
    sender_id = user_service.find_user_by_token(x_token)
    receiver_id = message_service.get_receiver_id_by_username(receiver_username)


    if message_service.check_conversations_between_participants_sender(sender_id) and message_service.check_conversations_between_participants_receiver(receiver_id):
        convo_id = message_service.find_convo_id_by_receiver(receiver_username)
        return message_service.create_message(message_text, sender_id, convo_id, receiver_id)
    else:
        message_sent = message_service.create_message_and_conversation(receiver_username,message_text,sender_id)
        return message_sent


