import 'package:basket_buddy/constants/enums.dart';
import 'package:basket_buddy/data/models/shopping_list_item.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/bloc/list_details_event.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/bloc/list_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDetailsBloc extends Bloc<ListDetailsEvent, ListDetailsState> {
  ListDetailsBloc(this._api)
      : super(const ListDetailsState(
            status: ListDetailsStatus.loading, shoppingList: null)) {
    on<CreateInitialStateEvent>(_createInitialState);
    on<AddItemEvent>(_onAddItemEvent);
    on<DeleteItemEvent>(_onDeleteItemEvent);
    on<ModifyItemEvent>(_onModifyItemEvent);
  }

  final BasketBuddyAPI _api;

  void _createInitialState(
      CreateInitialStateEvent event, Emitter<ListDetailsState> emit) {
    if (event.shoppingList.items.isEmpty) {
      emit(
        state.copyWith(
          status: ListDetailsStatus.empty,
          shoppingList: event.shoppingList,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        status: ListDetailsStatus.loaded,
        shoppingList: event.shoppingList,
      ),
    );
  }

  Future<void> _onAddItemEvent(
      AddItemEvent event, Emitter<ListDetailsState> emit) async {
    emit(state.copyWith(
      status: ListDetailsStatus.loading,
    ));
    try {
      await _api.addShoppingListItem(
          event.shoppingListItem, state.shoppingList!.id);
      state.shoppingList!.items.add(event.shoppingListItem);

      emit(state.copyWith(
          status: ListDetailsStatus.loaded, shoppingList: state.shoppingList!));
    } catch (e) {
      emit(
        state.copyWith(status: ListDetailsStatus.error),
      );
      return;
    }
  }

  Future<void> _onDeleteItemEvent(
      DeleteItemEvent event, Emitter<ListDetailsState> emit) async {
    try {
      if (!state.shoppingList!.items.contains(event.shoppingListItem)) {
        return;
      }
      state.shoppingList!.items.remove(event.shoppingListItem);
      await _api.deleteShoppingListItem(
          event.shoppingListItem.id, state.shoppingList!.id);

      if (state.shoppingList!.items.isEmpty) {
        emit(state.copyWith(status: ListDetailsStatus.empty));
        return;
      }
      emit(state.copyWith(status: ListDetailsStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          status: ListDetailsStatus.error,
        ),
      );
      rethrow;
    }
  }

  Future<void> _onModifyItemEvent(
      ModifyItemEvent event, Emitter<ListDetailsState> emit) async {
    try {
      if (!state.shoppingList!.items.contains(event.shoppingListItem)) {
        return;
      }
      ShoppingListItem shoppingListItem = state.shoppingList!.items
          .firstWhere((element) => element.id == event.shoppingListItem.id);

      shoppingListItem.isBought = !shoppingListItem.isBought;

      await _api.updateShoppingListItem(
          shoppingListItem, state.shoppingList!.id);

      emit(
        state.copyWith(
            status: ListDetailsStatus.loaded,
            shoppingList: state.shoppingList!),
      );
    } catch (e) {
      emit(state.copyWith(status: ListDetailsStatus.error));
      rethrow;
    }
  }
}
