class ToDo {
  String? createdAt;
  String? todoText;
  bool isDone;

  ToDo({
    required this.createdAt,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        createdAt: "1703056249095",
        todoText: "Morning exercise",
        isDone: true,
      ),
      ToDo(
        createdAt: "1704324249095",
        todoText: "Breakfast",
        isDone: true,
      ),
      ToDo(
        createdAt: "1704410689095",
        todoText: "Go to work",
        isDone: false,
      ),
    ];
  }
}
