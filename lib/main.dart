import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_api.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:basket_buddy/presentation/screens/add_item_screen/add_item_screen.dart';
import 'package:basket_buddy/presentation/screens/add_list_screen/add_list_screen.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/all_lists_screen.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_bloc.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/bloc/list_details_bloc.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/list_details_screen.dart';
import 'package:basket_buddy/presentation/screens/login_screen/bloc/login_bloc.dart';
import 'package:basket_buddy/presentation/screens/login_screen/login_screen.dart';
import 'package:basket_buddy/presentation/screens/modify_list_screen/modify_list_screen.dart';
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
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        case SignUpScreen.id:
          return MaterialPageRoute(builder: (context) => const SignUpScreen());
        case AllListsScreen.id:
          return MaterialPageRoute(
              builder: (context) => const AllListsScreen());
        case AddListScreen.id:
          return MaterialPageRoute(
              builder: (context) => AddListScreen(
                  nameController: settings.arguments as TextEditingController));
        case ModifyListScreen.id:
          final arguments = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ModifyListScreen(
              nameController:
                  arguments['nameController'] as TextEditingController,
              shoppingList: arguments['shoppingList'] as ShoppingList,
            ),
          );
        case ListDetailsScreen.id:
          return MaterialPageRoute(
              builder: (context) => const ListDetailsScreen());

        case AddItemScreen.id:
          return MaterialPageRoute(builder: (context) => const AddItemScreen());
        default:
          return MaterialPageRoute(builder: (context) => const LoginScreen());
      }
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BasketBuddyDataBase>(
          create: (context) => BasketBuddyDataBase(),
        ),
        RepositoryProvider<BasketBuddyAPI>(
          create: (context) => BasketBuddyAPI(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(context.read<BasketBuddyDataBase>(),
                context.read<BasketBuddyAPI>()),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(context.read<BasketBuddyDataBase>(),
                context.read<BasketBuddyAPI>()),
          ),
          BlocProvider<AllListsBloc>(
            create: (context) => AllListsBloc(
                context.read<BasketBuddyDataBase>(),
                context.read<BasketBuddyAPI>()),
          ),
          BlocProvider<ListDetailsBloc>(
            create: (context) =>
                ListDetailsBloc(context.read<BasketBuddyAPI>()),
          ),
        ],
        child: MaterialApp(
          title: "Basket Buddy",
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Colors.deepPurple,
              titleTextStyle: TextStyle(
                  //color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            colorScheme: const ColorScheme.light(),
          ),
          initialRoute: LoginScreen.id,
          onGenerateRoute: generateRoutes,
        ),
      ),
    );
  }
}
