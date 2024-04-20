import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_bloc.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_state.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/bloc/list_details_event.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/bloc/list_details_bloc.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/list_details_screen.dart';
import 'package:basket_buddy/presentation/widgets/shopping_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/shopping_list.dart';

class AllList extends StatefulWidget {
  const AllList({
    super.key,
    required this.deleteFunction,
  });

  final void Function(ShoppingList) deleteFunction;

  @override
  State<AllList> createState() => _AllListState();
}

class _AllListState extends State<AllList> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _listNameEdititng = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _listNameEdititng.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllListsBloc, AllListsState>(
        builder: (BuildContext context, AllListsState state) {
      return ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: state.allLists.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ShoppingListCard(
                positionNumber: index + 1,
                textEditingController: _listNameEdititng,
                presentedList: state.allLists[index],
                touchFunction: () {
                  context.read<ListDetailsBloc>().add(
                        CreateInitialStateEvent(
                            shoppingList: state.allLists[index]),
                      );
                  Navigator.pushNamed(
                    context,
                    ListDetailsScreen.id,
                  );
                },
                deleteFunction: () {
                  widget.deleteFunction(state.allLists[index]);
                },
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
                height: 0.0,
              ),
            ],
          );
        },
      );
    });
  }
}
