import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/enums.dart';

part 'all_lists_state.freezed.dart';

@freezed
class AllListsState with _$AllListsState {
  const factory AllListsState({
    required final AllListsStatus status,
    required final BasketBuddyAPI? api,
  }) = _AllListsState;
}
