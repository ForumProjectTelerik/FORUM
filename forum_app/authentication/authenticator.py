from fastapi import HTTPException
from my_models.model_user import User
from services.user_service import from_token,is_authenticated, find_id_by_token


def get_user_or_raise_401(token: str) -> User:
    if not is_authenticated(token):
        raise HTTPException(status_code=401)

    return from_token(token)

def get_id_or_raise_401(token: str) -> str:
    if not is_authenticated(token):
        raise HTTPException(status_code=401, detail="Unauthorized")
    
    user_id = find_id_by_token(token)
    
    if user_id is None:
        raise HTTPException(status_code=401, detail="User not found")
    
    return token