import 'package:flutter/widgets.dart';
import 'subTask.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SubTaskDataBaseHelper {
  static SubTaskDataBaseHelper _subtaskDatabaseHelper; //Singleton
  static Database _database; //singleton

  String subTaskTable = 'subtask_table';
  String colID = 'id';
  String colTaskId = 'taskId';
  String colName = 'name';
  // String colDone = 'done';
  SubTaskDataBaseHelper._createInstance();

  factory SubTaskDataBaseHelper() {
    if (_subtaskDatabaseHelper == null) {
      debugPrint("null");
      _subtaskDatabaseHelper = SubTaskDataBaseHelper._createInstance();
    }
    return _subtaskDatabaseHelper;
  }

//custom getter
  Future<Database> get database async {
    if (_database == null) {
      debugPrint("------------------------------------");
      _database = await initalizeSubTaskDatabase();
    }
    return _database;
  }

//initialoize task database
  Future<Database> initalizeSubTaskDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'subtasks.db';

    var tasksDatabase =
        await openDatabase(path, version: 1, onCreate: _createSubTaskDb);
    return tasksDatabase;
  }

//crud
  void _createSubTaskDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $subTaskTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $colTaskId INTEGER, $colName TEXT)');
  }

  Future<int> insertSubTask(SubTask subtask) async {
    debugPrint("insert");
    Database db = await this.database;
    var result = await db.insert(subTaskTable, subtask.toMap());
    return result;
  }

  Future<int> updateSubTask(SubTask subtask) async {
    Database db = await this.database;
    var result = await db.update(subTaskTable, subtask.toMap(),
        where: '$colID = ?', whereArgs: [subtask.id]);
    return result;
  }

  Future<int> deleteSubTask(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $subTaskTable where $colID = $id');
    return result;
  }

//queries
  Future<int> getCount() async {
    debugPrint("get");
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $subTaskTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Map<String, dynamic>>> getSubTaskMapList() async {
    Database db = await this.database;
    //optional
    // var result = await db.rawQuery('SELECT * from $taskTable order by $colPriority ASC');
    var result = await db.query(subTaskTable);
    return result;
  }

  Future<List<SubTask>> getSubTaskList() async {
    var subTaskMapList = await getSubTaskMapList();

    int count = subTaskMapList.length;

    List<SubTask> subtaskList = List<SubTask>();
    for (int i = 0; i < count; i++) {
      subtaskList.add(SubTask.fromMapObject(subTaskMapList[i]));
    }
    debugPrint(subtaskList.toString());
    return subtaskList;
  }

  Future<int> deleteAllSubTasksOfTask(int taskId) async {
    debugPrint("in Delete fun");
    Database db = await this.database;
    db.rawDelete('DELETE FROM $subTaskTable WHERE $colTaskId="$taskId"');
    debugPrint("Deleted.");
  }

  Future<List<Map<String, Object>>> getSubTasksMap(int taskID) async {
    //Future<List<Map<String, Object>>>
    debugPrint("in getHabitLogs");
    Database db = await this.database;
    debugPrint("before query");
    var result = await db
        .rawQuery('SELECT * from $subTaskTable WHERE $colTaskId="$taskID"');
    debugPrint('after query');
    debugPrint(result.toString());
    debugPrint('before return id value');
    debugPrint(result.toList().toString());
    debugPrint('wwwwwwww');
    return result.toList();
  }

  Future<List<SubTask>> getSubTasksList(int taskID) async {
    debugPrint("in");
    var subtaksList = await getSubTasksMap(taskID);
    debugPrint(subtaksList.toString());
    int count = subtaksList.length;
    List<SubTask> habitList = List<SubTask>();
    for (int i = 0; i < count; i++) {
      habitList.add(SubTask.fromMapObject(subtaksList[i]));
    }
    return habitList;
  }
}
