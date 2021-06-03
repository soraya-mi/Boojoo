import 'package:flutter/cupertino.dart';
import '../Habit/habit.dart';
import 'package:flutter/widgets.dart';
import 'habit_with_cue_Log.dart';
import 'habit_with_cue_database.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

// ignore: camel_case_types
class HabitWithCue_Page extends StatefulWidget {
  final String appBarTitle;
  final Habit_with_Cue_log habitLog; //final
  final Habit habitInfo;
  // void navigateToLogs(Habit habitinfo, String title) async {
  //   bool result =
  //       await Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return Habit_with_Cue_log(habitInfo, title);
  //   }));
  // }
//  HabitWithCue_Page(this.habitLog, this.habitInfo, this.appBarTitle);
  HabitWithCue_Page(this.habitLog, this.habitInfo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return HabitWithCue_PageState(
        this.habitLog, this.habitInfo, this.appBarTitle);
  }
}

// ignore: camel_case_types
class HabitWithCue_PageState extends State<HabitWithCue_Page> {
  HabitWithCueLog_DBHelper helper = HabitWithCueLog_DBHelper();
  String appBarTitle;
  Habit_with_Cue_log habitLog;
  Habit habitInfo;
  String good = "";
  //---
  String label = "یک عدد صحیح وارد کنید..";
  String selectedDate = Jalali.now().formatFullDate();
  String todayDate = (Jalali.now().year.toString() +
      '/' +
      Jalali.now().month.toString() +
      '/' +
      Jalali.now().day.toString());

