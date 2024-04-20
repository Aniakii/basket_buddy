import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/enums.dart';

part 'all_lists_state.freezed.dart';

@freezed
class AllListsState with _$AllListsState {
  const factory AllListsState({
    required final AllListsStatus status,
    required List<ShoppingList> allLists,
  }) = _AllListsState;
}
