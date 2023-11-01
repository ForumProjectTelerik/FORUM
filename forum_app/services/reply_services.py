from data.database import read_query, insert_query
from services import topic_service
from fastapi.responses import JSONResponse
from services import user_service

def read_replies_by_topic_id(topic_id):
    data = read_query('''SELECT id_of_replies, text, new_user_id 
                        FROM replies WHERE  new_topic_id = ?''',
                      (topic_id,))
    return data

def create_reply(topic_title: str, text: str, username):
    get_author_id = topic_service.find_id_nickname(username)
    author_id = get_author_id[0][0]
    topic_id = topic_service.find_topic_id_by_name(topic_title)

    if not topic_service.topic_exists(topic_title):
        return JSONResponse(status_code=404, content='There is no such topic')

    insert_query('''INSERT INTO replies (text, new_topic_id, new_user_id)
                    VALUES (?, ?, ?)''', (text, topic_id, author_id))

    return 'The reply was added successfully'


def get_downup_vote(reply_id):
    data = read_query('SELECT UpVote,DownVote,new_user_id from reactions_of_replies WHERE id_of_replies = ?',(reply_id,))
    replies = [{'Reaction Nickname': user_service.find_user_by_id(row[2]),'UpVote': row[0], 'DownVote': row[1]} for row in data]
    return replies