from data.database import read_query

def read_users():

    data = read_query('SELECT * FROM new_user')


    return data