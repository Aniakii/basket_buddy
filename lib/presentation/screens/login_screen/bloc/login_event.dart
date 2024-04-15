import 'package:basket_buddy/constants/enums.dart';

abstract class LoginEvent {}

class AuthenticateEvent extends LoginEvent {
  final String login;
  final String password;

  AuthenticateEvent({required this.login, required this.password});
}

class ChangeStatusEvent extends LoginEvent {
  final LoginStatus status;

  ChangeStatusEvent(this.status);
}
