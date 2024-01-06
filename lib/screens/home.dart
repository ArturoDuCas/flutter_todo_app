import "package:flutter/material.dart";
import "../constants/colors.dart";
import "../model/todo.dart";
import "../widgets/todo_item.dart";

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  var _selectedSort = 1;

  @override
  void initState() {
    todosList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                          left: 10,
                          right: 20,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "All ToDos",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            DropdownButton(
                              items: const [
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "Recent",
                                    style: TextStyle(color: tdGray),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text(
                                    "Older",
                                    style: TextStyle(color: tdGray),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 3,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(color: tdGray),
                                  ),
                                ),
                              ],
                              value: _selectedSort,
                              onChanged: dropDownCallback,
                              icon: Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: const Icon(Icons.sort)),
                              underline: Container(),
                              iconEnabledColor: tdGray,
                            )
                          ],
                        ),
                      ),
                      for (ToDo todoo in _foundToDo)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteToDo: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: "Add a new todo item",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text("+",
                        style: TextStyle(fontSize: 40, color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String createdAt) {
    setState(() {
      todosList.removeWhere((item) => item.createdAt == createdAt);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.insert(
          0,
          ToDo(
            createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: toDo,
          ));
    });

    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  void dropDownCallback(int? val) {
    setState(() {
      _selectedSort = val!;
      if (val == 1) {
        // Recent
        todosList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      } else if (val == 2) {
        // Older
        todosList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      } else if (val == 3) {
        // Name
        todosList.sort((a, b) => a.todoText!.compareTo(b.todoText!));
      }
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(
            color: tdGray,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/avatar.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
