from datetime import date
from pydantic import BaseModel


class User(BaseModel):
    id: int
    email: str
    nickname: str
    password: str
    date_of_birth: date
    gender: str
