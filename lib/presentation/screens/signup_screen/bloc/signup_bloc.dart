import 'dart:io';
import 'package:basket_buddy/data/models/user.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/enums.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._basketBuddyDataBase, this._api)
      : super(const SignUpState(status: SignUpStatus.idle)) {
    on<RegisterEvent>(_onRegisterEvent);
    on<ChangeStatusEvent>(_onChangeStatusEvent);
  }

  final BasketBuddyDataBase _basketBuddyDataBase;
  final BasketBuddyAPI _api;

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(
      status: SignUpStatus.loading,
    ));

    if (event.password != event.passwordRepeated) {
      emit(state.copyWith(
        status: SignUpStatus.errorPasswordMatch,
      ));
      return;
    }

    try {
      User user = await _api.signUp(event.login, event.password);
      _basketBuddyDataBase.user = user;
      emit(state.copyWith(status: SignUpStatus.confirmed));
    } catch (e) {
      if (e is SocketException) {
        emit(state.copyWith(
          status: SignUpStatus.errorOffline,
        ));
      } else if (e is FormatException) {
        emit(state.copyWith(
          status: SignUpStatus.errorAccountExistsOrFormat,
        ));
      } else {
        emit(state.copyWith(
          status: SignUpStatus.errorOther,
        ));
      }
    }
  }

  void _onChangeStatusEvent(
      ChangeStatusEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      status: event.status,
    ));
  }
}
