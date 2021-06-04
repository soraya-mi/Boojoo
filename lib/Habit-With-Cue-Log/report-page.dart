import 'package:boojoo/Habit-without-Cue-Log/habit_without_cue_database.dart';
import 'package:boojoo/Habit/habit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'habit_with_cue_page.dart';
import 'habit_with_cue_Log.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class cueReportPage extends StatefulWidget {
  final String appBarTitle;
  final Habit habitInfo;
  cueReportPage(this.habitInfo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return cueReportPageState(this.habitInfo, this.appBarTitle);
  }
}

class cueReportPageState extends State<cueReportPage> {
  cueReportPageState(this.habitInfo, this.appBarTitle);
  HabitWithoutCueLog_DBHelper DBhelper = HabitWithoutCueLog_DBHelper();
  String appBarTitle;
  Habit habitInfo;
  List<charts.Series<ChartLog, String>> _seriesData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<ChartLog, String>>();
    _generateData() {
      var data1 = [
        new ChartLog(20, '1'),
        new ChartLog(20, '2'),
        new ChartLog(20, '3'),
        new ChartLog(20, '4'),
        new ChartLog(20, '5'),
        new ChartLog(20, '6'),
        new ChartLog(20, '7'),
        new ChartLog(20, '8'),
        new ChartLog(20, '9'),
        new ChartLog(20, '10'),
        new ChartLog(20, '11'),
        new ChartLog(20, '12'),
        new ChartLog(20, '13'),
        new ChartLog(20, '14'),
        new ChartLog(20, '15'),
        new ChartLog(20, '16'),
        new ChartLog(20, '17'),
        new ChartLog(20, '18'),
        new ChartLog(20, '19'),
        new ChartLog(20, '20'),
        new ChartLog(20, '21'),
        new ChartLog(20, '22'),
        new ChartLog(20, '23'),
        new ChartLog(20, '24'),
        new ChartLog(20, '25'),
        new ChartLog(20, '26'),
        new ChartLog(20, '27'),
        new ChartLog(20, '28'),
        new ChartLog(20, '29'),
        new ChartLog(20, '30'),
        new ChartLog(20, '31'),
      ];

      _seriesData.add(
        charts.Series(
          domainFn: (ChartLog objHabbit, _) => objHabbit.day,
          measureFn: (ChartLog objHabbit, _) => objHabbit.cue,
          id: '2017',
          data: data1,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          fillColorFn: (ChartLog objHabbit, _) =>
              charts.ColorUtil.fromDartColor(Color(0xff990099)),
        ),
      );
    }

    _generateData();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getLogs(),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasData) {
          } else {}
          return WillPopScope(
            onWillPop: () {
              moveToLastScreen();
            },
            child: Scaffold(
              backgroundColor: Colors.teal[50],
              appBar: AppBar(
                title: Row(
                  children: [
                    // Icon(CupertinoIcons.lo),
                    Text(appBarTitle),
                  ],
                ),
                backgroundColor: Colors.lightBlue.shade600,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  // padding: EdgeInsets.only(right: 200),
                  onPressed: () {
                    moveToLastScreen();
                  },
                ),
              ),
              body: Wrap(
                children: [
                  Text(" "),
                  Text(" "),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            // Expanded(
                            //   child: charts.BarChart(
                            //     _seriesData,
                            //     animate: true,
                            //     barGroupingType:
                            //         charts.BarGroupingType.groupedStacked,
                            //     //behaviors: [new charts.SeriesLegend()],
                            //     animationDuration: Duration(seconds: 5),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Future<List<Habit_with_Cue_log>> getLogs() async {}
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
}

class ChartLog {
  int cue;
  String day;

  ChartLog(this.cue, this.day);
}
