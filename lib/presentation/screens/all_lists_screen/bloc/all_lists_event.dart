import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/models/shopping_list_item.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';

abstract class AllListsEvent {}

class CreateInitialStateEvent extends AllListsEvent {
  final BasketBuddyAPI api;

  CreateInitialStateEvent({required this.api});
}

class FetchDataEvent extends AllListsEvent {}

class AddListEvent extends AllListsEvent {
  final ShoppingList shoppingList;

  AddListEvent(this.shoppingList);
}

class DeleteListEvent extends AllListsEvent {
  final ShoppingList shoppingList;

  DeleteListEvent(this.shoppingList);
}

class AddItemEvent extends AllListsEvent {
  final ShoppingListItem shoppingListItem;
  final int listId;

  AddItemEvent(this.shoppingListItem, this.listId);
}

class DeleteItemEvent extends AllListsEvent {
  final ShoppingListItem shoppingListItem;
  final int listId;

  DeleteItemEvent(this.shoppingListItem, this.listId);
}
