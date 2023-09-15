// ignore_for_file: public_member_api_docs, sort_constructors_first
class Todo {
  Todo({
    required this.todoId,
    required this.content,
    required this.completed,
  });

  int todoId;
  String content;
  bool completed;
}
