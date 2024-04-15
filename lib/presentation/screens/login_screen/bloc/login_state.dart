import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/enums.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState(
      {required final LoginStatus status,
      required BasketBuddyAPI? api}) = _LoginState;
}
