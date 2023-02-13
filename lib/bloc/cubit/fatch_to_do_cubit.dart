// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_bloc/data/model/todo.dart';
import 'package:to_do_bloc/data/network/repository.dart';

import 'add_to_do_cubit.dart';

part 'fatch_to_do_state.dart';

class FetchToDoCubit extends Cubit<FetchToDoState> {
  final TodoRepository todoRepository;
  final AddToDoCubit addToDoCubit;
  FetchToDoCubit({required this.todoRepository , required this.addToDoCubit}) : super(FetchToDoInitial()){
    addToDoCubit.stream.listen((event) {
      print(event);
      print(state);
      if(event is AddToDoAdded){
        addTodo(event.todo);
      }
    });
  }

  void fetchAllTodos() async {
    emit(FetchToDoLoading());
    try {
      List<ToDo> result = await todoRepository.getAllTodos();
      emit(FetchToDoFetched(result));
    } catch (e) {
      emit(FetchToDoError(e.toString()));
    }
  }

  void addTodo(ToDo response) {
    var currentState = state;
    if (currentState is FetchToDoFetched) {
      var todoList = currentState.result;
      todoList.add(response);
      emit(FetchToDoFetched(todoList));
    }
  }

  void updateTodo(ToDo response) {
    var currentState = state;
    if(currentState is FetchToDoFetched){
      var todoList = currentState.result;
      todoList.firstWhere((element) => element.id == response.id).update(response);
      emit(FetchToDoFetched(todoList));
    }
  }

  void deleteTodo(int id) async{
    try{
      await todoRepository.deleteTodo(id: id);
      var currentState = state;
      if(currentState is FetchToDoFetched){
        var todoList = currentState.result;
        todoList.removeWhere((element) => element.id == id);
        emit(FetchToDoFetched(todoList));
      }
    }catch(e){
      emit(FetchToDoError(e.toString()));
    }
  }
}
