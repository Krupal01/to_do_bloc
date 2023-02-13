import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc/bloc/cubit/add_to_do_cubit.dart';

class AddToDoScreen extends StatelessWidget {
  static const route = "/add_todo_screen";
  final textEditingController = TextEditingController();

  AddToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add ToDo"),
      ),
      body: BlocConsumer<AddToDoCubit, AddToDoState>(
        builder: (BuildContext context, state) {
          return Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: "add message",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      BlocProvider.of<AddToDoCubit>(context)
                          .addTodo(textEditingController.text);
                    }
                  },
                  child: const Text("Submit"))
            ],
          );
        },
        listener: (context, state) {
          if (state is AddToDoAdded) {
            Navigator.of(context).pop();
            return;
          } else if (state is AddToDoError) {
            print(state.errorMsg);
          }
        },
      ),
    );
  }
}
