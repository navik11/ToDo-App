import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  final onToDoChange;
  final onTodoDelete;

  const ToDoItem(
      {Key? key,
      required this.toDo,
      required this.onToDoChange,
      required this.onTodoDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.topLeft,
      child: ListTile(
        onTap: () => onToDoChange(toDo),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          toDo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: mBlue,
        ),
        title: Text(
          toDo.todoText.toString(),
          style: TextStyle(
              fontSize: 16,
              color: mBlack,
              decoration: toDo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: mRed, borderRadius: BorderRadius.circular(6)),
          child: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            iconSize: 18,
            onPressed: () => onTodoDelete(toDo.id),
          ),
        ),
      ),
    );
  }
}
