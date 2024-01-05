class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: "01", todoText: "Morning exercise", isDone: true),
      ToDo(id: "02", todoText: "Go to the office", isDone: false),
      ToDo(id: "03", todoText: "Meeting with the team", isDone: true),
      ToDo(id: "04", todoText: "Lunch with the team", isDone: false),
      ToDo(id: "05", todoText: "Meeting with the client", isDone: false),
      ToDo(id: "06", todoText: "Meeting with the boss", isDone: false),
      ToDo(id: "07", todoText: "Go to the gym", isDone: false),
    ];
  }
}
