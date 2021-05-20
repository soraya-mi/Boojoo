import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'habit.dart';
import 'habit-database.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';

class HabitDetail extends StatefulWidget {
  final String appBarTitle;
  final Habit habit;
  HabitDetail(this.habit, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return HabitDetailState(this.habit, this.appBarTitle);
  }
}

class HabitDetailState extends State<HabitDetail> {
  static var _prioities = ["high", "low"];
  HabitDataBaseHelper helper = HabitDataBaseHelper();
  String appBarTitle;
  Habit habit;
  //---
  String label;
  String selectedDate = Jalali.now().formatFullDate();

  // @override
  // void initState() {
  //   super.initState();
  //   label = 'انتخاب تاریخ زمان';
  // }
  //---
  HabitDetailState(this.habit, this.appBarTitle);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController completedController = TextEditingController(); //why??
  TextEditingController cueController = TextEditingController();
  // TextFormField amountOfGHabitGoal = TextFormField();
  // TextFormField cueController = TextFormField();
  int _currentIntValue = 0;
  bool a, b;
  @override
  Widget build(BuildContext context) {
    if (this.habit.type == 1) {
      a = false;
      b = true;
    } else {
      a = true;
      b = false;
    }
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titleController.text = habit.title;
    descriptionController.text = habit.description;
    // if (habit.cue != Null) cueController.text = habit.cue.toString();
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            // padding: EdgeInsets.only(right: 200),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListView(
              children: <Widget>[
                // first Element:title
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                      labelText: 'عنوان',
                      labelStyle: textStyle,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.title_rounded),
                      ),
                    ),
                  ),
                ),

                // second Element:description
                Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 10.0, left: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                      labelText: 'توضیحات',
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.details_rounded),
                      ),
                    ),
                  ),
                ),
                //third Element:priority
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                  //dropdown menu
                  child: new ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: const Icon(Icons.priority_high),
                    ),
                    title: DropdownButton(
                        items: _prioities.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          );
                        }).toList(),
                        value: getPriorityAsString(habit.priority),
                        onChanged: (valueSelectedByUser) {
                          setState(() {
                            updatePriorityAsInt(valueSelectedByUser);
                          });
                        }),
                  ),
                ),
                //forth Element:Date picker
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ElevatedButton(
                        // color: Colors.teal,
                        onPressed: () async {
                          Jalali picked = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1385, 8),
                            lastDate: Jalali(1450, 9),
                          );
                          if (picked != null && picked != selectedDate)
                            setState(() {
                              // label = picked.formatFullDate();
                              // this.habit.startDate = picked.toString();
                              updateStartDate(picked.toString());
                              // debugPrint(this.habit.startDate);
                            });
                        },
                        child: Text('شروع '),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ElevatedButton(
                        // color: Colors.teal,
                        onPressed: () async {
                          Jalali picked = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1385, 8),
                            lastDate: Jalali(1450, 9),
                          );
                          if (picked != null && picked != selectedDate)
                            setState(() {
                              // label = picked.formatFullDate();
                              // this.habit.endDate = picked.toString();
                              updateendDate(picked.toString());
                              // debugPrint(this.habit.endDate);
                            });
                        },
                        child: Text('پایان '),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
                // Text(
                //   "نوع",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20.0,
                //   ),
                // ),
                //Cue text field

                Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 26.0),
                  child: Row(
                    children: [
                      Text(
                        " نوع عادت:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Checkbox(
                        onChanged: (bool value) {
                          setState(() {
                            // this.habit.type = 0;
                            updateType(0);
                            // print(this.habit.type);
                            // print("0--------------");
                            a = value;
                          });
                        },
                        value: a,
                        hoverColor: Colors.yellow,
                      ),
                      Text("تکمیل کردنی"),
                      Checkbox(
                        onChanged: (bool value) {
                          setState(() {
                            // this.habit.type = 1;
                            updateType(1);
                            // print(this.habit.type);
                            b = value;
                          });
                        },
                        value: b,
                      ),
                      Text("هدف گذاری"),
                    ],
                  ),
                ),
                //fifth Elemtn:number picker
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 15.0, 0.0),
                  child: TextFormField(
                    controller: cueController,
                    onChanged: (value) {
                      int a = int.parse(value);
                      updateCue(a);
                    },
                    decoration: InputDecoration(
                      labelText: 'یک عدد صحیح وارد کنید...',
                      labelStyle: textStyle,
                      enabled: b,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.auto_awesome),
                      ),
                    ),
                  ),
                ),
                NumberPicker(
                  value: _currentIntValue,
                  minValue: 0,
                  maxValue: 100,
                  step: 1,
                  // haptics: true,
                  onChanged: (value) => setState(
                    () {
                      _currentIntValue = value;
                      // this.habit.number = _currentIntValue;
                      updateNumber(value);
                    },
                  ),
                ),
                // last Element:save and delete buttons in a row
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      //save button
                      Expanded(
                        child: ElevatedButton(
                          // textColor: Colors.white,
                          // color: Colors.teal[300],
                          // padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ذخیره',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            debugPrint("Save button clicked");
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      //delete button
                      Expanded(
                        child: ElevatedButton(
                          // textColor: Colors.white,
                          // color: Colors.teal[300],
                          // padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'حذف',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Converting the Priority into String for showing to User
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _prioities[0];
        break;
      case 2:
        priority = _prioities[1];
        break;
      default:
    }
    return priority;
  }

  //Convert Priority to Int to Save it into Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case "High":
        habit.priority = 1;
        break;
      case "Low":
        habit.priority = 2;
        break;
      default:
    }
  }

  void updateTitle() {
    habit.title = titleController.text;
  }

  void updateDescription() {
    habit.description = descriptionController.text;
  }

  void updateStartDate(String date) {
    this.habit.startDate = date;
  }

  void updateendDate(String date) {
    this.habit.endDate = date;
  }

  void updateNumber(int number) {
    this.habit.number = _currentIntValue;
  }

  void updateType(int Type) {
    this.habit.type = Type;
  }

  void updateCue(int value) {
    this.habit.cue = value;
  }

  void updateAlarm() {}
  void moveToLastScreen() {
    debugPrint('move');
    Navigator.pop(context, true);
    debugPrint('move2');
  }

  void _save() async {
    moveToLastScreen();
    // note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (habit.id != null) {
      result = await helper.updateHabit(habit);
    } else {
      result = await helper.insertHabit(habit);
    }

    if (result != 0) {
      print(this.habit);
      _showAlertDialog("با موفقیت ذخیره شد");
      print('thisssssss');
    } else {
      _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (habit.id == null) {
      _showAlertDialog("لطفا عنوان عادت را وارد کنید");
      return;
    }
    int result = await helper.deleteHabit(habit.id);

    if (result != 0) {
      _showAlertDialog("عادت با موفقیت حذف شد");
    } else {
      _showAlertDialog("متاسفانه خطایی رخ داد");
    }
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      // title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
