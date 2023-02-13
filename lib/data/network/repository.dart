// ignore_for_file: avoid_print

import 'package:to_do_bloc/data/model/todo.dart';
import 'package:to_do_bloc/data/network/api_interface.dart';

class TodoRepository {
  final ApiInterface apiInterface;

  TodoRepository({required this.apiInterface});

  Future<List<ToDo>> getAllTodos() async {
    try {
      var response = await apiInterface.getAllTodos();
      return toDoFromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<ToDo> addTodo(
      {required bool isCompleted, required String message}) async {
    try {
      var response = await apiInterface.addTodo(
          message: message, isCompleted: isCompleted);
      var responseTodo = ToDo.fromJsonString(response);
      return responseTodo;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<ToDo> updateTodo(
      {required int id , required bool isCompleted, required String message}) async {
    try {
      var response = await apiInterface.updateTodo(id: id,
          message: message, isCompleted: isCompleted);
      var responseTodo = ToDo.fromJsonString(response);
      return responseTodo;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> deleteTodo(
      {required int id}) async {
    try {
      await apiInterface.deleteTodo(id : id);
    } catch (e) {
      throw (e.toString());
    }
  }
}
