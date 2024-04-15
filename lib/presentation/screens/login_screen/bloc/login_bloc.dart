import 'dart:io';

import 'package:basket_buddy/data/models/user.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/enums.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BasketBuddyDataBase basketBuddyDataBase;

  LoginBloc(this.basketBuddyDataBase)
      : super(const LoginState(status: LoginStatus.idle, api: null)) {
    on<AuthenticateEvent>(_onAuthenticateEvent);
    on<ChangeStatusEvent>(_onChangeStatusEvent);
  }
  Future<void> _onAuthenticateEvent(
      AuthenticateEvent event, Emitter<LoginState> emit) async {
    BasketBuddyAPI basketBuddyAPI = BasketBuddyAPI();
    emit(state.copyWith(
      status: LoginStatus.loading,
    ));
    try {
      User user = await basketBuddyAPI.logIn(event.login, event.password);
      basketBuddyDataBase.user = user;
      emit(state.copyWith(status: LoginStatus.confirmed, api: basketBuddyAPI));
    } catch (e) {
      if (e is FormatException) {
        emit(state.copyWith(
            status: LoginStatus.errorPasses, api: basketBuddyAPI));
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
