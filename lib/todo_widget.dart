import 'package:flutter/material.dart';

import 'add_todoscreen.dart';
import 'models/todomodel.dart';

class TodoWidget extends StatelessWidget {
  final ToDoModel todo;
  final VoidCallback onDeletePressed;
  const TodoWidget({Key? key, required this.todo,required this.onDeletePressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddTodoScreen(
            todo: todo,
          );
        }));
        print(todo.id);
      },
      child: Container(
        padding: EdgeInsets.all(10),

        child: ListTile(
          leading: IconButton(
            onPressed: () { onDeletePressed();},
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
          trailing: todo.isImportant == true
              ? Icon(
            Icons.notification_important,
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
      ),
    );
  }
}