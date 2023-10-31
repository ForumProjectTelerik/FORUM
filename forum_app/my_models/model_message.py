from pydantic import BaseModel

class Message(BaseModel):
    id: int
    message_text: str
    sender_username: str
    receiver: str