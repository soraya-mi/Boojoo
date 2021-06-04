import 'package:flutter/material.dart';

class Habit {
  int _id;
  int _priority;
  int _number = 1;
  int _hasAlarm = 0;
  int _finished = 0;
  int _cue;
  // int _group;
  String _title;
  String _description;
  String _startDate;
  String _endDate;
  int _type;
  String _days = "0000000";
  String _category;
  // String _created_at;
  // String _updated_at;

  //This is Optioanl Position Paremeter if {} This is Optional Named Parameter
  Habit(
    this._title,
    this._startDate,
    this._endDate,
    this._priority,
    this._type, [
    this._description,
    this._hasAlarm,
    this._number,
    this._cue,
    this._days,
    this._category,
  ]);
  //This is during editing(Called with Id)
  Habit.withId(
    this._id,
    this._title,
    this._startDate,
    this._endDate,
    this._priority,
    this._type, [
    this._description,
    this._hasAlarm,
    this._number,
    this._cue,
    this._days,
    this._category,
  ]);
  // Habit.withId(this._id, this._title, this._startDate, this._endDate,
  //     this._priority, this._type, this._finished,
  //     [this._description, this._hasAlarm, this._number]);

//All the Getters(Controls the Data Asked By another method from this Class)
  int get id {
    return _id;
  }

  String get title => _title;
  String get startDate => _startDate;
  String get endDate => _endDate;
  int get priority => _priority;
  int get type => _type;
  int get number => _number;
  String get description => _description;
  int get hasAlarm => _hasAlarm;
  int get finished => _finished;
  int get cue => _cue;
  String get days => _days;
  String get category => _category;

//These are all the Setters
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set startDate(String newDate) {
    if (newDate.length <= 255) {
      this._startDate = newDate;
    }
  }

  set endDate(String newDate) {
    if (newDate.length <= 255) {
      this._endDate = newDate;
    }
  }

  set priority(int newPre) {
    if (newPre >= 1 && newPre <= 2) {
      this._priority = newPre;
    }
  }

  set number(int newNumber) {
    this._number = newNumber;
  }

  set type(int newType) {
    this._type = newType;
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set hasAlarm(int newAlarmStatus) {
    this._hasAlarm = newAlarmStatus;
  }

  set finished(int finished) {
    this._finished = finished;
  }

  set cue(int newCue) {
    this._cue = newCue;
  }

  set category(String newCategory) {
    this._category = newCategory;
  }

  set days(String Days) {
    this._category = Days;
  }

//Used to Save and Retrive from the Database
//Converting the Habit Object into Map Object
  Map<String, dynamic> toMap() {
    //This is an Map Object
    var map = Map<String, dynamic>();
    //This means Already Created in the Database
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['startDate'] = _startDate;
    map['endDate'] = _endDate;
    map['priority'] = _priority;
    map['type'] = _type;
    map['number'] = _number;
    map['description'] = _description;
    map['alarm'] = _hasAlarm;
    map['finished'] = _finished;
    map['cue'] = _cue;
    map['days'] = _days;
    map['category'] = _category;
    return map;
  }

  Habit.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._startDate = map['startDate'];
    this.endDate = map['endDate'];
    this._priority = map['priority'];
    this._type = map['type'];
    this._number = map['number'];
    this._description = map['description'];
    this._hasAlarm = map['alarm'];
    this._finished = map['finished'];
    this._cue = map['cue'];
    this._days = map['days'];
    this._category = map['category'];
  }
}
