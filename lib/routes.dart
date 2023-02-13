import 'package:flutter/material.dart';
import 'package:to_do_bloc/bloc/cubit/add_to_do_cubit.dart';
import 'package:to_do_bloc/data/network/api_interface.dart';
import 'package:to_do_bloc/data/network/repository.dart';
import 'package:to_do_bloc/presentation/screens/add_todo.dart';
import 'package:to_do_bloc/presentation/screens/edit_todo_screen.dart';
import 'package:to_do_bloc/presentation/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cubit/edit_todo_cubit.dart';
import 'bloc/cubit/fatch_to_do_cubit.dart';
import 'data/model/todo.dart';

class Routes {
  late final TodoRepository todoRepository;
  late final FetchToDoCubit fetchToDoCubit;
  late final AddToDoCubit addToDoCubit;
  late final EditTodoCubit editTodoCubit;

  Routes() {
    todoRepository =  TodoRepository(apiInterface: ApiInterface());
    addToDoCubit = AddToDoCubit(todoRepository: todoRepository);
    fetchToDoCubit = FetchToDoCubit(todoRepository: todoRepository,addToDoCubit: addToDoCubit);
    editTodoCubit = EditTodoCubit(todoRepository: todoRepository,fetchToDoCubit: fetchToDoCubit);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: fetchToDoCubit,
            child: HomeScreen(),
          ),
        );

      case AddToDoScreen.route:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: addToDoCubit,
            child: AddToDoScreen(),
          ),
        );
      case EditTodoScreen.route:
        return MaterialPageRoute(builder: (context)=>BlocProvider.value(
          value: editTodoCubit,
          child: EditTodoScreen(currentTodo: settings.arguments as ToDo),
        ),);
    }
    return null;
  }
}
