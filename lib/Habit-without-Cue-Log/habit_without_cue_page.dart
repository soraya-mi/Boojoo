import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../Habit/habit.dart';
import 'package:flutter/widgets.dart';
import 'habit_without_cue_Log.dart';
import 'habit_without_cue_database.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

// ignore: camel_case_types
class HabitWithoutCue_Page extends StatefulWidget {
  final String appBarTitle;
  final Habit_without_Cue_log habitLog;
  final Habit habitInfo;
  HabitWithoutCue_Page(this.habitLog, this.habitInfo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return HabitWithoutCue_PageState(
        this.habitLog, this.habitInfo, this.appBarTitle);
  }
}

// ignore: camel_case_types
class HabitWithoutCue_PageState extends State<HabitWithoutCue_Page> {
  HabitWithoutCueLog_DBHelper helper = HabitWithoutCueLog_DBHelper();
  String appBarTitle;
  Habit_without_Cue_log habitLog;
  Habit habitInfo;

  //---
  String label;
  String selectedDate = Jalali.now().formatFullDate();
  String todayDate = (Jalali.now().year.toString() +
      '/' +
      Jalali.now().month.toString() +
      '/' +
      Jalali.now().day.toString());

  HabitWithoutCue_PageState(this.habitLog, this.habitInfo, this.appBarTitle);
//log exist in table or not
  String good = ""; //baraye tashvigh
  bool complete = false, fail = false;
  bool doesExist;
  int id;
  // final Future<String> _calculation = Future<String>.delayed(
  //   const Duration(seconds: 2),
  //   () => 'Data Loaded',
  // );

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getid(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            debugPrint('Step 3, build widget:s ${snapshot.data}');
            debugPrint(snapshot.data.toString());
            id = snapshot.data;
            // Build the widget with data.
            // Center(
            //   child: Container(child: Text('hasData: ${snapshot.data}')));
            debugPrint("in table");
            doesExist = true;
          }
          //else
          else {
            id = null;
            // debugPrint('Step 1, build loading widget ...waiting');
            if (AsyncSnapshot.waiting() != null) {
              debugPrint('wait nist');
            } else // We can show the loading view until the data comes back.
            {
              debugPrint('Step 1, build loading widget ...waiting');
              return CircularProgressIndicator();
            }
          }
          return WillPopScope(
            onWillPop: () {
              moveToLastScreen();
            },
            child: Scaffold(
              backgroundColor: Colors.teal[50],
              appBar: AppBar(
                title: Row(
                  children: [
                    Icon(Icons.description),
                    Text(appBarTitle),
                  ],
                ),
                backgroundColor: Colors.lightBlue.shade600,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  // padding: EdgeInsets.only(right: 200),
                  onPressed: () {
                    // debugPrint(
                    //     this.habitLog.cue.toString() + '---------------');

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
                      //habit title
                      Container(
                        margin: EdgeInsets.all((20.0)),
                        alignment: Alignment.center,
                        child: Text(
                          this.habitInfo.title,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // color: Colors.purpleAccent[100],
                        width: 20,
                      ),
                      Divider(color: Colors.black),
                      //today
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent[100],
                            border: Border.all(
                              color: Colors.orangeAccent[100],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: 40.0,
                        margin: EdgeInsets.fromLTRB(70.0, 15.0, 70.0, 0.0),
                        alignment: Alignment.center,
                        child: Text(
                          "امروز",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // color: Colors.orangeAccent[100],
                        width: 40,
                      ),
                      //today date
                      Container(
                        height: 40.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 70.0,
                          vertical: 15.0,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          todayDate,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent[100],
                            border: Border.all(
                              color: Colors.orangeAccent[100],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: 40,
                      ),
                      //ask "tasks completed?"
                      Center(
                          child: Text(
                        "امروز وظایف این عادت: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      //chckboxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //comleted text
                          Text(
                            "کامل شد",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //comleted checkbox
                          Checkbox(
                            tristate: true,
                            onChanged: (bool value) {
                              setState(() {
                                updateStatue(1);
                                complete = value;
                                fail = !value;
                                good = "آفرین!";
                                // if (id == null) {
                                //   value = null;
                                // }
                              });
                            },
                            value: complete,
                            activeColor: Colors.green,
                          ),
                          //failed text
                          Text(
                            "کامل نشد",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //failed textbox
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                updateStatue(0);
                                fail = value;
                                complete = !value;
                                good = "";
                                // if (id == null) {
                                //   value = null;
                                // }
                              });
                            },
                            activeColor: Colors.red,
                            value: fail,
                          ),
                        ],
                      ),
                      //say good
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 0.0),
                          child: Text(
                            good,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      //save button
                      Container(
                        width: 10.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 100.0,
                          vertical: 20.0,
                        ),
                        child: ElevatedButton(
                          // textColor: Colors.white,
                          // color: Colors.teal[300],
                          // padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ثبت',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint('goning to save:');
                              _save();
                            });
                          },
                        ),
                      ),
                      //delete button
                      Container(
                        width: 10.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 100.0,
                          vertical: 20.0,
                        ),
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
                              debugPrint('gonign to delete');
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                // onPressed: showButtons,
                tooltip: 'habit logs',
                child: Text(
                  "گزارش عادت",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                backgroundColor: Colors.amber,
              ),
            ),
          );
        },
      );

  void _save() async {
    debugPrint('save func');
    debugPrint(
        'id=' + id.toString() + ' log status:' + habitLog.status.toString());
    int result;
    if (id != null) {
      debugPrint("habit.id != null");
      _update();
      // _showAlertDialog("لطفا ابتدا گزارش را حذف کنید");
      // habitLog.id = id;
      // result = await helper.updateHabitLog(habitLog);

    } else {
      debugPrint("habit.id = null else");
      result = await helper.insertHabitLog(habitLog);
      if (result != 0) {
        // print(this.habitLog);
        _showAlertDialog("با موفقیت ذخیره شد");
        print('successful saves');
      } else {
        _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
      }
    }

    // moveToLastScreen();
  }

  void _delete() async {
    // moveToLastScreen();
    int result;
    if (id == null) {
      _showAlertDialog("لطفا گزارش را کامل کنید");
      return;
    } else {
      // habitLog.id = id;
      debugPrint(id.toString() + '  ' + habitLog.id.toString());
      result = await helper.deleteHabitLog(id);
    }

    if (result != 0) {
      _showAlertDialog("گزارش با موفقیت حذف شد");
    } else {
      _showAlertDialog("متاسفانه خطایی رخ داد");
    }
  }

  void _update() async {
    // moveToLastScreen();
    // int delete_result, save_result;

    // habitLog.id = id;
    debugPrint(id.toString() + '  ' + habitLog.id.toString());
    int delete_result = await helper.deleteHabitLog(id);
    int save_result = await helper.insertHabitLog(habitLog);
    if (delete_result != 0 && save_result != 0) {
      _showAlertDialog("گزارش با موفقیت به روز رسانی شد");
    } else {
      _showAlertDialog("متاسفانه خطایی رخ داد");
    }
  }

  void moveToLastScreen() {
    debugPrint('move');
    Navigator.pop(context, true);
    debugPrint('move2');
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      // title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void updateStatue(int status) {
    this.habitLog.status = status;
  }

  Future<int> getid() async {
    debugPrint('in get id func');
    int logexist =
        await helper.exist(habitInfo.id, habitLog.date).then((value) {
      debugPrint(value.toString() +
          'value return form exist in getId func----------------------------');
      return value;
    });
    debugPrint(logexist.toString() + '---------------/////////////');
    return logexist;
  }
}
