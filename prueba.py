import requests

def prueba(res_dict):
    items = res_dict['items']

    is_answered = 0
    not_answered = 0

    min_views = items[0].get('view_count')
    question_id_views = items[0].get('question_id')
    link_views = items[0].get('link')
    title_views = items[0].get('title')

    min_date = items[0].get('creation_date')
    question_id_min_date = items[0].get('question_id')
    link_min_date = items[0].get('link')
    title_min_date = items[0].get('title')

    max_date = items[0].get('creation_date')
    question_id_max_date = items[0].get('question_id')
    link_max_date = items[0].get('link')
    title_max_date = items[0].get('title')

    max_reputation = items[0].get('owner').get('reputation')
    max_user_id = items[0].get('owner').get('user_id')
    max_display_name = items[0].get('owner').get('display_name')

    for item in items:
        # Numero de preguntas contestadas
        if item.get('is_answered'):
            is_answered += 1
        else:
            not_answered += 1
        
        # Pregunta con menor visitas
        view_count = item.get('view_count')
        if view_count < min_views:
            min_views = view_count
            question_id_views = item.get('question_id')
            link_views = item.get('link')
            title_views = item.get('title')
        
        # Pregunta con mas tiempo y menos tiempo
        creation_date = item.get('creation_date')
        if creation_date < min_date:
            min_date = creation_date
            question_id_min_date = item.get('question_id')
            link_min_date = item.get('link')
            title_min_date = item.get('title')

        if creation_date > max_date:
            max_date = creation_date
            question_id_max_date = item.get('question_id')
            link_max_date = item.get('link')
            title_max_date = item.get('title')
        
        # Owner con mayor reputacion
        reputation = item.get('owner').get('reputation')
        if max_reputation < reputation:
            max_reputation = reputation
            max_user_id = item.get('owner').get('user_id')
            max_display_name = item.get('owner').get('display_name')
        

    print("Preguntas contestadas: {}".format(is_answered))
    print("Preguntas no contestadas: {}".format(not_answered))
    print("Pregunta con menos visitas => id: {} title: {}".format(question_id_views, title_views))
    print("Pregunta mas vieja => id: {} title: {}".format(question_id_min_date, title_min_date))
    print("Pregunta mas actual => id: {} title: {}".format(question_id_max_date, title_max_date))
    print("Owner con mas reputacion => id: {} nombre: {}".format(max_user_id, max_display_name))

if __name__ == '__main__':
    try:
        response = requests.get("https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow")
        if response.status_code == 200:
            res_dict = response.json()
            prueba(res_dict)
        else:
            print("Error: " + response.status)
    except:
        print("Error")