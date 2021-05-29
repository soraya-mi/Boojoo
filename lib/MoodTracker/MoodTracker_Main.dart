import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'moodTracker_database.dart';
import 'moodTracker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
//
// void main() {
//   runApp(MoodTrackere());
// }

MoodTracker moodTracker;

class MoodTrackere extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage_MoodTracker(),
    );
  }
}

class HomePage_MoodTracker extends StatefulWidget {
  String today = DateTime.now().toString(); //change it later
  int moodLogId;
  @override
  _HomePage_MoodTrackerState createState() => _HomePage_MoodTrackerState();
}

class _HomePage_MoodTrackerState extends State<HomePage_MoodTracker> {
  //English date
  String today = DateTime.now().year.toString() +
      '/' +
      DateTime.now().month.toString() +
      '/' +
      DateTime.now().day.toString(); //change it later
  //farse date
  String todayDate = (Jalali.now().year.toString() +
      '/' +
      Jalali.now().month.toString() +
      '/' +
      Jalali.now().day.toString());
  int moodLogId;
  MoodTracker moodTracker;
  MoodTrackerDataBaseHelper moodtrackerDBinstance = MoodTrackerDataBaseHelper();
  var log;

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getid(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          String tmp = "";
          int MoodIdTmp;
          if (snapshot.hasData) {
            moodLogId = snapshot.data;
            debugPrint(moodLogId.toString());
            debugPrint(log.toString());
          } else {
            debugPrint("loading");
          }
          return Scaffold(
            appBar: AppBar(
                brightness: Brightness.light,
                backgroundColor: Colors.transparent,
                elevation: 0,
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
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                )),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'امروز حالت چه طور بود؟',
                    ),
                    SizedBox(height: 50),
                    RatingBar.builder(
                        initialRating: 5,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return Icon(
                                //tmp="sentiment_very_dissatisfied",
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );

                            case 1:
                              return Icon(
                                Icons.sentiment_dissatisfied,
                                color: Colors.deepOrange,
                              );
                            case 2:
                              return Icon(
                                Icons.sentiment_neutral,
                                color: Colors.amber,
                              );
                            case 3:
                              return Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );
                          }
                        },
                        onRatingUpdate: (rating) {
                          //if(rating==0){print("hello");MoodIdTmp=0;}
                          if (rating == 1) {
                            print("hello1");
                            MoodIdTmp = 1;
                          }
                          if (rating == 2) {
                            print("hello2");
                            MoodIdTmp = 2;
                          }
                          if (rating == 3) {
                            print("hello3");
                            MoodIdTmp = 3;
                          }
                          if (rating == 4) {
                            print("hello4");
                            MoodIdTmp = 4;
                          }
                          if (rating == 5) {
                            print("hello5");
                            MoodIdTmp = 5;
                          }
                        }),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber, Colors.yellow],
                          stops: [0, 1],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            SendToDB(MoodIdTmp, today);
                          });
                        },
                        child: Center(
                          child: Text(
                            "ثبت",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  Future<int> getid() async {
    debugPrint('in get id func');
    int id = await moodtrackerDBinstance.getMoodId(today).then((value) {
      return value;
    });
    return id;
  }

  void SendToDB(int EmojiId, String today) async {
    MoodTracker(today, EmojiId);
    if (moodLogId == -1) {
      debugPrint("today is:" + today);
      var inseertVariable =
          await moodtrackerDBinstance.insertMood(MoodTracker(today, EmojiId));
    } else {
      //MoodTracker.withId(ID, Date, EmojiId);
      var updateVariable = await moodtrackerDBinstance
          .updateMood(MoodTracker.withId(moodLogId, today, EmojiId));
    }
    print("me");
    print("///////////////////////////////////////////////");
  }
}

// Future<int> getlog() async {
//   // var inseertVariable = await MoodTrackerDataBaseHelper()
//   //     .insertMood(MoodTracker("2021/11/28", 3));
//   // inseertVariable =
//   //     await MoodTrackerDataBaseHelper().insertMood(MoodTracker("2021/3/25", 3));
//   // inseertVariable =
//   //     await MoodTrackerDataBaseHelper().insertMood(MoodTracker("2021/5/19", 3));
//   var log =
//       await MoodTrackerDataBaseHelper().getMonthlyLog("2021/11/").then((value) {
//     return value;
//   });
//   debugPrint(log.toString());
// }
