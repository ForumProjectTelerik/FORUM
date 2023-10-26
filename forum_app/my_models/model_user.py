from datetime import date
from pydantic import BaseModel


class User(BaseModel):
    id: int
    email: str
    nickname: str
    password: str
    date_of_birth: date = None
    gender: str

    @classmethod
    def from_query_result(cls, id, email,nickname, password,date_of_birth, gender):
        return cls(
            id=id,
            email=email,
            nickname = nickname,
            password=password,
            date_of_birth=date_of_birth,
            gender=gender)

class UserResult(BaseModel):
    id: int
    username: str