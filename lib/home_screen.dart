import 'package:flutter/material.dart';
import 'package:sqflite_flutter/todo_widget.dart';

import 'add_todoscreen.dart';
import 'db_helper/todo_db.dart';
import 'models/todomodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDoModel> myTodos = [];
  void initDb() async {
    await DatabaseRepository.instance.database;
  }
  @override
  void initState() {
    initDb();
    getTodos();
    super.initState();
  }

  void getTodos() async {
    await DatabaseRepository.instance.getAllTodos().then((value) {
      setState(() {
        myTodos = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: ()async { getTodos(); },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context ,
              MaterialPageRoute(
                  builder: (context) =>
                      AddTodoScreen()));
        },
      ),
        appBar: AppBar(
          title: const Text('My todos',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
        ),
        body: myTodos.isEmpty
            ? const Center(child: const Text('You don\'t have any todos yet'))
            : ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final todo = myTodos[index];
            return TodoWidget(todo: todo);
          },
          itemCount: myTodos.length,
        ),
      ),
    );
  }
}