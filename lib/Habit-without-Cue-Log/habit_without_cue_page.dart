import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../Habit/habit.dart';
import 'package:flutter/widgets.dart';
import 'CuelessLogPage.dart';
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
  void navigateToLogs(Habit habitinfo, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HabitWithoutCue_LogPage(habitInfo, title);
    }));
  }

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
        builder: (context, AsyncSnapshot<Habit_without_Cue_log> snapshot) {
          if (snapshot.hasData) {
            debugPrint('Step 3, build widget:s ${snapshot.data}');
            debugPrint(snapshot.data.toString());
            id = snapshot.data.id;
            // Build the widget with data.
            // Center(
            //   child: Container(child: Text('hasData: ${snapshot.data}')));
            debugPrint("in table");
            debugPrint(snapshot.data.status.toString());
            if (snapshot.data.status == 1) {
              complete = true;
              fail = false;
            } else {
              complete = false;
              fail = true;
            }
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
                        height: 40.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 70.0,
                          vertical: 20.0,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "امروز : " + todayDate,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent[100],
                            border: Border.all(
                              color: Colors.lightBlueAccent[100],
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
                      // RaisedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       addFakeData();
                      //     });
                      //   },
                      // ),
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
                      SizedBox(
                        height: 20.0,
                      ),
                      //save button
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.lightBlueAccent,
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
                          Container(
                            width: 100.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.lightBlueAccent,
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
                      //delete button

                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        margin: EdgeInsets.only(bottom: 0.0),
                        child: CupertinoButton(
                          child: Text("مشاهده گزارش کامل عادت"),
                          // color: Colors.amber,
                          onPressed: () {
                            setState(() {
                              navigateToLogs(habitInfo, "گزارش کامل عادت");
                              // debugPrint('goning to save:');
                              // _save();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
//result = await helper.insertHabitLog(habitLog);

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
      complete = false;
      fail = false;
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

  Future<Habit_without_Cue_log> getid() async {
    debugPrint('in get id func');
    Habit_without_Cue_log logexist =
        await helper.getLogObject(habitInfo.id, habitLog.date).then((value) {
      debugPrint(value.toString() +
          'value return form exist in getId func----------------------------');
      return value;
    });
    debugPrint(logexist.toString() + '---------------/////////////');
    return logexist;
  }

  void addFakeData() async {
    debugPrint("in adff func");
    // Habit_without_Cue_log habit1 =
    //     Habit_without_Cue_log(habitInfo.id, "1400/3/6", 0);
    // Habit_without_Cue_log habit2 =
    //     Habit_without_Cue_log(habitInfo.id, "1400/3/7", 0);
    // Habit_without_Cue_log habit3 =
    //     Habit_without_Cue_log(habitInfo.id, "1400/3/8", 1);
    // Habit_without_Cue_log habit4 =
    //     Habit_without_Cue_log(habitInfo.id, "1400/3/9", 0);
    // Habit_without_Cue_log habit5 =
    //     Habit_without_Cue_log(habitInfo.id, "1400/3/10", 1);
    // int res;
    // res = await helper.insertHabitLog(habit1);
    // res = await helper.insertHabitLog(habit2);
    // res = await helper.insertHabitLog(habit3);
    // res = await helper.insertHabitLog(habit4);
    // res = await helper.insertHabitLog(habit5);
    var r = await helper.deleteHabitLogs(habitInfo.id);
    debugPrint("after deleter");
    return r;
  }
}
