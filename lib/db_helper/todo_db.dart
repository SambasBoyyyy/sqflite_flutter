import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/todomodel.dart';
import 'app_const.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todo.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
create table ${AppConst.tableName} ( 
  ${AppConst.id} integer primary key autoincrement, 
  ${AppConst.title} text not null,
   ${AppConst.describtion} text not null,
  ${AppConst.isImportant} boolean not null)
''');
  }

  Future<void> insert({required ToDoModel todo}) async {
    try {
      final db = await database;
      db.insert(AppConst.tableName, todo.toMap());
      print("inserted");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<ToDoModel>> getAllTodos() async {
    final db = await instance.database;

    final result = await db.query(AppConst.tableName);

    return result.map((json) => ToDoModel.fromJson(json)).toList();
  }

}