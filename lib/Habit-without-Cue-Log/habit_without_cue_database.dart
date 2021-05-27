import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'habit_without_cue_Log.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

// ignore: camel_case_types
class HabitWithoutCueLog_DBHelper {
  static HabitWithoutCueLog_DBHelper _habitWithoutCueLog_DBHelper; //Singleton
  static Database _database; //singleton

  String habitwithoutCueTable = 'habitwithoutCue_table';
  String colID = 'id';
  String colHabitID = 'habitID';
  String colDate = 'date';
  String colStatus = 'status';

  HabitWithoutCueLog_DBHelper._createInstance();
  factory HabitWithoutCueLog_DBHelper() {
    if (_habitWithoutCueLog_DBHelper == null) {
      _habitWithoutCueLog_DBHelper =
          HabitWithoutCueLog_DBHelper._createInstance();
    }
    return _habitWithoutCueLog_DBHelper;
  }

//custom getter
  Future<Database> get database async {
    if (_database == null) {
      debugPrint('db is null');
      _database = await initalizehabitWithoutCueLogDB();
    }
    debugPrint("berfore retuen");
    return _database;
  }

  //initialoize habit database
  Future<Database> initalizehabitWithoutCueLogDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'habitswithoutcue_log.db';

    var habitsWithoutCueDatabase = await openDatabase(path,
        version: 1, onCreate: _createHabitWithoutCueLogDb);
    return habitsWithoutCueDatabase;
  }

  void _createHabitWithoutCueLogDb(Database db, int newVersion) async {
    debugPrint('create*********');
    await db.execute(
        'CREATE TABLE $habitwithoutCueTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,$colHabitID INTEGER, $colDate TEXT,$colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getHabitWithputCueLogMapList() async {
    Database db = await this.database;
    //optional
    // var result = await db.rawQuery('SELECT * from $noteTable order by $colPriority ASC');
    var result = await db.query(habitwithoutCueTable);
    return result;
  }

  Future<int> insertHabitLog(Habit_without_Cue_log habit) async {
    Database db = await this.database;
    var result = await db.insert(habitwithoutCueTable, habit.toMap());
    return result;
  }

  Future<int> updateHabitLog(Habit_without_Cue_log habit) async {
    Database db = await this.database;
    var result = await db.update(habitwithoutCueTable, habit.toMap(),
        where: '$colID = ?', whereArgs: [habit.id]);
    return result;
  }

  Future<int> deleteHabitLog(int id) async {
    Database db = await this.database;
    var result = await db
        .rawDelete('DELETE FROM $habitwithoutCueTable where $colID = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $habitwithoutCueTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Habit_without_Cue_log>> getHabitLogList() async {
    var habitMapList = await getHabitWithputCueLogMapList();

    int count = habitMapList.length;

    List<Habit_without_Cue_log> habitList = List<Habit_without_Cue_log>();
    for (int i = 0; i < count; i++) {
      habitList.add(Habit_without_Cue_log.fromMapObject(habitMapList[i]));
    }
    return habitList;
  }

  //function to get logs of a Habit
//   Future<List<Habit_without_Cue_log>> getHabitLogs() asyns{
//   var habitMapList = await getHabitWithputCueLogMapList();
// }
  Future<int> exist(int hid, String hdate) async {
    //Future<List<Map<String, Object>>>
    debugPrint("in exist");
    debugPrint(hdate);
    Database db = await this.database;
    debugPrint("before query");
    var result = await db.rawQuery(
        'SELECT $colID from $habitwithoutCueTable WHERE $colDate = "$hdate" AND $colHabitID = "$hid" ');
    debugPrint('after query');
    debugPrint(result[0].values.first.toString() + '....');
    // int logID = int.parse(result[0].values.toString()[1]);
    // debugPrint(logID.toString());
    int logID = await int.parse(result[0].values.first.toString());
    debugPrint('id' + logID.toString());
    // debugPrint(result.toString());
    debugPrint('brefore return id value');
    return await logID;
  }

  Future<List<Map<String, Object>>> getHabitLogsMap(int habitID) async {
    //Future<List<Map<String, Object>>>
    debugPrint("in getHabitLogs");
    Database db = await this.database;
    debugPrint("before query of db");
    var result = await db.rawQuery(
        'SELECT COUNT (*),$colStatus AS STATUS from $habitwithoutCueTable GROUP BY $colStatus , $colHabitID ');
    debugPrint('after query');
    debugPrint('~~~~~' + result.length.toString());
    debugPrint('~~~~~' + result.toString());
    // debugPrint('~~~~~' + result[0].values.first.toString() + '....');
    // debugPrint('brefore res1');
    // debugPrint('~~~~~' + result[1].values.first.toString() + '....');
    // int logID = int.parse(result[0].values.toString()[1]);
    // debugPrint(logID.toString());
    // int logID = await int.parse(result[0].values.first.toString());
    // debugPrint('~~~~~' + 'id' + logID.toString());
    // debugPrint(result.toString());
    debugPrint('brefore return id value');
    return result;
  }

  Future<void> deleteHabitLogs(int habitID) async {
    debugPrint("in Delete fun");
    Database db = await this.database;
    db.rawDelete(
        'DELETE FROM $habitwithoutCueTable WHERE $colHabitID="$habitID"');
    debugPrint("Deleted.");
  }
// Future<List<Habit_without_Cue_log>> getHabitLogsList(int habitID) async {
//   debugPrint("in");
//   var habitListbyCategory = await getHabitLogsMap(habitID);
//   debugPrint(habitListbyCategory.toString());
//   // var counter = await _database.rawQuery(
//   //     'SELECT  COUNT(*) FROM $habitTable WHERE $colCategory="$category"');
//   // debugPrint(counter[0].values.single.toString());
//   // var num = counter[0].values.single;
//   // var habitMapList = await getHabitMapList();
//
//   int count = habitListbyCategory.length;
//
//   List<Habit_without_Cue_log> habitList = List<Habit_without_Cue_log>();
//   for (int i = 0; i < count; i++) {
//     habitList
//         .add(Habit_without_Cue_log.fromMapObject(habitListbyCategory[i]));
//   }
//   return habitList;
// }

}
