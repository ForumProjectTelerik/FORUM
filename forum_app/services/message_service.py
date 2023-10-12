from data.database import read_query

def read_messages():

    data = read_query('SELECT * FROM messages')
    return data