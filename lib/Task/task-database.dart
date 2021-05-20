import 'package:flutter/widgets.dart';
import 'task.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TaskDataBaseHelper {
  static TaskDataBaseHelper _taskDatabaseHelper; //Singleton
  static Database _database; //singleton

  String taskTable = 'task_table';
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';
  String colstartTime = 'starttime';
  String colendTime = 'endtime';
  String colCompleted = 'completed';

  TaskDataBaseHelper._createInstance();

  factory TaskDataBaseHelper() {
    if (_taskDatabaseHelper == null) {
      debugPrint("null");
      _taskDatabaseHelper = TaskDataBaseHelper._createInstance();
    }
    return _taskDatabaseHelper;
  }

//custom getter
  Future<Database> get database async {
    if (_database == null) {
      debugPrint("------------------------------------");
      _database = await initalizeTaskDatabase();
    }
    return _database;
  }

//initialoize task database
  Future<Database> initalizeTaskDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'tasks.db';

    var tasksDatabase =
        await openDatabase(path, version: 1, onCreate: _createTaskDb);
    return tasksDatabase;
  }

  void _createTaskDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $taskTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT,$colstartTime TEXT,$colendTime TEXT,$colCompleted INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.database;
    //optional
    // var result = await db.rawQuery('SELECT * from $taskTable order by $colPriority ASC');
    var result = await db.query(taskTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertTask(Task task) async {
    debugPrint("insert");
    Database db = await this.database;
    var result = await db.insert(taskTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.database;
    var result = await db.update(taskTable, task.toMap(),
        where: '$colID = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $taskTable where $colID = $id');
    return result;
  }

  Future<int> getCount() async {
    debugPrint("get");
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $taskTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    var taskMapList = await getTaskMapList();

    int count = taskMapList.length;

    List<Task> taskList = List<Task>();
    for (int i = 0; i < count; i++) {
      taskList.add(Task.fromMapObject(taskMapList[i]));
    }
    return taskList;
  }
}
