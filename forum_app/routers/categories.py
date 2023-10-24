from fastapi import APIRouter
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from data.models import Category, Topics
from services import category_service

categories_router = APIRouter(prefix='/categories')

class CategoryResponseModel(BaseModel):
    category: Category
    topics: list[Topics]


@categories_router.get('/')
def view_categories(name: str | None = None):
    return category_service.all_categories(name)



@categories_router.post('/', status_code=201)
def create_category(category: Category):
    if category_service.category_exists(category.name):
        return JSONResponse(status_code=409,
                            content={'detail': f'Category with name "{category.name}" already exists.'})

    return category_service.create_category(category)

























