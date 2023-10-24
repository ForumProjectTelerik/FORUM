from datetime import date
from pydantic import BaseModel, constr


class User(BaseModel):
    id: int
    email: str
    nickname: str
    password: str
    date_of_birth: date
    gender: str




class Category(BaseModel):
    id: int | None = None
    name: constr(min_length=5)
    topics: list = []

    @classmethod
    def from_query_result(cls, name, topics = None):
        return cls(name = name,
                   topics = topics or [])


class Topics(BaseModel):
    id_of_topic: int | None
    title: constr(min_length= 3)
    topic_owner: str    # User
    date_of_creation: date
    # likes_of_post_id_of_likes: int
    # replies_id_of_replies: int
    # category_name_of_category: Category
    # new_user_id_of_user: int