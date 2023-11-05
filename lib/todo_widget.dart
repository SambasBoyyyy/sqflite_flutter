import 'package:flutter/material.dart';

import 'models/todomodel.dart';

class TodoWidget extends StatelessWidget {
  final ToDoModel todo;
  const TodoWidget({Key? key, required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListTile(
        trailing: todo.isImportant == true
            ? Icon(
          Icons.warning_amber,
          color: Colors.red,
        )
            : SizedBox(),
        title: Text(
          todo.title,
          style: const TextStyle(color: Colors.black87, fontSize: 12),
        ),
        subtitle: Text(
          todo.describtion,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1)),
    );
  }
}