import 'package:flutter/cupertino.dart';
import '../Habit/habit.dart';
import 'package:flutter/widgets.dart';
import '../Habit-without-Cue-Log/habit_without_cue_Log.dart';
import '../Habit-without-Cue-Log/habit_without_cue_database.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

// ignore: camel_case_types
class HabitWithoutCue_LogPage extends StatefulWidget {
  final String appBarTitle;
  final Habit habitInfo;
  HabitWithoutCue_LogPage(this.habitInfo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return HabitWithoutCue_LogPageState(this.habitInfo, this.appBarTitle);
  }
}

class HabitWithoutCue_LogPageState extends State<HabitWithoutCue_LogPage> {
  HabitWithoutCueLog_DBHelper helper = HabitWithoutCueLog_DBHelper();
  String appBarTitle;
  Habit habitInfo;
  HabitWithoutCue_LogPageState(this.habitInfo, this.appBarTitle);
  int id;
  double successfulDays = 0, failedDays = 0, noActiveDays;
  // noActiveDays=
  String todayDate = (Jalali.now().year.toString() +
      '/' +
      Jalali.now().month.toString() +
      '/' +
      Jalali.now().day.toString());

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getlogs(),
        builder: (context, AsyncSnapshot<List<Map<String, Object>>> snapshot) {
          if (snapshot.hasData) {
            debugPrint('Step 33, build widget: ${snapshot.data}');
            debugPrint(snapshot.data.toString() + '**');
            id = snapshot.data.length;
            debugPrint(id.toString());
            // debugPrint('values 1:' + snapshot.data[0].values.first.toString());
            // debugPrint('values 2:' + snapshot.data[0].values.last.toString());
            //assign values to pie chart variables

            if (snapshot.data.length == 2) {
              String sd = snapshot.data[0].values.first
                  .toString(); //snapshot.data[0].toString()
              String fd = snapshot.data[1].values.first
                  .toString(); //snapshot.data[1].toString()
              debugPrint("sd" + sd);
              debugPrint("sd" + fd);
              successfulDays = double.parse(sd);
              failedDays = double.parse(fd);
              debugPrint('sd:' + sd + '  ' + fd);
            }
            //if logs list has one row(all los are success ar all of ligs are failed
            else if (snapshot.data.length == 1) {
              debugPrint("all failed");
              if (snapshot.data[0].values.last == 1) {
                String sd = snapshot.data[0].values.first
                    .toString(); //snapshot.data[0].toString()
                String fd = "0";
                debugPrint("sd" + sd);
                debugPrint("fd" + fd);
                successfulDays = double.parse(sd);
                failedDays = double.parse(fd);
                debugPrint('sd:' + sd + '  ' + fd);
              } else {
                debugPrint("all successed");
                String fd = snapshot.data[0].values.first
                    .toString(); //snapshot.data[0].toString()
                String sd = "0";
                debugPrint("sd" + sd);
                debugPrint("sd" + fd);
                successfulDays = double.parse(sd);
                failedDays = double.parse(fd);
                debugPrint('sd:' + sd + '  ' + fd);
              }
            }
            //No data
            else if (snapshot.data.length == 0) {
              debugPrint("No data");
              successfulDays = 0;
              failedDays = 0;
            }
          }

          // String sd = snapshot.data[0].values.first
          //     .toString(); //snapshot.data[0].toString()
          // String fd = snapshot.data[1].values.first
          //     .toString(); //snapshot.data[1].toString()
          // debugPrint("sd" + sd);
          // debugPrint("sd" + fd);
          // successfulDays = double.parse(sd);
          // failedDays = double.parse(fd);
          // debugPrint('sd:' + sd + '  ' + fd);
          //
          // debugPrint(successfulDays.toString() + 'good days');

          //else
          else {
            id = null;
            // debugPrint('Step 1, build loading widget ...waiting');
            if (AsyncSnapshot.waiting() != null) {
              debugPrint('wait nist');
              debugPrint('Step 333, build widget:s ${snapshot.data}');
              successfulDays = 0;
              failedDays = 0;
            } else // We can show the loading view until the data comes back.
            {
              debugPrint('Step 1, build loading widget ...waiting');
              return CircularProgressIndicator();
            }
          }
          Map<String, double> dataMap = {
            "روزهای موفق": successfulDays,
            "روزهای ناموفق": failedDays,
            // "روزهای بدون فعالیت": noActiveDays,
          };
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
                      Text("this.habitInfo.priority.toString()"),
                      Text(this.habitInfo.priority.toString()),
                      Divider(color: Colors.red),
                      //today

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
                          "گزارش کلی وضعیت عادت :",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 2.2,
                        initialAngleInDegree: 0,
                        chartType: ChartType.disc,
                        ringStrokeWidth: 50,
                        centerText: "گزارش عادت",
                        colorList: [
                          Colors.green,
                          Colors.red,
                          Colors.black26,
                        ],
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: true,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: true,
                          decimalPlaces: 1,
                        ),
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                          // legendShape: _BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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

  Future<List<Map<String, Object>>> getlogs() async {
    debugPrint('in get logs func');
    var logs = await helper.getHabitLogsMap(habitInfo.id).then((value) {
      debugPrint(value.toString() +
          'value return form exist in getId func----------------------------');
      return value;
    });
    debugPrint(logs.toString() + '---------------/////////////');
    return logs;
  }
}
