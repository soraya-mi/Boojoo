import 'package:flutter/material.dart';

// ignore: camel_case_types
class Habit_without_Cue_log {
  int _id;
  int _habitID;
  String _date;
  int _status; //2 means not defined yet
  Habit_without_Cue_log(this._habitID, this._date, [this._status]);
  Habit_without_Cue_log.withID(this._habitID, this._date, [this._status]);
  int get id {
    return _id;
  }

  // ignore: non_constant_identifier_names
  int get ID => _id;
  int get habitID => _habitID;
  String get date => _date;
  int get status => _status;

//These are all the Setters
  set habitID(int newHabitID) {
    this._habitID = newHabitID;
  }

  set date(String newDate) {
    if (newDate.length <= 255) {
      this._date = newDate;
    }
  }

  //0:failed-1:done
  set status(int newStatus) {
    this._status = newStatus;
  }

  set id(int newID) {
    debugPrint('id setter');
    this.id = newID;
    debugPrint('after setter');
  }

  //Used to Save and Retrive from the Database
//Converting the Note Object into Map Object
  Map<String, dynamic> toMap() {
    //This is an Map Object
    var map = Map<String, dynamic>();
    //This means Already Created in the Database
    if (id != null) {
      map['id'] = _id;
    }
    map['habitID'] = _habitID;
    map['date'] = _date;
    map['status'] = _status;
    return map;
  }

  Habit_without_Cue_log.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._habitID = map['habitID'];
    this._date = map['date'];
    this._status = map['status'];
  }
}
