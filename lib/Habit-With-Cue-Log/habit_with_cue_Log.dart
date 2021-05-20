import 'package:flutter/material.dart';

// ignore: camel_case_types
class Habit_with_Cue_log {
  int _id;
  int _habitID;
  String _date;
  int _cue;
  Habit_with_Cue_log(this._habitID, this._date, [this._cue]);
  Habit_with_Cue_log.withID(this._habitID, this._date, [this._cue]);
  int get id {
    return _id;
  }

  int get habitID => _habitID;
  String get date => _date;
  int get cue => _cue;

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
  set cue(int newCue) {
    this._cue = newCue;
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
    map['HabitID'] = _habitID;
    map['date'] = _date;
    map['cue'] = _cue;
    return map;
  }

  Habit_with_Cue_log.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._habitID = map['HabitID'];
    this._date = map['date'];
    this._cue = map['cue'];
  }
}
