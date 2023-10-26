from data.database import read_query,insert_query
from my_models.model_topic import Topic
from datetime import datetime,date
from services.user_service import find_by_username
from services.category_service import category_exists
from fastapi import Response


def read_topic():
    data = read_query('SELECT * FROM new_topic')
    return data


def find_by_id_topic(id_of_topic: int) -> Topic | None:
    id = 'SELECT * FROM new_topic WHERE id_of_topic'
    new_paramater = (id_of_topic,)

    new_result = read_query(id,new_paramater)

    if new_result:
        return new_result[0]
    else:
        return None

def sort_by_topic(sort):
    if sort == 'Ascending':
       something = read_query('SELECT * FROM new_topic ORDER BY title ASC')
    elif sort == 'Descending':
       something = read_query('SELECT * FROM new_topic ORDER BY title DESC')
    return something

def search_by_topic(search):
    search_data = read_query('SELECT * FROM new_topic WHERE title LIKE ?',(f'%{search}%',))
    return search_data

def topic_exists(by_title: str):
    check = read_query('SELECT title FROM new_topic WHERE title = ?',(by_title,))

    return bool(check)

def find_id_nickname(nickname):
    check = read_query('SELECT id_of_user FROM new_user WHERE nickname = ?', (nickname,))
    return check

def create_topic(title: str, topic_text: str, date_of_creation: date, name_of_category: str, username: str) -> Topic | None:

    get_author_id = find_id_nickname(username)
    getting_it = get_author_id[0][0]
    check_category = ""

    if category_exists(name_of_category):
        check_category = name_of_category
    else:
        return Response(status_code=400, content='There is no such category')
    createtopic = insert_query('INSERT INTO new_topic(title, topic_text,date_of_creation,category_name_of_category,id_of_author) VALUES (?,?,?,?,?)',
                               (title,topic_text,date_of_creation,name_of_category,getting_it,))
    
    return Topic(title=title,topic_text=topic_text,date_of_creation=date_of_creation,name_of_category=check_category,id_of_author=getting_it)