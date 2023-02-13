part of 'fatch_to_do_cubit.dart';

@immutable
abstract class FetchToDoState {}

class FetchToDoInitial extends FetchToDoState {}

class FetchToDoLoading extends FetchToDoState {}

class FetchToDoFetched extends FetchToDoState {
  final List<ToDo> result;
  FetchToDoFetched(this.result);
}

class FetchToDoError extends FetchToDoState {
  final String errorMsg;

  FetchToDoError(this.errorMsg);

}
