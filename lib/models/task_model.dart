import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "todo";
final String columnId = "id";
final String columnName = "name";

class Task {
  String name;
  int id;
  Task({this.name, this.id});
  Map<String, dynamic> toMap() {
    return {columnName: this.name, columnId: this.id};
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
  }
}

class TodoHelper {
  static final String databaseName = 'ecom.db';
  Database db;
  TodoHelper() {
    initDatabase();
  }
  Future<void> initDatabase() async {
    print("\n\ndb initilized\n\n");
    db = await openDatabase(
      join(await getDatabasesPath(), "ecom.db"),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)");
      },
      version: 1,
    );
    await loadDataFromFile(db);
    // return db;
  }

  loadDataFromFile(Database db) async {
    print("\n\n loading data from file\n\n");
    Batch batch = db.batch();
    String loadTasks = await rootBundle.loadString("assets/tasks.json");
    List tasksList = json.decode(loadTasks);
    print(tasksList);
    tasksList.forEach((val) {
      Task task = Task.fromMap(val);
      batch.insert("todo", task.toMap());
    });
     var results = await batch.commit();
  }

  Future<void> insertTask(Task task) async {
    try {
      db.insert(tableName, task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      // print(_);
    }
  }

  Future<List<Task>> getAllTasks() async {
    final List<Map<String, dynamic>> tasks = await db.query(tableName);
    return List.generate(tasks.length, (index) {
      return Task(
        name: tasks[index][columnName],
        id: tasks[index][columnId],
      );
    });
  }
}
