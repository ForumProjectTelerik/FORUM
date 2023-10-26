from datetime import date
from pydantic import BaseModel, constr

class Topics(BaseModel):
    id_of_topic: int | None
    title: constr(min_length= 3)
    topic_owner: str    # User
    date_of_creation: date
    # likes_of_post_id_of_likes: int
    # replies_id_of_replies: int
    # category_name_of_category: Category
    # new_user_id_of_user: int