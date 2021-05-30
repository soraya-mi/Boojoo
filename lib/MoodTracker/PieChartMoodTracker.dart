import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/MoodTracker/moodTracker_database.dart';
import 'package:boojoo/MoodTracker/MoodTracker_PieChart_Monthly.dart';
import 'package:boojoo/SideMenu/placeHolder.dart';
import 'package:boojoo/MoodTracker/MoodTracker_PieChart_Yearly.dart';
import 'package:flutter/gestures.dart';
//import 'indicator.dart';
// void main(){
//   runApp(chartMaker());
// }

class chartMaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PieChartSample2(),

    );
  }
}

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;



  @override

  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(

          // brightness: Brightness.light,
          backgroundColor: Colors.amber,
          // elevation: 0,
          bottom:TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // Creates border
                color: Colors.greenAccent),
            tabs:<Widget>[
              Tab(
                text:'گزارش هفتگی',
              ),
              Tab(
                text:'گزارش ماهیانه',
              ),
              Tab(
                text:'گزارش سالیانه',
              ),
            ],
          ),
          leading: Container(
            margin: EdgeInsets.all(5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.withOpacity(0.5),
            ),
            child: IconButton(
              onPressed: () {

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SideMeunPage()),
                // );
                //Navigator.of(context).pop(true);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
             PlaceHolder(),
            chartMakerMonthly(),
            chartMakerYearly(),

          ],
          //children: Containers,
        ),
      ),
    );
  }
}