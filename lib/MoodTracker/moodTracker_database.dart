import 'package:flutter/widgets.dart';
import 'moodTracker.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MoodTrackerDataBaseHelper {
  static MoodTrackerDataBaseHelper _moodTrackerDatabaseHelper; //Singleton
  static Database _database; //singleton

  String moodTrackerTable = 'moodTracker_table';
  String colID = 'id';
  String colDate = 'date';
  String colMood = 'mood';

  MoodTrackerDataBaseHelper._createInstance();

  factory MoodTrackerDataBaseHelper() {
    if (_moodTrackerDatabaseHelper == null) {
      debugPrint("null");
      _moodTrackerDatabaseHelper = MoodTrackerDataBaseHelper._createInstance();
    }
    return _moodTrackerDatabaseHelper;
  }

//custom getter
  Future<Database> get database async {
    if (_database == null) {
      debugPrint("------------------------------------");
      _database = await initalizeMoodTrackerDatabase();
    }
    return _database;
  }

//initialoize task database
  Future<Database> initalizeMoodTrackerDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'moodTracker.db';

    var MoodTrackerDatabase =
        await openDatabase(path, version: 1, onCreate: _createMoodTrackerDb);
    return MoodTrackerDatabase;
  }

  void _createMoodTrackerDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $moodTrackerTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $colDate TEXT, $colMood INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getMoodsMapList() async {
    Database db = await this.database;
    //optional
    // var result = await db.rawQuery('SELECT * from $taskTable order by $colPriority ASC');
    var result = await db.query(moodTrackerTable);
    return result;
  }

  Future<List<MoodTracker>> getMoodsList() async {
    var moodsMapList = await getMoodsMapList();

    int count = moodsMapList.length;

    List<MoodTracker> taskList = List<MoodTracker>();
    for (int i = 0; i < count; i++) {
      taskList.add(MoodTracker.fromMapObject(moodsMapList[i]));
    }
    return taskList;
  }

  Future<int> insertMood(MoodTracker moodTracker) async {
    debugPrint("insert");
    Database db = await this.database;
    var result = await db.insert(moodTrackerTable, moodTracker.toMap());
    return result;
  }

  Future<int> updateMood(MoodTracker moodTracker) async {
    Database db = await this.database;
    var result = await db.update(moodTrackerTable, moodTracker.toMap(),
        where: '$colID = ?', whereArgs: [moodTracker.id]);
    return result;
  }

  Future<int> deleteMood(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $moodTrackerTable where $colID = $id');
    return result;
  }

  Future<int> getCount() async {
    debugPrint("get");
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $moodTrackerTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getMoodId(String date) async {
    debugPrint("in get id func");
    Database db = await this.database;
    debugPrint("before query");
    var result = await db.rawQuery(
        'SELECT $colID from $moodTrackerTable WHERE $colDate = "$date"');
    debugPrint('after query');
    debugPrint('brefore return id value');
    if (result.length != 0) {
      return await result[0].values.first;
    } else
      return -1;
  }
}
