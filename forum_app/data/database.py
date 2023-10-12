from private_password import my_password
from mariadb import connect
from mariadb.connections import Connection

def _get_connection() -> Connection:
    return connect(
        user='root',
        password= my_password,
        host='localhost',
        port=3306,
        database='new_forum_project'
    )


def read_query(sql: str, sql_params=()):
    with _get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(sql, sql_params)

        return list(cursor)