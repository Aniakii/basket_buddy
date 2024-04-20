import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/models/shopping_list_item.dart';

abstract class ListDetailsEvent {
  const ListDetailsEvent();
}

class CreateInitialStateEvent extends ListDetailsEvent {
  final ShoppingList shoppingList;

  const CreateInitialStateEvent({required this.shoppingList});
}

class AddItemEvent extends ListDetailsEvent {
  final ShoppingListItem shoppingListItem;

  const AddItemEvent(this.shoppingListItem);
}

class DeleteItemEvent extends ListDetailsEvent {
  final ShoppingListItem shoppingListItem;

  const DeleteItemEvent(this.shoppingListItem);
}

class ModifyItemEvent extends ListDetailsEvent {
  final ShoppingListItem shoppingListItem;

  const ModifyItemEvent(this.shoppingListItem);
}
