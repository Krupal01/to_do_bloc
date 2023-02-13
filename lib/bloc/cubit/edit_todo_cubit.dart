import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_bloc/data/model/todo.dart';

import '../../data/network/repository.dart';
import 'fatch_to_do_cubit.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final TodoRepository todoRepository;
  final FetchToDoCubit fetchToDoCubit;

  EditTodoCubit({required this.todoRepository, required this.fetchToDoCubit}) : super(EditTodoInitial());

  void updateTodo({required String msg , required int id}) async {
    emit(EditTodoLoading());
    try{
      var response = await todoRepository.updateTodo(id : id , isCompleted: false, message: msg);
      fetchToDoCubit.updateTodo(response);
      emit(EditTodoUpdated(result: response));
    }catch(e){
      emit(EditTodoError(errorMsg: e.toString()));
    }
  }
}
