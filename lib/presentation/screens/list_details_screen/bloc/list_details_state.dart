import 'package:basket_buddy/constants/enums.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_details_state.freezed.dart';

@freezed
class ListDetailsState with _$ListDetailsState {
  const factory ListDetailsState({
    required final ListDetailsStatus status,
    required final ShoppingList? shoppingList,
  }) = _ListDetailsState;
}
