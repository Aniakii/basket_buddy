import 'package:basket_buddy/constants/enums.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/all_lists_screen.dart';
import 'package:basket_buddy/presentation/screens/login_screen/bloc/login_bloc.dart';
import 'package:basket_buddy/presentation/screens/login_screen/bloc/login_event.dart';
import 'package:basket_buddy/presentation/screens/login_screen/bloc/login_state.dart';
import 'package:basket_buddy/presentation/screens/signup_screen/signup_screen.dart';
import 'package:basket_buddy/presentation/widgets/error_alert.dart';
import 'package:basket_buddy/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLoginScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: AppBar(title: const Text("Basket Buddy")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                "Log in to your account:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              TextInput(
                  controller: _loginController,
                  labelText: "Login",
                  obscureText: false),
              const SizedBox(height: 20.0),
              TextInput(
                  controller: _passwordController,
                  labelText: "Password",
                  obscureText: true),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text("Don't have account yet? "),
                  GestureDetector(
                      child: const Text(
                        "Click here.",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(SignUpScreen.id);
                      }),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String login = _loginController.text;
                  String password = _passwordController.text;
                  context
                      .read<LoginBloc>()
                      .add(AuthenticateEvent(login: login, password: password));
                },
                child: const Text('Log in'),
              ),
              const SizedBox(height: 20.0),
              if (state.status == LoginStatus.loading)
                const Center(child: CircularProgressIndicator()),
              if (state.status == LoginStatus.errorPasses)
                const Text("Your login or password is wrong.",
                    style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.confirmed) {
          Navigator.of(context).pushReplacementNamed(AllListsScreen.id);
        } else if (state.status == LoginStatus.errorOffline) {
          getAlertError(
                  context,
                  "No internet connection",
                  "Please check your internet connection and try again.",
                  AlertType.warning)
              .show();
        } else if (state.status == LoginStatus.errorOther) {
          getAlertError(
                  context,
                  "Unknown Error",
                  "An unknown error occurred. Please try again later.",
                  AlertType.error)
              .show();
        }
      },
      builder: (BuildContext context, LoginState state) {
        return _buildLoginScaffold(context, state);
      },
    );
  }
}
