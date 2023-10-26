from datetime import date
from pydantic import BaseModel, constr

class Topic(BaseModel):
    id: None
    title: constr(min_length = 3)
    topic_text: str
    date_of_creation: date
    category_name_of_category: str
    id_of_author: int

    @classmethod
    def from_query_result(cls, id, title,topic_text, date_of_creation,category_name_of_category, id_of_author):
        return cls(
            id=id,
            title=title,
            topic_text = topic_text,
            date_of_creation=date_of_creation,
            category_name_of_category=category_name_of_category,
            id_of_author=id_of_author)
    
class TopicResult(BaseModel):
    id: int
    name: str