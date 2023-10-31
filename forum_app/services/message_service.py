from data.database import read_query, insert_query, update_query
from my_models.model_message import Message
from fastapi import Response


def read_messages():

    data = read_query('SELECT * FROM messages')
    return data


def get_receiver_id_by_username(receiver_username):

    id_user = read_query('SELECT id_of_user FROM new_user WHERE nickname = ?', (receiver_username,))

    return id_user[0][0]


def check_convo_by_receiver_username(receiver_username):

    receiver_id = get_receiver_id_by_username(receiver_username)
    check = read_query('SELECT id_of_conversations FROM conversations WHERE receiver = ?', (receiver_id,))

    return bool(check)

def find_existing_convo_by_username_receiver(receiver_username):
    receiver_id = get_receiver_id_by_username(receiver_username)
    convo_id = read_query('SELECT id_of_conversations FROM conversations WHERE receiver = ?', (receiver_id,))


    if convo_id:
        return convo_id[0][0]
    else:
        return None
    
def find_username_by_id(sender_id):

    username = read_query('SELECT nickname FROM new_user WHERE id_of_user = ?', (sender_id,))

    return username[0][0]

def find_receiver_by_convo_id(convo_id, receiver):

    receiver_id = read_query('SELECT receiver FROM conversations WHERE id_of_conversations = ?', (convo_id,))

    if receiver_id:
        nickname = read_query('SELECT nickname FROM new_user WHERE id_of_user = ?', (receiver_id[0][0],))
        return nickname[0][0]
    else:
        nickname = read_query('SELECT nickname FROM new_user WHERE id_of_user = ?', (receiver,))
        return nickname

def create_message(message_text: str, sender_id: int, convo_id: int, receiver_id: str):

    username = find_username_by_id(sender_id)
    receiver_username_by_convo = find_receiver_by_convo_id(convo_id, receiver_id)

    new_message = insert_query('INSERT INTO messages(text_message, new_user_id_of_user, conversations_between_users_id_of_conversations) VALUES (?,?,?)',
                               (message_text, sender_id, convo_id))
    

    return Message(id=new_message, message_text=message_text,sender_username=username,receiver=receiver_username_by_convo)

def find_convo_id_by_receiver(receiver_username: str):

    receiver_id = get_receiver_id_by_username(receiver_username)

    convo_id = read_query('SELECT id_of_conversations FROM conversations WHERE receiver = ?', (receiver_id,))

    if convo_id:
        return convo_id[0][0]
    else:
        insert = insert_query('INSERT INTO conversations(receiver) VALUES (?)', (receiver_id,))
        new_convo_id = read_query('SELECT id_of_conversations FROM conversations WHERE receiver = ?', (receiver_id,))
        return new_convo_id[0][0] + 1


def check_conversations_between_participants_sender(sender_id):

    check = read_query('SELECT convo_id FROM conversations_between_new_users WHERE user_id = ?', (sender_id,))

    return bool(check)

def check_conversations_between_participants_receiver(receiver_id):

    check = read_query('SELECT convo_id FROM conversations_between_new_users WHERE user_id = ?', (receiver_id,))

    return bool(check)


def create_message_and_conversation(receiver_username: str, message_text: str, sender_id):

    receiver_id = get_receiver_id_by_username(receiver_username)

    if check_conversations_between_participants_sender(sender_id) and check_conversations_between_participants_receiver(receiver_id):
        convo_id = find_convo_id_by_receiver(receiver_username)
        message = insert_query('INSERT INTO messages(text_message, new_user_id_of_user, conversations_between_users_id_of_conversations) VALUES (?,?,?)',
                           (message_text, sender_id, convo_id))
    else:
        conversation = insert_query('INSERT INTO conversations(receiver) VALUES (?)', (receiver_id,))
        new_convo_id = read_query('SELECT id_of_conversations FROM conversations WHERE receiver = ?', (receiver_id,))
        message = insert_query('INSERT INTO messages (text_message, new_user_id_of_user, conversations_between_users_id_of_conversations) VALUES (?,?,?)',
                           (message_text, sender_id, new_convo_id[0][0]))
        participant_one_sender = insert_query('INSERT INTO conversations_between_new_users(user_id,convo_id) VALUES (?,?)',
                                   (sender_id, new_convo_id[0][0]))
        participant_two_receiver = insert_query('INSERT INTO conversations_between_new_users(user_id, convo_id) VALUES (?,?)',
                                   (receiver_id, new_convo_id[0][0]))

    return Response(status_code=200, content=f'You send your first message to {receiver_username} !')