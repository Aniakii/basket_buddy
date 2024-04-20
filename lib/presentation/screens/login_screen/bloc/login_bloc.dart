import 'dart:io';

import 'package:basket_buddy/data/models/user.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/enums.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._basketBuddyDataBase, this._api)
      : super(const LoginState(status: LoginStatus.idle)) {
    on<AuthenticateEvent>(_onAuthenticateEvent);
    on<ChangeStatusEvent>(_onChangeStatusEvent);
  }

  final BasketBuddyDataBase _basketBuddyDataBase;
  final BasketBuddyAPI _api;

  Future<void> _onAuthenticateEvent(
      AuthenticateEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      status: LoginStatus.loading,
    ));
    try {
      User user = await _api.logIn(event.login, event.password);
      _basketBuddyDataBase.user = user;
      emit(state.copyWith(status: LoginStatus.confirmed));
    } catch (e) {
      if (e is FormatException) {
        emit(state.copyWith(status: LoginStatus.errorPasses));
      } else if (e is SocketException) {
        emit(state.copyWith(
          status: LoginStatus.errorOffline,
        ));
      } else {
        emit(state.copyWith(
          status: LoginStatus.errorOther,
        ));
      }
    }
  }

  void _onChangeStatusEvent(ChangeStatusEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      status: event.status,
    ));
  }
}
