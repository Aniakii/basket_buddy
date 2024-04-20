import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/enums.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required final LoginStatus status,
  }) = _LoginState;
}
