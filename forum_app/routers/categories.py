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
def create_category(category: Category = Body(),x_token: str = Header()):
    if category_service.category_exists(category.name):
        _ = get_user_or_raise_401(x_token)
        return JSONResponse(status_code=409,
                            content={'detail': f'Category with name "{category.name}" already exists.'})

    new_category = category_service.create_category(category)
    return {"Category has been created"}

@categories_router.get('/{category_name_of_category}/topics', tags={'Topics for Category'})
def get_topics_for_category(category_name: str):
    if not category_service.category_exists(category_name):
        raise HTTPException(status_code=404, detail=f'Category with name "{category_name}" not found.')
    else:
        topics = category_service.get_topics_by_category_name(category_name)
        return topics
























