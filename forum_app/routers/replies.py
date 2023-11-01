from fastapi import APIRouter, Header
from fastapi.responses import JSONResponse
from authentication.authenticator import get_user_or_raise_401
from services import reply_services, topic_service, user_service


replies_router = APIRouter(prefix='/replies', tags=['Everything available for Replies'])


@replies_router.get('/{title}',description='You can view every reply using a specific topic title.')
def view_replies_by_topic_title(topic_title: str, x_token: str = Header()):
    get_user_or_raise_401(x_token)
    if not topic_service.topic_exists(topic_title):
        return JSONResponse(status_code=404, content=f'No topic with name "{topic_title}"')

    topic_id  = topic_service.find_topic_id_by_name(topic_title)
    replies = reply_services.read_replies_by_topic_id(topic_id)

    result = []
    for data in replies:
        username = user_service.find_user_by_id(data[2])
        reactions = reply_services.get_downup_vote(data[0])
        data_dict = {
            "Reply ID": data[0],
            "Reply Text": data[1], 
            "Reply Username": username,
            "Reply Reactions": reactions
            }
        result.append(data_dict)
    return result



@replies_router.post('/add_reply',description='You can add a new reply under a created topic.')
def add_reply(topic_title: str, reply_text:str, x_token: str = Header()):
    get_user_or_raise_401(x_token)
    username = user_service.get_username_by_token(x_token)
    if not topic_service.topic_exists(topic_title):
        return JSONResponse(status_code=404, content=f'No topic with name "{topic_title}"')

    return reply_services.create_reply(topic_title, reply_text, username)






