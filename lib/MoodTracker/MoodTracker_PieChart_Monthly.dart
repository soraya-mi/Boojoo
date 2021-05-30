import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/MoodTracker/moodTracker_database.dart';
import 'package:flutter/gestures.dart';
import 'package:boojoo/MoodTracker/MoodTracker_Main.dart';
//import 'indicator.dart';
// void main(){
//   runApp(chartMaker());
// }
 int countmood1Monthly=0;
 int countmood2Monthly=0;
 int countmood3Monthly=0;
 int countmood4Monthly=0;
 int countmood5Monthly=0;

void getDataFormMDDB()async {
  MoodTrackerDataBaseHelper moodtrackerDBinstance =  MoodTrackerDataBaseHelper();
  final resDBMoodTracker = await moodtrackerDBinstance.getAllLogsMap();
  final res1DB=await moodtrackerDBinstance.getYearyLog("2021/");
  final res2DB=await moodtrackerDBinstance.getMonthlyLog("2021/5");
  print("??????????????????????????????????/");
  //print(resDBMoodTracker);
  print("??????????????????????????????????/");
  print(res2DB);
  print("??????????????????????????????????/");
  print(((res2DB[res2DB.length-1].values).last).runtimeType);
  if((res2DB[res2DB.length-1].values).last==1)
    countmood1Monthly+=1;
  if((res2DB[res2DB.length-1].values).last==2)
    countmood2Monthly+=1;
  if((res2DB[res2DB.length-1].values).last==3)
    countmood3Monthly+=1;
  if((res2DB[res2DB.length-1].values).last==4)
    countmood4Monthly+=1;
  if((res2DB[res2DB.length-1].values).last==5)
    countmood5Monthly+=1;
  print((res2DB[res2DB.length-1].values).last);
  print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
  print(countmood1Monthly);
  print("MOTHLYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
  print(countmood2Monthly);
  print("MOTHLYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
  print(countmood3Monthly);
  print("MOTHLYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
  print(countmood4Monthly);
  print("MOTHLYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
  print(countmood5Monthly);
  print("MOTHLYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
  // MonthlyList.add(countmood1Monthly);
  // MonthlyList.add(countmood2Monthly);
  // MonthlyList.add(countmood3Monthly);
  // MonthlyList.add(countmood4Monthly);
  // MonthlyList.add(countmood5Monthly);

}
class chartMakerMonthly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //getDataFormMDDB();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PieChartSample2Monthly(),

    );
  }
}

class PieChartSample2Monthly extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2StateMonthly();
}

class PieChart2StateMonthly extends State {
  int touchedIndex = -1;



  @override

  Widget build(BuildContext context) {
    //getDataFormMDDB();
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child:SingleChildScrollView(
          child: Column(

            children: <Widget>[
              const SizedBox(
                height: 2,
              ),
              SingleChildScrollView(
                child: AspectRatio(
                  aspectRatio:1,
                  child: PieChart(
                    PieChartData(

                      // pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                      //   setState(() {
                      //     final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                      //         pieTouchResponse.touchInput is! PointerUpEvent;
                      //     if (desiredTouch && pieTouchResponse.touchedSection != null) {
                      //       touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      //     } else {
                      //       touchedIndex = -1;
                      //     }
                      //   });
                      // }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 5,
                        centerSpaceRadius: 40,
                        sections: showingSections()),
                  ),
                ),
              ),

              Column(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    alignment: Alignment.center,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        ),
                        Text("خیلی ناراضیم "),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    alignment: Alignment.center,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.deepOrange,
                        ),
                        Text(" ناراضیم "),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    alignment: Alignment.center,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        ),
                        Text("معمولیم "),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    alignment: Alignment.center,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        ),
                        Text("راضیم "),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    alignment: Alignment.center,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        ),
                        Text("خیلی راضیم "),

                      ],
                    ),

                  ),
                  SizedBox(height: 20,),

                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      ),
    );

  }

  List<PieChartSectionData> showingSections() {
    getDataFormMDDB();
    List MonthlyList=[countmood1Monthly,countmood2Monthly,countmood3Monthly,countmood4Monthly,countmood5Monthly];
    countmood5Monthly=0;
    countmood4Monthly=0;
    countmood3Monthly=0;
    countmood2Monthly=0;
    countmood1Monthly=0;
    int countmood5MonthlyA=MonthlyList[4];
    int countmood4MonthlyA=MonthlyList[3];
    int countmood3MonthlyA=MonthlyList[2];
    int countmood2MonthlyA=MonthlyList[1];
    int countmood1MonthlyA=MonthlyList[0];
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value:countmood1MonthlyA/1,
            title: '${((countmood1MonthlyA*100)/30).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 0:
          return PieChartSectionData(
            color: Colors.deepOrange,
            value:countmood2MonthlyA/1,
            title: '${((countmood2MonthlyA*100)/30).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),

          );

        case 4:
          return PieChartSectionData(
            color: Colors.amber,
            value: countmood3MonthlyA/1,
            title: '${((countmood3MonthlyA*100)/30).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.lightGreen,
            value: countmood4MonthlyA/1,
            title: '${((countmood4MonthlyA*100)/30).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color:Colors.green,
            value: countmood5MonthlyA/1,
            title: '${((countmood5MonthlyA*100)/30).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        default:
          throw Error();
      }
    }
    );
  }

}