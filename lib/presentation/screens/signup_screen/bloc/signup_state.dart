import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/enums.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';

part 'signup_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required SignUpStatus status,
    required BasketBuddyAPI? api,
  }) = _SignUpState;
}
