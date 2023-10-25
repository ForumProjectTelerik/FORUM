from models.model_category import Category
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


def create_category(category: Category):
    category_name = insert_query(
        '''INSERT INTO category(name_of_category) VALUE(?)''',
        (category.name,))

    return category_name