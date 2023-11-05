import 'package:flutter/material.dart';

import 'db_helper/todo_db.dart';
import 'models/todomodel.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  bool important = false;
  final titleController = TextEditingController();
  final subtitleControler = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    subtitleControler.dispose();
    super.dispose();
  }
  void addTodo() async {
    ToDoModel todo = ToDoModel(
        title: titleController.text,
        describtion: subtitleControler.text,
        isImportant: important);
    await DatabaseRepository.instance.insert(todo: todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                  label: const Text('Todo title'),
                  hintText: 'Develop amazing app '),
            ),
            const SizedBox(
              height: 36,
            ),
            TextFormField(
              controller: subtitleControler,
              decoration: const InputDecoration(
                label: const Text('Todo subtitle'),
              ),
            ),
            SwitchListTile.adaptive(
              title: Text('is your todo really important'),
              value: important,
              onChanged: (value) => setState(
                    () {
                  important = value;
                },
              ),
            ),
            MaterialButton(
              color: Colors.greenAccent,
              height: 50,
              minWidth: double.infinity,
              onPressed: addTodo,
              child: const Text(
                'Add todo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}