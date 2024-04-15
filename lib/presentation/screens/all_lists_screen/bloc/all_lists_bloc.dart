import 'dart:io';
import 'package:basket_buddy/constants/enums.dart';
import 'package:basket_buddy/data/models/category.dart';
import 'package:basket_buddy/data/models/product.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_event.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllListsBloc extends Bloc<AllListsEvent, AllListsState> {
  final BasketBuddyDataBase basketBuddyDataBase;

  AllListsBloc(this.basketBuddyDataBase)
      : super(
            const AllListsState(status: AllListsStatus.errorOther, api: null)) {
    on<FetchDataEvent>(_onFetchDataEvent);
    on<CreateInitialStateEvent>(_createInitialState);
    on<AddListEvent>(_onAddListEvent);
    on<DeleteListEvent>(_onDeleteListEvent);
    on<AddItemEvent>(_onAddItemEvent);
    on<DeleteItemEvent>(_onDeleteItemEvent);
  }

  void _createInitialState(
      CreateInitialStateEvent event, Emitter<AllListsState> emit) {
    emit(
      state.copyWith(api: event.api),
    );
  }

  Future<void> _onFetchDataEvent(
      FetchDataEvent event, Emitter<AllListsState> emit) async {
    emit(state.copyWith(
      status: AllListsStatus.loading,
    ));
    try {
      if (state.api == null) {
        emit(
          state.copyWith(
            status: AllListsStatus.errorOther,
          ),
        );
        return;
      }
      List<Category> categories = await state.api!.getCategories();
      List<Product> products = await state.api!.getProducts();
      List<ShoppingList> shoppingLists = await state.api!.getShoppingLists();

      basketBuddyDataBase.categories = categories;
      basketBuddyDataBase.products = products;
      basketBuddyDataBase.shoppingLists = shoppingLists;

      if (shoppingLists.isEmpty) {
        emit(
          state.copyWith(status: AllListsStatus.empty, api: state.api!),
        );
        return;
      }
      emit(
        state.copyWith(status: AllListsStatus.loaded, api: state.api!),
      );
    } catch (e) {
      if (e is SocketException) {
        emit(
          state.copyWith(
            status: AllListsStatus.errorOffline,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AllListsStatus.errorOther,
          ),
        );
      }
    }
  }

  Future<void> _onAddListEvent(
      AddListEvent event, Emitter<AllListsState> emit) async {
    emit(state.copyWith(
      status: AllListsStatus.loading,
    ));
    try {
      state.api!.addShoppingList(event.shoppingList);
      basketBuddyDataBase.shoppingLists.add(event.shoppingList);
      emit(state.copyWith(status: AllListsStatus.loaded, api: state.api!));
    } catch (e) {
      emit(
        state.copyWith(
          status: AllListsStatus.errorOther,
        ),
      );
      return;
    }
  }

  Future<void> _onDeleteListEvent(
      DeleteListEvent event, Emitter<AllListsState> emit) async {
    emit(state.copyWith(
      status: AllListsStatus.loading,
    ));
    try {
      await state.api!.deleteShoppingList(event.shoppingList.id);
      basketBuddyDataBase.shoppingLists.remove(event.shoppingList);
      emit(state.copyWith(status: AllListsStatus.loaded, api: state.api!));
    } catch (e) {
      emit(
        state.copyWith(
          status: AllListsStatus.errorOther,
        ),
      );
      return;
    }
  }

  Future<void> _onAddItemEvent(
      AddItemEvent event, Emitter<AllListsState> emit) async {
    emit(state.copyWith(
      status: AllListsStatus.loading,
    ));
    try {
      state.api!.addShoppingListItem(event.shoppingListItem, event.listId);
      basketBuddyDataBase.shoppingLists
          .where((element) => element.id == event.listId)
          .first
          .items
          .add(event.shoppingListItem);
      emit(state.copyWith(status: AllListsStatus.loaded, api: state.api!));
    } catch (e) {
      emit(
        state.copyWith(
          status: AllListsStatus.errorOther,
        ),
      );
      return;
    }
  }

  Future<void> _onDeleteItemEvent(
      DeleteItemEvent event, Emitter<AllListsState> emit) async {
  
    try {
      await state.api!
          .deleteShoppingListItem(event.shoppingListItem.id, event.listId);
      basketBuddyDataBase.shoppingLists
          .where((element) => element.id == event.listId)
          .first
          .items
          .remove(event.shoppingListItem);
      emit(state.copyWith(status: AllListsStatus.loaded, api: state.api!));
    } catch (e) {
      rethrow;
    }
  }
}
