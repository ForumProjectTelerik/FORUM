from fastapi import APIRouter, Header, Response, Query
from authentication.authenticator import get_user_or_raise_401
from services import topic_service, user_service
from my_models.model_topic import TopicResult
from my_models.model_topic import Topic
from fastapi.responses import JSONResponse


topics_router = APIRouter(prefix='/topic',tags={'Everything available for Topics'})


@topics_router.get('/',description='You can search/sort every topic from here.')
def view_all_topics(search: str = Query(None),sort: str = Query(default='Ascending',description='You can choose how to sort the title: ascending or descending')):

    if search:
        topics = topic_service.search_by_topic(search)
    elif sort:
        topics = topic_service.sort_by_topic(sort)
    else:
        topics = topic_service.read_topic()

    result = []

    for data in topics:
        data_dict = {
            "id_of_topic": data[0],
            "title": data[1],
            "topic_text": data[2],
            "date_of_creation": data[3],
            "category_name": data[4],
            "id_of_author": data[5]
        }
         
        result.append(data_dict)

    return result

@topics_router.post('/add_topic',description='You can create new topic using available categories from here.')
def add_topic(x_token: str = Header(),
        title: str = Query(),
        topic_text: str = Query(),
        date_of_creation: str = Query(),
        name_of_category: str = Query(),
    ):
    user = get_user_or_raise_401(x_token)
    username = user_service.get_username_by_token(x_token)

    if topic_service.topic_exists(title):
        return JSONResponse(status_code=400, content='Topic with this title already exists')
    else:
        everything = topic_service.create_topic(title,topic_text,date_of_creation,name_of_category,username)
        return everything

@topics_router.get('/view_topic')
def view_topic_with_replies(id: int = Query()):

    topic_with_reply = topic_service.view_topic_with_reply(id)

    if not topic_with_reply:
        return JSONResponse(status_code=404,content=f'There is no such topic with this ID: {id}')

    result = []

    for data in topic_with_reply:
        username = user_service.find_user_by_id(data[5])
        reply = topic_service.view_reply_by_topic(data[0])
        data_dict = {
            "id_of_topic": data[0],
            "title": data[1],
            "topic_text": data[2],
            "date_of_creation": data[3],
            "category_name": data[4],
            "author_of_topic": username,
            "replies": reply
        }

        result.append(data_dict)

    return result