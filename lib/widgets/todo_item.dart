import "package:flutter/material.dart";
import "../constants/colors.dart";
import "../model/todo.dart";

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteToDo;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onDeleteToDo,
    required this.onToDoChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.todoText!,
              style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            Text(
              _formatDate(todo.createdAt!),
              style: const TextStyle(
                fontSize: 10,
                color: tdGray,
              ),
            )
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteToDo(todo.createdAt);
            },
          ),
        ),
      ),
    );
  }

  String _formatDate(String milliseconds) {
    var now = DateTime.now().millisecondsSinceEpoch;
    var formattedDate = "";
    // si es hoy
    if (int.parse(milliseconds) > now - 86400000) {
      var date = DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
      formattedDate = "${date.hour}:${date.minute}";
    } else if (int.parse(milliseconds) > now - 172800000) {
      formattedDate = "Yesterday";
    } else if (int.parse(milliseconds) > now - 604800000) {
      var date = DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
      final daysOfWeek = {
        1: 'Monday',
        2: 'Tuesday',
        3: 'Wednesday',
        4: 'Thursday',
        5: 'Friday',
        6: 'Saturday',
        7: 'Sunday',
      };
      formattedDate = daysOfWeek[date.weekday] ?? '';
    } else {
      var date = DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
      formattedDate = "${date.day}/${date.month}/${date.year}";
    }

    return formattedDate;
  }
}
