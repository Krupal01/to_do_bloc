part of 'add_to_do_cubit.dart';

@immutable
abstract class AddToDoState {}

class AddToDoInitial extends AddToDoState {}

class AddToDoLoading extends AddToDoState {}

class AddToDoAdded extends AddToDoState {
  final ToDo todo;

  AddToDoAdded(this.todo);
}

class AddToDoError extends AddToDoState {
  final String errorMsg;
  AddToDoError(this.errorMsg);
}
