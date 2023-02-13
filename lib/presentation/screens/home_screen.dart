import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc/bloc/cubit/edit_todo_cubit.dart';
import 'package:to_do_bloc/bloc/cubit/fatch_to_do_cubit.dart';
import 'package:to_do_bloc/presentation/screens/add_todo.dart';
import 'package:to_do_bloc/presentation/screens/edit_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  static const route = "/home_screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchToDoCubit>(context).fetchAllTodos();
    print("rebuild");
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddToDoScreen.route),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<FetchToDoCubit, FetchToDoState>(
        builder: (context, state) {
          print("first $state");
          if (state is FetchToDoFetched) {
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(state.result[index].id.toString()),
                  background: Container(
                    color: Colors.green,
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                  ),
                  child: InkWell(
                    child: ListTile(
                      title: Text(state.result[index].message),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      Navigator.of(context).pushNamed(EditTodoScreen.route , arguments: state.result[index]);
                      return false;
                    } else if (direction == DismissDirection.endToStart) {
                      BlocProvider.of<FetchToDoCubit>(context).deleteTodo(state.result[index].id);
                      return true;
                    }

                  },
                );
              },
            );
          } else if (state is FetchToDoError) {
            return Text(state.errorMsg);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
