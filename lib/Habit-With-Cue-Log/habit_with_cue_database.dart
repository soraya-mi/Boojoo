import 'package:flutter/widgets.dart';
import 'habit_with_cue_Log.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// ignore: camel_case_types
class HabitWithCueLog_DBHelper {
  static HabitWithCueLog_DBHelper _habitWithCueLog_DBHelper; //Singleton
  static Database _database; //singleton

  String habitwithCueTable = 'habitwithCue_table';
  String colID = 'id';
  String colHabitID = 'habitID';
  String colDate = 'date';
  String colCue = 'cue';

  HabitWithCueLog_DBHelper._createInstance();

  factory HabitWithCueLog_DBHelper() {
    if (_habitWithCueLog_DBHelper == null) {
      _habitWithCueLog_DBHelper = HabitWithCueLog_DBHelper._createInstance();
    }
    return _habitWithCueLog_DBHelper;
  }

//custom getter
  Future<Database> get database async {
    if (_database == null) {
      debugPrint('nul');
      _database = await initalizehabitWithCueLogDB();
    }
    return _database;
  }

  //initialoize habit database
  Future<Database> initalizehabitWithCueLogDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'habitswithcue_log.db';

    var habitsWithCueDatabase = await openDatabase(path,
        version: 1, onCreate: _createHabitWithCueLogDb);
    return habitsWithCueDatabase;
  }

  void _createHabitWithCueLogDb(Database db, int newVersion) async {
    debugPrint('create*********');
    await db.execute(
        'CREATE TABLE $habitwithCueTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,$colHabitID INTEGER, $colDate TEXT,$colCue INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getHabitWithCueLogMapList() async {
    Database db = await this.database;
    //optional
    // var result = await db.rawQuery('SELECT * from $noteTable order by $colPriority ASC');
    var result = await db.query(habitwithCueTable);
    return result;
  }

  Future<int> insertHabitLog(Habit_with_Cue_log habit) async {
    debugPrint("inset*********");
    Database db = await this.database;
    debugPrint("++++++++++++++++++++++++++++++");
    debugPrint(habit.habitID.toString());
    var result = await db.insert(habitwithCueTable, habit.toMap());
    debugPrint("---------------------------");
    return result;
  }

  Future<int> updateHabitLog(Habit_with_Cue_log habit) async {
    Database db = await this.database;
    var result = await db.update(habitwithCueTable, habit.toMap(),
        where: '$colID = ?', whereArgs: [habit.id]);
    return result;
  }

  Future<int> deleteHabitLog(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $habitwithCueTable where $colID = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $habitwithCueTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Habit_with_Cue_log>> getHabitList() async {
    var habitMapList = await getHabitWithCueLogMapList();

    int count = habitMapList.length;

    List<Habit_with_Cue_log> habitList = List<Habit_with_Cue_log>();
    for (int i = 0; i < count; i++) {
      habitList.add(Habit_with_Cue_log.fromMapObject(habitMapList[i]));
    }
    return habitList;
  }

  //
  // Future<List<Map<String, Object>>> exist(Habit_with_Cue_log H) async {
  //   debugPrint("in exist");
  //   Database db = await this.database;
  //   int hid = H.habitID;
  //   String hdate = H.date;
  //   debugPrint(hid.toString() + ' ' + hdate);
  //   var result = await db.rawQuery(
  //       'SELECT $colID from $habitwithCueTable WHERE $colDate = $hdate AND $colhabitID = $hid ');
  //   debugPrint(result.toString() + '....');
  //   debugPrint(result.toString());
  //   return result;
  //   // var result = await db.query(
  //   //     '$habitwithoutCueTable where $colHabitID = $hid AND $colDate = $date'); //SELECT $colID  FROM
  //   // debugPrint(date);
  // }

  Future<int> getID(int hid, String hdate) async {
    //Future<List<Map<String, Object>>>
    debugPrint("in get id func");
    Database db = await this.database;
    debugPrint("before query");
    var result = await db.rawQuery(
        'SELECT $colID from $habitwithCueTable WHERE $colDate = "$hdate" AND $colHabitID = "$hid"');
    debugPrint('after query');
    // if (result != null)
    //   debugPrint('id=' + result[0].values.first.toString() + '....');
    // int logID = int.parse(result[0].values.toString()[1]);
    // debugPrint(logID.toString());
    // int logID = await int.parse(result[0].values.first.toString());
    // debugPrint('id' + logID.toString());
    // debugPrint(result.toString());
    debugPrint('brefore return id value');
    if (result.length != 0) {
      return await result[0].values.first;
    } else
      return -1;
  }

  Future<List<Map<String, Object>>> getHabitLogsMap(int habitID) async {
    //Future<List<Map<String, Object>>>
    debugPrint("in getHabitLogs");
    Database db = await this.database;
    debugPrint("before query");
    var result = await db.rawQuery(
        'SELECT $colDate AS DATE,$colCue AS CUE from $habitwithCueTable WHERE $colHabitID="$habitID"');
    debugPrint('after query');
    debugPrint(result.toString());
    debugPrint('before return id value');
    debugPrint(result.toList().toString());
    debugPrint('wwwwwwww');
    return result.toList();
  }

  Future<List<Habit_with_Cue_log>> getHabitLogsList(int habitID) async {
    debugPrint("in");
    var habitLogsList = await getHabitLogsMap(habitID);
    debugPrint(habitLogsList.toString());
    int count = habitLogsList.length;
    List<Habit_with_Cue_log> habitList = List<Habit_with_Cue_log>();
    for (int i = 0; i < count; i++) {
      habitList.add(Habit_with_Cue_log.fromMapObject(habitLogsList[i]));
    }
    return habitList;
  }

  Future<void> deleteHabitLogs(int habitID) async {
    debugPrint("in Delete fun");
    Database db = await this.database;
    db.rawDelete('DELETE FROM $habitwithCueTable WHERE $colHabitID="$habitID"');
    debugPrint("Deleted.");
  }
// Future<List<>>> getHabitLogsList(int habitID) async {
//   debugPrint("in getHabitLogs");
//   Database db = await this.database;
//   debugPrint("before query");
//   var result = await db.rawQuery(
//       'SELECT $colDate AS DATE,$colCue AS CUE from $habitwithCueTable WHERE $colHabitID="$habitID"');
//   debugPrint('after query');
//   debugPrint(result.toString());
//   debugPrint('before return id value');
//   debugPrint(result.values.toList()[0].toString());
//   debugPrint('wwwwwwww');
//   return result;
//   debugPrint("in get log list");
//   var habitogsList = await getHabitLogsMap(habitID);
//   debugPrint(habitogsList.toString());
//   // var counter = await _database.rawQuery(
//   //     'SELECT  COUNT(*) FROM $habitTable WHERE $colCategory="$category"');
//   // debugPrint(counter[0].values.single.toString());
//   // var num = counter[0].values.single;
//   // var habitMapList = await getHabitMapList();
//   //
//   // int count = habitogsList.length;
//   //
//   // List<Map<String, String>> habitList = List<Map<String, String>>();
//   // for (int i = 0; i < count; i++) {
//   //   habitList.add(Map<String, String>.fromMapObject(habitogsList[i]));
//   // }
//   // return habitList;
// }
}