  //---
  HabitWithCue_PageState(this.habitLog, this.habitInfo, this.appBarTitle);
//log exist in table or not
  bool doesExist;
  // int id;
  // debugPrint("in page bulder");
  // TextStyle textStyle = Theme.of(context).textTheme.title;
  // TextEditingController cueController = TextEditingController();
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getid(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          debugPrint("in page builder");
          debugPrint(habitLog.habitID.toString());
          TextStyle textStyle = Theme.of(context).textTheme.title;
          TextEditingController cueController = TextEditingController();
          if (snapshot.hasData) {
            debugPrint('Step 3, build widget:s ${snapshot.data}');
            debugPrint("data:" + snapshot.data.toString());
            if (snapshot.data != -1) {
              habitLog.id = snapshot.data;
            }
            // id = snapshot.data;
            // if (id != null) {
            //   // habitLog = Habit_with_Cue_log.withID(id, habitInfo.id, todayDate);
            //   debugPrint("in table");
            //   doesExist = true;
            //   // habitLog.id = id;
            // } else {
            //   // habitLog = Habit_with_Cue_log(habitInfo.id, todayDate);
            // }
            // cueController.text = id.toString();
            // Build the widget with data.
            // Center(
            //   child: Container(child: Text('hasData: ${snapshot.data}')));
          }
          //else
          else {
            // id = null;
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
              debugPrint("1");
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
                backgroundColor: Colors.amber,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  // padding: EdgeInsets.only(right: 200),
                  onPressed: () {
                    debugPrint(
                        this.habitLog.cue.toString() + '---------------');

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
                      SizedBox(
                        height: 20,
                      ),
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
                      Container(
                        height: 40.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 70.0,
                          vertical: 20.0,
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
                      Center(
                          child: Text(
                        "رکورد امروز: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(60.0, 0.0, 30, 0),
                        child: TextField(
                          controller: cueController,
                          style: textStyle,
                          onChanged: (value) {
                            updateCue(int.parse(value));
                            debugPrint(value);
                            debugPrint(this.habitInfo.cue.toString());
                            if (int.parse(value) >= this.habitInfo.cue) {
                              debugPrint('good');
                              good = "آفرین!";
                            } else {
                              debugPrint('not good');
                              good = "";
                            }
                            // updateTitle();
                          },
                          decoration: InputDecoration(
                            labelText: label,
                            labelStyle: textStyle,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.accessibility_new_rounded),
                            ),
                          ),
                        ),
                      ),
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
                              debugPrint(
                                  'in set state =>' + habitLog.id.toString());
                              label = cueController.text;
                              _save();
                            });
                            //query(this.habitLog);
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        margin: EdgeInsets.only(bottom: 0.0),
                        child: CupertinoButton(
                          child: Text("logs"),
                          color: Colors.amber,
                          onPressed: () {
                            setState(() {
                              AddFakeData();

                              // navigateToLogs(habitInfo, "گزارش عادت");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       // builder: (context) => BarChartSample1(),
                              //       ),
                              // );
                              // debugPrint('goning to save:');
                              // _save();
                            });
                          },
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 40.0),
                      //   margin: EdgeInsets.only(bottom: 0.0),
                      //   child: CupertinoButton(
                      //     child: Text("logs"),
                      //     color: Colors.amber,
                      //     onPressed: () {
                      //       setState(() {
                      //         // navigateToLogs(habitInfo, "گزارش عادت");
                      //   //       Navigator.push(
                      //   //           context,
                      //   //           MaterialPageRoute(
                      //   //               // builder: (context) => MyHomePage()));
                      //   //       // debugPrint('goning to save:');
                      //   //       // _save();
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

  void _save() async {
    // moveToLastScreen();
    // int hid = await getid();

    int result;
    debugPrint('save func');
    // debugPrint(hid.toString());
    debugPrint('id=' +
        habitLog.id.toString() +
        ' log status:' +
        habitLog.cue.toString());

    if (habitLog.id != null) {
      debugPrint("habit.id != null");
      // result = await helper.updateHabitLog(habitLog);
      _update();
    } else {
      debugPrint("habit.id != null else");
      // debugPrint(habitLog.habitID.toString() +
      //     habitLog.date +
      //     habitLog.cue.toString());
      result = await helper.insertHabitLog(habitLog);
      if (result != 0) {
        print(this.habitLog);
        _showAlertDialog("با موفقیت ذخیره شد");
        print('thisssssss');
      } else {
        _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
      }
    }
  }

  void _update() async {
    // moveToLastScreen();
    // int delete_result, save_result;

    // habitLog.id = id;
    debugPrint(habitLog.id.toString());
    int delete_result = await helper.deleteHabitLog(habitLog.id);
    int save_result = await helper.insertHabitLog(habitLog);

    if (delete_result != 0 && save_result != 0) {
      _showAlertDialog("گزارش با موفقیت به روز رسانی شد");
    } else {
      _showAlertDialog("متاسفانه خطایی رخ داد");
    }
  }

  void _delete() async {
    // moveToLastScreen();
    int result;
    if (habitLog.id == null) {
      _showAlertDialog("لطفا مقدار رکورد را وارد کنید.");
      return;
    } else {}
    result = await helper.deleteHabitLog(habitLog.id);

    if (result != 0) {
      _showAlertDialog("log با موفقیت حذف شد");
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

  void updateCue(int cue) {
    this.habitLog.cue = cue;
  }

  // void query(Habit_with_Cue_log h) async {
  //   debugPrint("in query");
  //   List<Map<String, Object>> result;
  //   int up;
  //   int ins;
  //   result = await helper.exist(habitLog);
  //   if (result.length != 0) {
  //     result = await helper.exist(habitLog);
  //     // up = await helper.updateHabit(h);
  //     debugPrint(up.toString() + "up");
  //
  //     // ins = await helper.insertHabit(h);
  //     // } else {
  //     //   result = await helper.insertHabit(habit);
  //     // }
  //   } else {
  //     print("null ast");
  //     ins = await helper.insertHabitLog(h);
  //     debugPrint(ins.toString() + "ins");
  //     // _save();
  //     result = await helper.exist(habitLog);
  //   }
  // }

  Future<int> getid() async {
    debugPrint('in get id func');
    int logexist =
        await helper.getID(habitInfo.id, habitLog.date).then((value) {
      debugPrint(value.toString() +
          'value return form exist in getId func----------------------------');
      return value;
    });
    return logexist;
  }

  void AddFakeData() async {
    var fd = await helper.insertHabitLog(Habit_with_Cue_log(1, "1400/3/6", 2));
    fd = await helper.insertHabitLog(Habit_with_Cue_log(5, "1400/3/7", 5));
    fd = await helper.insertHabitLog(Habit_with_Cue_log(2, "1400/3/9", 0));
    fd = await helper.insertHabitLog(Habit_with_Cue_log(3, "1400/3/10", 4));
    var list = helper.getHabitLogsList(habitInfo.id).then((value) {
      return value;
    });
    debugPrint("in page");
    debugPrint(list.toString());
  }
}
