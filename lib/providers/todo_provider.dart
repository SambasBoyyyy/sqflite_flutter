// import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db_helper/todo_db.dart';
import '../models/todomodel.dart';

class ToDoNotifier extends ChangeNotifier {
  /// Internal, private state of the cart.
  late List<ToDoModel> _todos;

  ToDoNotifier() {
    WidgetsFlutterBinding.ensureInitialized();
    _todos = [];
    initDb();
    getTodos();
  }



  void initDb() async {
    await DatabaseRepository.instance.database;
    notifyListeners();
  }

  /// The current total price of all items (assuming all items cost $42).
  // int get totalTodos => _todos.length;
  List<ToDoModel> get todos => _todos;

  void getTodos() async {
    List<ToDoModel> fetchedTodos = await DatabaseRepository.instance.getAllTodos();
    _todos.clear();
    _todos.addAll(fetchedTodos);
    notifyListeners();
  }
  void addTodo({required ToDoModel? todo_for_up,required String title, required String description, required bool isImportant,}) async {
  if(todo_for_up == null){
    ToDoModel todo = ToDoModel(
      title: title,
      describtion: description,
      isImportant: isImportant,
    );
    await DatabaseRepository.instance.insert(todo: todo);
  }
  else {
    ToDoModel todo_up = ToDoModel(
        id:todo_for_up.id,
      title: title,
      describtion: description,
      isImportant: isImportant,
    );
    await DatabaseRepository.instance.update(todo_up);
  }

    notifyListeners();
    getTodos();
  }
  void delete({required ToDoModel todo, required BuildContext context}) async {
    DatabaseRepository.instance.delete(todo.id!).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Deleted')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
    notifyListeners();
    getTodos();
  }






  // /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  // /// cart from the outside.
  // void add(Item item) {
  //   _items.add(item);
  //   // This call tells the widgets that are listening to this model to rebuild.
  //   notifyListeners();
  // }
  //
  // /// Removes all items from the cart.
  // void removeAll() {
  //   _items.clear();
  //   // This call tells the widgets that are listening to this model to rebuild.
  //   notifyListeners();
  // }
}