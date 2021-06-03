import 'package:flutter/material.dart';

class HabitDays {
  int _id;
  int _habitID;
  int _saturday;
  int _sunday;
  int _monday;
  int _tuesday;
  int _wednesday;
  int _thursday;
  int _friday;
  //This is Optioanl Position Paremeter if {} This is Optional Named Parameter
  HabitDays(
    this._habitID, [
    this._saturday,
    this._sunday,
    this._monday,
    this._tuesday,
    this._wednesday,
    this._thursday,
    this._friday,
  ]);
  //This is during editing(Called with Id)
  HabitDays.withId(
    this._id,
    this._habitID, [
    this._saturday,
    this._sunday,
    this._monday,
    this._tuesday,
    this._wednesday,
    this._thursday,
    this._friday,
  ]);
  // Habit.withId(this._id, this._title, this._startDate, this._endDate,
  //     this._priority, this._type, this._finished,
  //     [this._description, this._hasAlarm, this._number]);

//All the Getters(Controls the Data Asked By another method from this Class)
  int get id {
    return _id;
  }

  int get habitID => _habitID;
  int get saturday => _saturday;
  int get sunday => _saturday;
  int get monday => _saturday;
  int get tuesday => _saturday;
  int get wednesday => _saturday;
  int get thursday => _saturday;
  int get friday => _saturday;

//These are all the Setters
  set habitID(int HabitID) {
    this._habitID = HabitID;
  }

  set saturday(int Saturday) {
    this._saturday = Saturday;
  }

  set sunday(int Sunday) {
    this._sunday = Sunday;
  }

  set monday(int Monday) {
    this._monday = Monday;
  }

  set tuesday(int Tuesday) {
    this._tuesday = Tuesday;
  }

  set wednesday(int Wednesday) {
    this._wednesday = Wednesday;
  }

  set thursday(int Thursday) {
    this._thursday = Thursday;
  }

  set friday(int Saturday) {
    this._friday = Saturday;
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
    map['habitID'] = _habitID;
    map['saturday'] = _saturday;
    map['sunday'] = _sunday;
    map['monday'] = _monday;
    map['tuesday'] = _tuesday;
    map['wednesday'] = _wednesday;
    map['thursday'] = _thursday;
    map['friday'] = _friday;
    return map;
  }

  HabitDays.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._habitID = map['habitID'];
    this._saturday = map['saturday'];
    this._sunday = map['sunday'];
    this._monday = map['monday'];
    this._tuesday = map['tuesday'];
    this._wednesday = map['wednesday'];
    this._thursday = map['thursday'];
    this._friday = map['friday'];
  }
}
