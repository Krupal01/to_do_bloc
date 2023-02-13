// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:to_do_bloc/data/model/todo.dart';

class ApiInterface {
  // ignore: non_constant_identifier_names

  final BASE_URL = "https://jsonplaceholder.typicode.com/todos";

  Future<String> getAllTodos() async {
    var response =
        await http.get(Uri.parse("$BASE_URL?userId=10")).timeout(const Duration(seconds: 5));
    print(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw (response.statusCode);
    }
  }

  Future<String> addTodo({required String message, required bool isCompleted}) async {
    var response = await http
        .post(Uri.parse("$BASE_URL?userId=10"),headers : {"Content-Type": "application/json"} , body: ToDo.getNewTodoJson(message, isCompleted))
        .timeout(const Duration(seconds: 5));
    print("==>${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw (response.statusCode);
    }
  }

  Future<String> updateTodo({required int id , required String message, required bool isCompleted}) async {
    var response = await http
        .patch(Uri.parse("$BASE_URL/$id"),headers : {"Content-Type": "application/json"} , body: ToDo.getNewTodoJson(message, isCompleted))
        .timeout(const Duration(seconds: 5));
    print("==>${response.statusCode}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw (response.statusCode);
    }
  }

  Future<void> deleteTodo({required int id}) async {
    var response = await http
        .delete(Uri.parse("$BASE_URL/$id"))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {

    } else {
      throw (response.statusCode);
    }
  }
}
