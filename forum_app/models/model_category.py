from datetime import date
from pydantic import BaseModel, constr
from models.model_topic import Topics

class Category(BaseModel):
    name: constr(min_length=5)

    @classmethod
    def from_query_result(cls, name, topics = None):
        return cls(name = name,
                   topics = topics or [])
    
class CategoryResponseModel(BaseModel):
    category: Category
    topics: list[Topics]
