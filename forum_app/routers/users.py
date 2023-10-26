from fastapi import APIRouter, Header, Response, Query
from services import user_service
from authentication.authenticator import get_user_or_raise_401
from datetime import date
from my_models.model_user import UserResult

users_router = APIRouter(prefix='/user')


@users_router.get('/',tags={'All Users'})
def get_users(x_token: str = Header()):

    user = get_user_or_raise_401(x_token)
    users = user_service.read_users()

    result = []

    for data in users:
        data_dict = {
            "id_for_user": data[0],
            "email": data[1],
            "nickname": data[2],
            "password": data[3],
            "date_of_birth": data[4],
            "gender": data[5]
        }
         
        result.append(data_dict)

    return result

@users_router.post('/login', tags=["Login from here"])
def login(username: str = Query(),password: str = Query()):
    user = user_service.try_login(username, password)

    if user:
        token = user_service.create_token(user)
        return {'token': token}
    else:
        return Response(status_code=404, content='Invalid login data')


@users_router.post('/register', tags=["Register from here"])
def register(email: str  = Query(), 
             username: str = Query(), 
             password: str = Query(), 
             date_of_birth: date = Query(), 
             gender: str = Query()):

    if user_service.check_email_exist(email):
        return Response(status_code=400, content=f'This email is already taken!')

    if user_service.check_username_exist(username):
        return Response(status_code=400, content=f'This nickname is already taken!')
    else:
        user = user_service.create_user(email, username, password,date_of_birth,gender)
        return user


@users_router.get('/info', tags=["User"])
def user_info(x_token: str = Header()):
    
    user = get_user_or_raise_401(x_token)

    return UserResult(id=user.id, username=user.nickname)