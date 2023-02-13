import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc/bloc/cubit/edit_todo_cubit.dart';
import 'package:to_do_bloc/bloc/cubit/edit_todo_cubit.dart';

import '../../data/model/todo.dart';

class EditTodoScreen extends StatelessWidget {
  static const route = "edit_todo_screen";
  final ToDo currentTodo;
  final TextEditingController textEditingController = TextEditingController();

  EditTodoScreen({Key? key , required this.currentTodo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textEditingController.text = currentTodo.message;
    return Scaffold(
      appBar: AppBar(title: const Text("Edit todo"),),
      body: BlocListener<EditTodoCubit, EditTodoState>(
        listener: (context, state) {
          if(state is EditTodoUpdated){
            Navigator.of(context).pop(context);
            return;
          }else if(state is EditTodoError){
            print(state.errorMsg);
          }
        },
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(hintText: "edit message"),
            ),
            ElevatedButton(onPressed: () {
              BlocProvider.of<EditTodoCubit>(context).updateTodo(msg: textEditingController.text , id: currentTodo.id);
            }, child: const Text("update"),)
          ],
        ),
      ),
    );
  }
}
