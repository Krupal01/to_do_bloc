part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}

class EditTodoLoading extends EditTodoState {}
class EditTodoUpdated extends EditTodoState {
  final ToDo result;

  EditTodoUpdated({required this.result});


}
class EditTodoError extends EditTodoState {
  final String errorMsg;

  EditTodoError({required this.errorMsg});
}

