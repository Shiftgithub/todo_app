class Todo {
  String id;
  String todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    required this.isDone,
  });

  static List<Todo> todoList() {
    return [
      // Todo(id: '01', todoText: 'Morning Excercise', isDone: true),
      // Todo(id: '02', todoText: 'Morning Excercise', isDone: true),
      // Todo(id: '03', todoText: 'Morning Excercise', isDone: false),
      // Todo(id: '04', todoText: 'Morning Excercise', isDone: false),
      // Todo(id: '05', todoText: 'Morning Excercise', isDone: false),
    ];
  }
}
