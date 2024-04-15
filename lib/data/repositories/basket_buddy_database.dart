import 'package:basket_buddy/data/models/category.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';

import '../models/product.dart';
import '../models/user.dart';

class BasketBuddyDataBase {
  List<Category> categories = [];
  List<Product> products = [];
  List<ShoppingList> shoppingLists = [];
  late User user;

  BasketBuddyDataBase();
}
