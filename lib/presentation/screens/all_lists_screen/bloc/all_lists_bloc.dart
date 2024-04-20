import 'dart:io';
import 'package:basket_buddy/constants/enums.dart';
import 'package:basket_buddy/data/models/category.dart';
import 'package:basket_buddy/data/models/product.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_event.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllListsBloc extends Bloc<AllListsEvent, AllListsState> {
  AllListsBloc(this._basketBuddyDataBase, this._api)
      : super(
            const AllListsState(status: AllListsStatus.loading, allLists: [])) {
    on<FetchDataEvent>(_onFetchDataEvent);
    on<AddListEvent>(_onAddListEvent);
    on<DeleteListEvent>(_onDeleteListEvent);
    on<ModifyListEvent>(_onModifyListEvent);
  }

  final BasketBuddyDataBase _basketBuddyDataBase;
  final BasketBuddyAPI _api;

  Future<void> _onFetchDataEvent(
      FetchDataEvent event, Emitter<AllListsState> emit) async {
    emit(state.copyWith(
      status: AllListsStatus.loading,
    ));
    try {
      if (_api.authToken == null) {
        emit(
          state.copyWith(
            status: AllListsStatus.errorOther,
          ),
        );
        return;
      }
      List<Category> categories = await _api.getCategories();
      List<Product> products = await _api.getProducts();
      List<ShoppingList> shoppingLists = await _api.getShoppingLists();

      _basketBuddyDataBase.categories = categories;
      _basketBuddyDataBase.products = products;

      if (shoppingLists.isEmpty) {
        emit(
          state.copyWith(
            status: AllListsStatus.empty,
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          status: AllListsStatus.loaded,
          allLists: shoppingLists,
        ),
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
      await _api.addShoppingList(event.shoppingList);
      List<ShoppingList> updatedList = await _api.getShoppingLists();

      emit(state.copyWith(
        status: AllListsStatus.loaded,
        allLists: updatedList,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: AllListsStatus.errorOther,
        ),
      );
      return;
    }
  }

  Future<void> _onModifyListEvent(
      ModifyListEvent event, Emitter<AllListsState> emit) async {
    emit(state.copyWith(
      status: AllListsStatus.loading,
    ));
    try {
      await _api.updateShoppingList(event.shoppingList);
      List<ShoppingList> updatedList = await _api.getShoppingLists();

      emit(state.copyWith(
        status: AllListsStatus.loaded,
        allLists: updatedList,
      ));
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
      await _api.deleteShoppingList(event.shoppingList.id);
      List<ShoppingList> updatedList = await _api.getShoppingLists();
      if (updatedList.isEmpty) {
        emit(state.copyWith(status: AllListsStatus.empty, allLists: []));
      } else {
        emit(state.copyWith(
            status: AllListsStatus.loaded, allLists: updatedList));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AllListsStatus.errorOther,
        ),
      );
      return;
    }
  }
}
