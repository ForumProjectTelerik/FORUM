from fastapi import APIRouter, Header
from fastapi.responses import JSONResponse
from authentication.authenticator import get_user_or_raise_401
from services import reply_services, topic_service, user_service


replies_router = APIRouter(prefix='/replies', tags=['Replies'])


@replies_router.get('/{title}')
def view_replies_by_topic_title(topic_title: str, x_token: str = Header()):
    get_user_or_raise_401(x_token)
    if not topic_service.topic_exists(topic_title):
        return JSONResponse(status_code=404, content=f'No topic with name "{topic_title}"')

    topic_id  = topic_service.find_topic_id_by_name(topic_title)
    replies = reply_services.read_replies_by_topic_id(topic_id)

    result = []
    for data in replies:
        username = user_service.find_user_by_id(data[1])
        data_dict = {"reply text": data[0], "reply by": username}
        result.append(data_dict)
    return result



@replies_router.post('/add_reply')
def add_reply(topic_title: str, reply_text:str, username, x_token: str = Header()):
    get_user_or_raise_401(x_token)

    if not topic_service.topic_exists(topic_title):
        return JSONResponse(status_code=404, content=f'No topic with name "{topic_title}"')

    return reply_services.create_reply(topic_title, reply_text, username)






