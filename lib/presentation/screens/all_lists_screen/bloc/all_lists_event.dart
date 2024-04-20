import 'package:basket_buddy/data/models/shopping_list.dart';

abstract class AllListsEvent {}

class FetchDataEvent extends AllListsEvent {}

class AddListEvent extends AllListsEvent {
  final ShoppingList shoppingList;

  AddListEvent(this.shoppingList);
}

class DeleteListEvent extends AllListsEvent {
  final ShoppingList shoppingList;

  DeleteListEvent(this.shoppingList);
}

class ModifyListEvent extends AllListsEvent {
  final ShoppingList shoppingList;

  ModifyListEvent(this.shoppingList);
}
