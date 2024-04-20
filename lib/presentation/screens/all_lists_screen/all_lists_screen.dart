import 'package:basket_buddy/constants/enums.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:basket_buddy/presentation/screens/add_list_screen/add_list_screen.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_bloc.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_event.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_state.dart';
import 'package:basket_buddy/presentation/widgets/all_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllListsScreen extends StatefulWidget {
  const AllListsScreen({super.key});

  static const id = 'all_lists_screen';

  @override
  State<AllListsScreen> createState() => _AllListsScreenState();
}

class _AllListsScreenState extends State<AllListsScreen> {
  final TextEditingController _addListController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AllListsBloc>().add(FetchDataEvent());
  }

  @override
  void dispose() {
    _addListController.dispose();
    super.dispose();
  }

  Widget _buildListsScaffold(BuildContext context, AllListsState state) {
    final basketBuddyDatabase =
        RepositoryProvider.of<BasketBuddyDataBase>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Basket Buddy"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: state.status == AllListsStatus.loading
            ? const CircularProgressIndicator()
            : state.status == AllListsStatus.empty
                ? const Text(
                    "You don't have any list, create one clicking the + button.",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : state.status == AllListsStatus.errorOther
                    ? const Text(
                        "Something went wrong :( Try again later.",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    : state.status == AllListsStatus.loaded
                        ? GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Column(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text("All lists:",
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: AllList(
                                    deleteFunction: (list) => {
                                      setState(() {
                                        context
                                            .read<AllListsBloc>()
                                            .add(DeleteListEvent(list));
                                      }),
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(
                            height: 10.0,
                          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed(AddListScreen.id,
              arguments: _addListController) as Map<String, dynamic>?;
          if (!context.mounted) return;
          if (result != null) {
            int id = 0;
            if (state.allLists.isNotEmpty) {
              id = state.allLists
                      .map((e) => e.id)
                      .reduce((curr, next) => curr > next ? curr : next) +
                  1;
            }
            ShoppingList newList = ShoppingList(
              id: id,
              name: result["name"],
              color: result["color"],
              emoji: result["emoji"],
              owner: basketBuddyDatabase.user.id,
            );
            context.read<AllListsBloc>().add(AddListEvent(newList));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllListsBloc, AllListsState>(
      builder: (BuildContext context, AllListsState state) {
        return _buildListsScaffold(context, state);
      },
    );
  }
}
