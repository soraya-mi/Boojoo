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
        'CREATE TABLE $habitTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT, $colStartDate TEXT,$colEndDate TEXT,$colPriority INTEGER,$colNumber INTEGER,$colType INTEGER,$colDescription TEXT,$colAlarm INTEGER,$colFinished INTEGER,$colCue INTEGER)');
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
}
