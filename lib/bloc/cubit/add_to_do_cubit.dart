import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_bloc/bloc/cubit/fatch_to_do_cubit.dart';
import 'package:to_do_bloc/data/model/todo.dart';
import 'package:to_do_bloc/data/network/repository.dart';

part 'add_to_do_state.dart';

class AddToDoCubit extends Cubit<AddToDoState> {
  final TodoRepository todoRepository;

  AddToDoCubit({required this.todoRepository})
      : super(AddToDoInitial());

  void addTodo(String msg) async {
    emit(AddToDoLoading());
    try {
      await todoRepository
          .addTodo(message: msg, isCompleted: false)
          .then((value) {
        emit(AddToDoAdded(value));
      });
    } catch (e) {
      emit(AddToDoError(e.toString()));
    }
  }
}
