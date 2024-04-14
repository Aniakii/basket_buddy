import 'package:basket_buddy/data/models/category.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';

import '../models/product.dart';
import '../models/user.dart';

class BasketBuddyDataBase {

  late List<Category> categories;
  late List<Product> products;
  late List<ShoppingList> shoppingLists;
  late User user;

  BasketBuddyDataBase();
}