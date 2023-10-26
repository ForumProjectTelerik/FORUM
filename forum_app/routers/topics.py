from fastapi import APIRouter, Header, Response, Query
from authentication.authenticator import get_user_or_raise_401
from services import topic_service, user_service
from my_models.model_topic import TopicResult
from my_models.model_topic import Topic


topics_router = APIRouter(prefix='/topic')


@topics_router.get('/',tags={'All Topics'})
def get_topics(x_token: str = Header()):

    topic = get_user_or_raise_401(x_token)
    topics = topic_service.read_topic()

    result = []

    for data in topics:
        data_dict = {
            "title=title": data[0],
            "topic_text": data[1],
            "date_of_creation": data[2],
            "category_name_of_category": data[3],
            "id_of_author": data[4]
        }
         
        result.append(data_dict)

    return result

@topics_router.post('/add_topic', tags=["Add Topic"])
def add_topic(
    title: str = Query(),
    topic_text: str = Query(),
    date_of_creation: str = Query(),
    category_name_of_category: str = Query(),
    id_of_author: int = Query()
):
 
    new_topic = Topic(
        id=None, 
        title=title,
        topic_text=topic_text,
        date_of_creation=date_of_creation,
        category_name_of_category=category_name_of_category,
        id_of_author=id_of_author
    )

    return {"message": "Topic added successfully"}