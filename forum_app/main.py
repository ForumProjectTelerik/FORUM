from fastapi import FastAPI
from routers.users import users_router
from routers.messages import messages_router
from routers.categories import categories_router
from routers.topics import topics_router
from routers.replies import replies_router
from routers.reactions import reactions_router

app = FastAPI(title='The Sport Forum', description='Team #5 web project on Telerik Academy')
app.include_router(users_router)
app.include_router(messages_router)
app.include_router(categories_router)
app.include_router(topics_router)
app.include_router(replies_router)
app.include_router(reactions_router)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run('main:app', host="127.0.0.1", port=8000, reload=True)
