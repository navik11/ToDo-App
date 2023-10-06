import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/todo.dart';
import '../Constants/colors.dart';
import '../Widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todosList = ToDo.todoList();
  final _todoControler = TextEditingController();

  List<ToDo> finalTodoList = [];
  // This widget is the root of your application.

  @override
  void initState() {
    finalTodoList = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var focusNode = FocusNode();\
    return Scaffold(
      backgroundColor: mBgColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
            child: Column(
              children: [
                searchBar(),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "All ToDos",
                    style: TextStyle(
                        fontSize: 30,
                        color: mBlack,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    for (ToDo todos in finalTodoList)
                      ToDoItem(
                        toDo: todos,
                        onToDoChange: _handleTodoChange,
                        onTodoDelete: _deleteToDoItem,
                      ),
                  ],
                )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (event) {
                      if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                        _addItem(_todoControler.text.toString());
                      }
                    },
                    child: TextFormField(
                      controller: _todoControler,
                      decoration: const InputDecoration(
                        hintText: 'Add new items',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )),
                InkWell(
                  onTap: () {
                    _addItem(_todoControler.text.toString());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: mBlue,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          )
                        ]),
                    width: 55,
                    height: 55,
                    margin: const EdgeInsets.only(right: 15),
                    child: const Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _runfilter(String s) {
    List<ToDo> list = [];
    if (s.isEmpty) {
      list = todosList;
    } else {
      list = todosList
          .where((element) => element.todoText
              .toString()
              .toLowerCase()
              .contains(s.toLowerCase()))
          .toList();
    }
    setState(() {
      finalTodoList = list;
    });
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addItem(String text) {
    setState(() {
      todosList
          .add(ToDo(id: DateTime.now().millisecond.toString(), todoText: text));
    });
    _todoControler.clear();
  }

  Widget searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: const InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
            prefixIcon: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Icon(Icons.search),
            )),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: mBgColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: mBlack,
            size: 30,
          ),
          Container(
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
