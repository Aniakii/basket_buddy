import 'package:basket_buddy/data/models/category.dart';

import '../models/product.dart';
import '../models/user.dart';

class BasketBuddyDataBase {
  List<Category> categories = [];
  List<Product> products = [];
  late User user;

  BasketBuddyDataBase();
}
