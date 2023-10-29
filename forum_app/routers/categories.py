from fastapi import APIRouter, Query, Body,Header, HTTPException
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from my_models.model_category import Category
from my_models.model_topic import Topic
from services import category_service
from my_models.model_category import CategoryResponseModel
from authentication.authenticator import get_user_or_raise_401

categories_router = APIRouter(prefix='/categories')


@categories_router.get('/',tags={'All categories'})
def view_categories(x_token: str = Header()):
    _ = get_user_or_raise_401(x_token)
    return category_service.all_categories()


@categories_router.post('/',tags={'Create a category from here'}, status_code=201)
def create_category(category: str = Query(),x_token: str = Header()):
    if category_service.category_exists(category):
        _ = get_user_or_raise_401(x_token)
        return JSONResponse(status_code=409,
                            content={'detail': f'Category with name "{category}" already exists.'})

    new_category = category_service.create_category(category)
    return {"Category has been created"}

@categories_router.get('/view_topics', tags={'All topics from one Category',},description= 'You can get all topics from one category')
def get_topics_for_category(category_name: str,x_token: str = Header()):
    _ = get_user_or_raise_401(x_token)
    if not category_service.category_exists(category_name):
        raise HTTPException(status_code=404, detail=f'Category with name "{category_name}" not found.')
    else:
        topics = category_service.get_topics_by_category_name(category_name)
        
        result = []
        for correct_format in topics:
            data_dict = {
                "Title": correct_format[1],
                "Text": correct_format[2],
                "Date_of_Creation": correct_format[3],
                "Category_Name": correct_format[4],
                
            }
            
            result.append(data_dict)

        return result
























