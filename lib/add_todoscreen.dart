import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_flutter/providers/todo_provider.dart';
import '../models/todomodel.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  ToDoModel? todo;
  AddTodoScreen({Key? key, this.todo}) : super(key: key);
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  bool important = false;
  @override
  void initState() {
    addTodoData();
    super.initState();
  }
  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  void addTodoData() {
    if (widget.todo != null) {
      if (mounted)
        setState(() {
          titleController.text = widget.todo!.title;
          subtitleController.text = widget.todo!.describtion;
          important = widget.todo!.isImportant;
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.todo == null ? Text('Add Todo'):Text("Update Todo"),
      ),
      body: Consumer<ToDoNotifier>(
        builder: (context, todoProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Todo title',
                    hintText: 'Develop amazing app',
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                TextFormField(
                  controller: subtitleController,
                  decoration: const InputDecoration(
                    labelText: 'Todo subtitle',
                  ),
                ),
                SwitchListTile.adaptive(
                  title: Text('Is your todo really important'),
                  value: important,
                  onChanged: (value) {
                    setState(() {
                      important = value;
                    });
                  },
                ),
                MaterialButton(
                  color: Colors.greenAccent,
                  height: 50,
                  minWidth: double.infinity,
                  onPressed: () {
                    todoProvider.addTodo(
                      todo_for_up: widget.todo,
                      title: titleController.text,
                      description: subtitleController.text,
                      isImportant: important,
                    );
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  child: widget.todo == null ? Text('Add Todo'):Text("Update Todo")
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}




