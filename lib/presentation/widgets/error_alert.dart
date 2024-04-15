import 'package:basket_buddy/constants/enums.dart';
import 'package:basket_buddy/presentation/screens/login_screen/bloc/login_bloc.dart';
import 'package:basket_buddy/presentation/screens/login_screen/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert getAlertError(
    BuildContext context, String title, String desc, AlertType type) {
  return Alert(
      context: context,
      type: type,
      style: const AlertStyle(backgroundColor: Colors.white),
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<LoginBloc>()
                  .add(ChangeStatusEvent(LoginStatus.idle));
            })
      ]);
}
