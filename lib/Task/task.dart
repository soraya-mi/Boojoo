import 'package:flutter/material.dart';

class Task {
  int _id;
  int _priority;
  String _title;
  String _description;
  String _date;
  String _startTime;
  String _endTime;
  int _completed = 0;
  //This is Optioanl Position Paremeter if {} This is Optional Named Parameter
  Task(this._title, this._date, this._startTime, this._endTime, this._priority,
      [this._description]);
  //This is during editing(Called with Id)
  Task.withId(this._id, this._title, this._date, this._startTime, this._endTime,
      this._priority, this._completed,
      [this._description]);

//All the Getters(Controls the Data Asked By another method from this Class)
  int get id {
    return _id;
  }

  String get title => _title;
  String get description => _description;
  int get priority => _priority;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  int get completed => _completed;
//These are all the Setters
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    if (newDate.length <= 255) {
      this._date = newDate;
    }
  }

  set startTime(String newStartTime) {
    if (newStartTime.length <= 255) {
      this._startTime = newStartTime;
    }
  }

  set endTime(String newEndTime) {
    if (newEndTime.length <= 255) {
      this._endTime = newEndTime;
    }
  }

  set priority(int newPre) {
    if (newPre >= 1 && newPre <= 2) {
      this._priority = newPre;
    }
  }

  set completed(int newStatus) {
    this._completed = newStatus;
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
    map['title'] = _title;
    map['description'] = _description;
    map["priority"] = _priority;
    map['date'] = _date;
    map['starttime'] = _startTime;
    map['endtime'] = _endTime;
    map['completed'] = _completed;
    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._startTime = map['starttime'];
    this._endTime = map['endtime'];
    this._completed = map['completed'];
  }
}
