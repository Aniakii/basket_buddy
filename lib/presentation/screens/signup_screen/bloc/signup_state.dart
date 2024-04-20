import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../constants/enums.dart';

part 'signup_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required SignUpStatus status,
  }) = _SignUpState;
}
