import 'package:flutter/material.dart';
import 'habitDays.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../Habit/habit-database.dart';

class HabitDaysDataBaseHelper {
  static HabitDaysDataBaseHelper _habitdaysDatabaseHelper; //Singleton
  static Database _database; //singleton

  String habitdaysTable = 'habitdays_table';
  String colhabitID = 'habitID';
  String colID = 'id';
  String colsaturday = 'saturday';
  String colsunday = 'sunday';
  String colmonday = 'monday';
  String coltuesday = 'tuesday';
  String colwednesday = 'wednesday';
  String colthursday = 'thursday';
  String colfriday = 'friday';

  HabitDaysDataBaseHelper._createInstance();

  factory HabitDaysDataBaseHelper() {
    if (_habitdaysDatabaseHelper == null) {
      _habitdaysDatabaseHelper = HabitDaysDataBaseHelper._createInstance();
    }
    return _habitdaysDatabaseHelper;
  }

//custom getter
  Future<Database> get database async {
    if (_database == null) {
      debugPrint('nul');
      _database = await initalizeHabitDaysDatabase();
    }
    return _database;
  }

  // get habitTable => habitTable;

  //initialoize habitdays database
  Future<Database> initalizeHabitDaysDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'habitsdays.db';

    var habitsDatabase =
        await openDatabase(path, version: 1, onCreate: _createHabitDb);
    return habitsDatabase;
  }

  void _createHabitDb(Database db, int newVersion) async {
    debugPrint('create*********');
    //add foregin key later
    await db.execute(
        'CREATE TABLE $habitdaysTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,$colhabitID INTEGER NOT NULL,$colsaturday INTEGER, $colsunday INTEGER,$colmonday INTEGER,$coltuesday INTEGER,$colwednesday INTEGER,$colthursday INTEGER,$colfriday INTEGER)');
    //,FOREIGN KEY ($colhabitID)REFERENCES $habitTable (group_id))
  }

  Future<List<Map<String, dynamic>>> getHabitDaysMapList() async {
    Database db = await this.database;
    //optional
    // var result = await db.rawQuery('SELECT * from $noteTable order by $colPriority ASC');
    var result = await db.query(habitdaysTable, orderBy: '$colID ASC');
    return result;
  }

  Future<int> insertHabitDays(HabitDays habitdays) async {
    debugPrint("insert" + habitdays.toString());
    Database db = await this.database;
    debugPrint("++++++++++++++++++++++++++++++");
    var result = await db.insert(habitdaysTable, habitdays.toMap());
    debugPrint("---------------------------");
    return result;
  }

  Future<int> updateHabitDays(HabitDays habitdays) async {
    Database db = await this.database;
    var result = await db.update(habitdaysTable, habitdays.toMap(),
        where: '$colID = ?', whereArgs: [habitdays.id]);
    return result;
  }

  Future<int> deleteHabitDays(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $habitdaysTable where $colID = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $habitdaysTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<HabitDays>> getHabitDaysList() async {
    var habitMapList = await getHabitDaysMapList();

    int count = habitMapList.length;

    List<HabitDays> habitList = List<HabitDays>();
    for (int i = 0; i < count; i++) {
      habitList.add(HabitDays.fromMapObject(habitMapList[i]));
    }
    return habitList;
  }

  Future<int> getHabitID(int habitID) async {
    debugPrint("getHabitID");
    debugPrint(habitID.toString());
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT $colID FROM $habitdaysTable WHERE $colhabitID=="$habitID"');
    debugPrint("after query");
    debugPrint(result.length.toString());
    // var id = result[0].values.single;
    // debugPrint(result.toString());

    if (result.length != 0) {
      debugPrint(result[0].values.single.toString());
      return result[0].values.single;
    } else {
      debugPrint('-1');
      return -1;
    }
  }
}
