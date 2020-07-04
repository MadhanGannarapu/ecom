import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "todo";
final String columnId = "id";
final String columnName = "name";

class Task {
  final String name;
  int id;
  Task({this.name, this.id});
  Map<String, dynamic> toMap() {
    return {columnName: this.name, columnId: this.id};
  }
}

class TodoHelper {
  static final String databaseName = 'ecom.db';
  Database db;
  TodoHelper() {
    initDatabase();
  }
  Future<void> initDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), "ecom.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)");
      },
      version: 1,
    );
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
