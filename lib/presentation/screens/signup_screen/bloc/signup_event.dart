import 'package:basket_buddy/constants/enums.dart';

abstract class SignUpEvent {}

class RegisterEvent extends SignUpEvent {
  final String login;
  final String password;
  final String passwordRepeated;

  RegisterEvent(
      {required this.login,
      required this.password,
      required this.passwordRepeated});
}

class ChangeStatusEvent extends SignUpEvent {
  final SignUpStatus status;

  ChangeStatusEvent(this.status);
}
