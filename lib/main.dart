import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_bloc.dart';
import 'package:basket_buddy/presentation/screens/login_screen/bloc/login_bloc.dart';
import 'package:basket_buddy/presentation/screens/login_screen/login_screen.dart';
import 'package:basket_buddy/presentation/screens/signup_screen/bloc/signup_bloc.dart';
import 'package:basket_buddy/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    Route<dynamic> generateRoutes(RouteSettings settings) {
      switch (settings.name) {
        case LoginScreen.id:
          return MaterialPageRoute(builder: (context) => LoginScreen());
        case SignUpScreen.id:
          return MaterialPageRoute(builder: (context) => SignUpScreen());
        default:
          return MaterialPageRoute(builder: (context) => LoginScreen());
      }
    }
   return RepositoryProvider<BasketBuddyDataBase>(
      create: (BuildContext context) => BasketBuddyDataBase(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(context.read<BasketBuddyDataBase>()),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(context.read<BasketBuddyDataBase>()),
          ),
          BlocProvider<AllListsBloc>(
            create: (context) => AllListsBloc(context.read<BasketBuddyDataBase>()),
          ),
        ],
        child: MaterialApp(
          onGenerateTitle: (context) => "Basket Buddy",
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Colors.lightBlue,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            colorScheme: const ColorScheme.dark(),
          ),
          initialRoute: LoginScreen.id,
          onGenerateRoute: generateRoutes,
        ),
      ),
    );
  }
}
