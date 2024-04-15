import 'package:basket_buddy/constants/enums.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/all_lists_screen.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_bloc.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_event.dart';
import 'package:basket_buddy/presentation/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:basket_buddy/presentation/screens/signup_screen/bloc/signup_event.dart';
import 'package:basket_buddy/presentation/screens/signup_screen/bloc/signup_state.dart';
import 'package:basket_buddy/presentation/widgets/error_alert.dart';
import 'package:basket_buddy/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _loginController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordRepeatController =
      TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    super.dispose();
  }

  Widget _buildSignupScaffold(BuildContext context, SignUpState state) {
    return Scaffold(
      appBar: AppBar(title: const Text("Basket Buddy")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                "Sign up:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              TextInput(
                  controller: _loginController,
                  labelText: 'Login',
                  obscureText: false),
              const SizedBox(height: 20.0),
              TextInput(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true),
              const SizedBox(height: 20.0),
              TextInput(
                  controller: _passwordRepeatController,
                  labelText: 'Repeat password',
                  obscureText: true),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String login = _loginController.text;
                  String password = _passwordController.text;
                  String passwordRepeated = _passwordRepeatController.text;
                  context.read<SignUpBloc>().add(RegisterEvent(
                      login: login,
                      password: password,
                      passwordRepeated: passwordRepeated));
                },
                child: const Text('Sign up'),
              ),
              const SizedBox(height: 20.0),
              if (state.status == SignUpStatus.loading)
                const CircularProgressIndicator(),
              if (state.status == SignUpStatus.errorPasswordMatch)
                const Text("Your password doesn't match repeated password",
                    style: TextStyle(color: Colors.red)),
              if (state.status == SignUpStatus.errorAccountExistsOrFormat)
                const Text(
                    "Account with this email already exists or your email is in wrong format.",
                    style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.confirmed) {
          context.read<AllListsBloc>().add(
                CreateInitialStateEvent(api: state.api ?? BasketBuddyAPI()),
              );
          Navigator.of(context).pushReplacementNamed(AllListsScreen.id);
        } else if (state.status == SignUpStatus.errorOffline) {
          getAlertError(
                  context,
                  "No internet connection",
                  "Please check your internet connection and try again.",
                  AlertType.warning)
              .show();
        } else if (state.status == SignUpStatus.errorOther) {
          getAlertError(
                  context,
                  "Unknown Error",
                  "An unknown error occurred. Please try again later.",
                  AlertType.error)
              .show();
        }
      },
      builder: (BuildContext context, SignUpState state) {
        return _buildSignupScaffold(context, state);
      },
    );
  }
}
