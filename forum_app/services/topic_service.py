from data.database import read_query,insert_query
from my_models.model_topic import Topic
from datetime import datetime


_SEPARATOR = ';'


def read_topic():
    data = read_query('SELECT * FROM new_topic')
    return data


def find_by_name(name: str) -> Topic | None:
    data = read_query(
        'SELECT * FROM new_topic WHERE topic_name = ?',
        (name,))

    return next((Topic.from_query_result(*row) for row in data), None)


def find_topic_by_id(id: int) -> Topic | None:
    data = read_query(
        'SELECT * FROM new_user WHERE id_of_user = ?',
        (id,))

    return data[0][2]
