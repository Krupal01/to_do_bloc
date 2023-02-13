import 'dart:convert';

List<ToDo> toDoFromJson(String str) =>
    List<ToDo>.from(json.decode(str).map((x) => ToDo.fromJson(x)));

String toDoToJson(List<ToDo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToDo {
  ToDo({
    required this.message,
    required this.isCompleted,
    required this.id,
  });

  String message;
  bool isCompleted;
  int id;

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        message: json["title"],
        isCompleted: json["completed"],
        id: json["id"],
      );

  factory ToDo.fromJsonString(String jsonText) =>
      ToDo.fromJson(json.decode(jsonText));

  // factory ToDo.from(String jsonText) {
  //   var jsonData = json.decode(jsonText).cast<Map<String, dynamic>>();
  //   return ToDo(
  //     message: jsonData["title"],
  //     isCompleted: jsonData["completed"],
  //     id: jsonData["id"],
  //   );
  // }

  Map<String, dynamic> toJson() => {
        "title": message,
        "completed": isCompleted,
        "id": id,
      };

  static String getNewTodoJson(String message1 ,bool isCompleted1) => jsonEncode({
        "title": message1,
        "completed": isCompleted1
      });

  void update(ToDo response) {
    message = response.message;
    isCompleted = response.isCompleted;
  }
}
