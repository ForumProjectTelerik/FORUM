from my_models.model_category import Category
from data.database import read_query, insert_query


def all_categories(name = None):
    sql = '''SELECT name_of_category FROM category'''

    if name:
        sql += ' WHERE ' + f'name_of_category = {name}'
    return (Category.from_query_result(*row) for row in read_query(sql))



def category_exists(name: str):
    query = read_query('''SELECT * FROM category WHERE name_of_category = ?''',
                       (name,))
    return any(query)


def create_category(category: str):
    category_name = insert_query(
        '''INSERT INTO category(name_of_category) VALUE(?)''',
        (category,))

    return category_name

def get_topics_by_category_name(name: str):
    query = 'SELECT * FROM new_topic WHERE category_name_of_category = ?'
    data = (name,)
    get_topics = read_query(query, data)
    return get_topics