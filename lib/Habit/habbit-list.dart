import 'package:flutter/material.dart';
import '../Habit-With-Cue-Log/habit_with_cue_database.dart';
import '../Habit-without-Cue-Log/habit_without_cue_database.dart';
import '../Habit-With-Cue-Log/habit_with_cue_Log.dart';
import '../Habit-without-Cue-Log/habit_without_cue_page.dart';
import '../Habit-without-Cue-Log/habit_without_cue_Log.dart';
// import 'package:self_development/screens/tetstHabitlog.dart';
import 'dart:async';
import 'habit-database.dart';
import 'habit.dart';
import 'habbit-details.dart';
import 'package:sqflite/sqflite.dart';
import '../Habit-With-Cue-Log/habit_with_cue_page.dart';

class HabitList extends StatefulWidget {
  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  HabitDataBaseHelper databaseHelper = HabitDataBaseHelper();
  HabitDataBaseHelper helper = HabitDataBaseHelper();
  List<Habit> habitList;
  int count = 0;

  void navigateToDetail(Habit habit, String title) async {
    debugPrint(habit.title);
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HabitDetail(habit, title);
    }));
    if (result == true) {
      updateListView();
    } else if (result == null) {
      Text("عادتی برای نمایش وجود ندارد. یک عادت جدید ایجاد کنید.");
    }
  }

  void navigateToLog(
      Habit_without_Cue_log habitLog, Habit habitinfo, String title) async {
    debugPrint("navigate to page in list called");

    bool result;
    result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      // return HabitWithoutCue_Page(habitLog, habitinfo, "title");
      return HabitWithoutCue_Page(habitLog, habitinfo, "   گزارش عادت   ");
      // HabitWithoutCue_Page(habitLog, habitinfo, "   گزارش عادت   ");
    }));
    if (result == true) {
      updateListView();
    } else if (result == null) {
      debugPrint("خطا");
    }
  }

  void navigateToCueLog(
      Habit_with_Cue_log habitLog, Habit habitinfo, String title) async {
    debugPrint("navigate to cue page in list called");

    bool result;
    result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      // return HabitWithoutCue_Page(habitLog, habitinfo, "title");
      return HabitWithCue_Page(habitLog, habitinfo, "   گزارش عادت   ");
    }));
    if (result == true) {
      updateListView();
    } else if (result == null) {
      debugPrint("خطا");
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeHabitDatabase();
    dbFuture.then((database) {
      Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      habitListFuture.then((habitList) {
        debugPrint('...');
        setState(() {
          this.habitList = habitList;
          this.count = habitList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("****");
    if (habitList == null) {
      habitList = List<Habit>();
      updateListView();
      debugPrint("null");
    }
    Future<bool> _onBackPressed() {
      Navigator.pop(context, false);
      // return showDialog(
      //   context: context,
      //   // builder: (context) => AlertDialog(
      //   //   title: Text("آیا میخواهید خارج شوید؟"),
      //   //   actions: <Widget>[
      //   //     FlatButton(
      //   //         child: Text(
      //   //           "خیر",
      //   //           style: TextStyle(
      //   //             color: Colors.white,
      //   //           ),
      //   //         ),
      //   //         onPressed: () => Navigator.pop(context, false),
      //   //         color: Colors.green),
      //   //     FlatButton(
      //   //       child: Text(
      //   //         "بله",
      //   //         style: TextStyle(
      //   //           color: Colors.white,
      //   //         ),
      //   //       ),
      //   //       onPressed: () => Navigator.pop(context, true),
      //   //       color: Colors.redAccent,
      //   //     ),
      //   //   ],
      //   // ),
      // );
    }

    // TODO: implement build
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("لیست عادت ها"),
          // backgroundColor: Colors.amber,
        ),
        body: getHabitListView(),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.amber,
          child: Icon(Icons.add),
          onPressed: () {
            navigateToDetail(Habit("", "", "", 1, 0), "اضافه کردن عادت");
            debugPrint("back");
          },
        ),
      ),
    );
  }

  ListView getHabitListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.lightBlue[
              300], //        backgroundColor: Color.fromARGB(100, 255, 192, 7),

          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://image.flaticon.com/icons/png/128/3260/3260291.png")),
            title: Text(
              this.habitList[position].title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            subtitle: Text(
              "",
              // this.habitList[position].description.toString(),
              style: TextStyle(color: Colors.white),
            ),
            trailing: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                navigateToDetail(this.habitList[position], "ویرایش");
              },
            ),
            onTap: () {
              debugPrint("pressed");
              Habit currentHabit = this.habitList[position];
              //create date format
              DateTime now = new DateTime.now();
              DateTime date = new DateTime(now.year, now.month, now.day);
              String today = date.year.toString() +
                  date.month.toString() +
                  date.day.toString();
              debugPrint(today);
              //create habit log object
              debugPrint("on top in habit list");
              debugPrint(currentHabit.type.toString());
              if (currentHabit.type == 0) {
                Habit_without_Cue_log habitlog =
                    Habit_without_Cue_log(currentHabit.id, today);
                navigateToLog(habitlog, currentHabit, "گزارش عادت");
              } else {
                Habit_with_Cue_log habitCuelog =
                    Habit_with_Cue_log(currentHabit.id, today);
                navigateToCueLog(habitCuelog, currentHabit, "گزارش عادت");
              }
            },
          ),
        );
      },
    );
  }

  void updateHabit(Habit habit) async {
    // moveToLastScreen();
    // note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (habit.id != null) {
      result = await helper.updateHabit(habit);
    } else {
      result = await helper.insertHabit(habit);
    }

    // if (result != 0) {
    //   print(this.habit);
    //   // _showAlertDialog("با موفقیت ذخیره شد");
    //   print(this.habit);
    // } else {
    //   // _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
    // }
  }
}
