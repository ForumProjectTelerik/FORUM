from unittest import TestCase
from unittest.mock import Mock, patch
from my_models. model_category import Category
from services import category_service


class CategoryService_Should(TestCase):


    def test_all_categories_returns_all_categories(self):
        with patch('services.category_service.read_query') as mock_db:
            mock_db.return_value = [
                ("new category 1",),
                ("new category 2",),
                ("new category 3",)
            ]
            result = list(category_service.all_categories())
            expected = [Category(name='new category 1'),
                        Category(name='new category 2'),
                        Category(name='new category 3')]
            self.assertEqual(expected, result)



    def test_category_exists_return_false_when_category_not_exist(self):
        # patch подменя read_query, за да предотвратява реалния достъп до БД
        # създава (mock) обект, който заменя истинския read_query.
        with patch('services.category_service.read_query') as read_query:
            # какво очаквам БД да върне
            read_query.return_value = []
            result = category_service.category_exists('Category')
            self.assertFalse(result)


    def test_category_exists_return_true_when_category_exist(self):
        with patch('services.category_service.read_query') as read_query:
            read_query.return_value = [('Fitness',)]
            result = category_service.category_exists('Fitness')
            self.assertTrue(result)


