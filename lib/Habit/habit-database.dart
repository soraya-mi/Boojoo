import 'package:flutter/material.dart';
import 'habit.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HabitDataBaseHelper {
  static HabitDataBaseHelper _habitDatabaseHelper; //Singleton
  static Database _database; //singleton

  String habitTable = 'habit_table';
  String colID = 'id';
  String colTitle = 'title';
  String colStartDate = 'startDate';
  String colEndDate = 'endDate';
  String colPriority = 'priority';
  String colType = 'type';
  String colNumber = 'number';
  String colDescription = 'description';
  String colAlarm = 'Alarm';
  String colFinished = 'finished';
  String colCue = 'cue';
  String colDays = 'days';
  String colCategory = 'category';

  HabitDataBaseHelper._createInstance();

  factory HabitDataBaseHelper() {
    if (_habitDatabaseHelper == null) {
      _habitDatabaseHelper = HabitDataBaseHelper._createInstance();
    }
    return _habitDatabaseHelper;
  }

//custom getter
  Future<Database> get database async {
    if (_database == null) {
      debugPrint('nul');
      _database = await initalizeHabitDatabase();
    }
    return _database;
  }

  //initialoize habit database
  Future<Database> initalizeHabitDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'habits.db';

    var habitsDatabase =
        await openDatabase(path, version: 1, onCreate: _createHabitDb);
    return habitsDatabase;
  }

  void _createHabitDb(Database db, int newVersion) async {
    debugPrint('create*********');
    await db.execute(
        'CREATE TABLE $habitTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT, $colStartDate TEXT,$colEndDate TEXT,$colPriority INTEGER,$colNumber INTEGER,$colType INTEGER,$colDescription TEXT,$colAlarm INTEGER,$colFinished INTEGER,$colCue INTEGER,$colDays TEXT,$colCategory TEXT)');
  }

  Future<List<Map<String, dynamic>>> getHabitMapList() async {
    Database db = await this.database;
    //optional
    // var result = await db.rawQuery('SELECT * from $noteTable order by $colPriority ASC');
    var result = await db.query(habitTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertHabit(Habit habit) async {
    debugPrint("inset*********");
    Database db = await this.database;
    debugPrint("++++++++++++++++++++++++++++++");
    var result = await db.insert(habitTable, habit.toMap());
    debugPrint("---------------------------");
    return result;
  }

  Future<int> updateHabit(Habit habit) async {
    Database db = await this.database;
    var result = await db.update(habitTable, habit.toMap(),
        where: '$colID = ?', whereArgs: [habit.id]);
    return result;
  }

  Future<int> deleteHabit(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $habitTable where $colID = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $habitTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Habit>> getHabitList() async {
    var habitMapList = await getHabitMapList();

    int count = habitMapList.length;

    List<Habit> habitList = List<Habit>();
    for (int i = 0; i < count; i++) {
      habitList.add(Habit.fromMapObject(habitMapList[i]));
    }
    return habitList;
  }

  Future<List<Map<String, dynamic>>> getHabitListMapByCategory(
      String category) async {
    debugPrint('++++.....+++++');
    Database db = await this.database;
    debugPrint(category);
    // debugPrint(_database.);
    // var count = await _database.rawQuery(
    //     'SELECT  COUNT(*) FROM $habitTable WHERE $colCategory="$category"');
    // debugPrint(count[0].values.single.toString());
    // var num = count[0].values.single;
    var result = await _database.rawQuery(
        'SELECT *  FROM $habitTable WHERE $colCategory="$category"'); //$colCategory = $category
    // // debugPrint(result.toString());
    // List<Habit> habitList = List<Habit>();
    // // for (int i = 0; i < count; i++) {
    // //   List.add(Habit.fromMapObject(habitMapList[i]));
    // // }
    // // debugPrint(list[0].values.single.toString());
    // for (int i = 0; i < num; i++) {
    //   var habit = await Habit.fromMapObject(result[i]);
    //   habitList.add(habit);
    //   debugPrint(habitList[i].toString());
    //   // var h = result[i].values.iterator;
    //   // debugPrint(h.toString() + ' ' + h.toString());
    // }
    //
    // debugPrint(habitList.toString());
    // debugPrint("//////////////");
    return result;
  }

  Future<List<Habit>> getHabitByCategoryList(String category) async {
    debugPrint("in");
    var habitListbyCategory = await getHabitListMapByCategory(category);
    debugPrint(habitListbyCategory.toString());
    // var counter = await _database.rawQuery(
    //     'SELECT  COUNT(*) FROM $habitTable WHERE $colCategory="$category"');
    // debugPrint(counter[0].values.single.toString());
    // var num = counter[0].values.single;
    // var habitMapList = await getHabitMapList();

    int count = habitListbyCategory.length;

    List<Habit> habitList = List<Habit>();
    for (int i = 0; i < count; i++) {
      habitList.add(Habit.fromMapObject(habitListbyCategory[i]));
    }
    return habitList;
  }

  Future<List<Map<String, dynamic>>> getHabitListMapByPriority(
      int priority) async {
    debugPrint('++++.....+++++');
    Database db = await this.database;
    debugPrint(priority.toString());
    var result = await _database.rawQuery(
        'SELECT *  FROM $habitTable WHERE $colPriority="$priority"'); //$colCategory = $category
    // // debugPrint(result.toString());
    // List<Habit> habitList = List<Habit>();
    // // for (int i = 0; i < count; i++) {
    // //   List.add(Habit.fromMapObject(habitMapList[i]));
    // // }
    // // debugPrint(list[0].values.single.toString());
    // for (int i = 0; i < num; i++) {
    //   var habit = await Habit.fromMapObject(result[i]);
    //   habitList.add(habit);
    //   debugPrint(habitList[i].toString());
    //   // var h = result[i].values.iterator;
    //   // debugPrint(h.toString() + ' ' + h.toString());
    // }
    //
    // debugPrint(habitList.toString());
    // debugPrint("//////////////");
    return result;
  }

  Future<List<Habit>> getHabitByPriorityList(int priority) async {
    debugPrint("in");
    var habitListbyCategory = await getHabitListMapByPriority(priority);
    debugPrint(habitListbyCategory.toString());
    int count = habitListbyCategory.length;
    List<Habit> habitList = List<Habit>();
    for (int i = 0; i < count; i++) {
      habitList.add(Habit.fromMapObject(habitListbyCategory[i]));
    }
    return habitList;
  }
}
