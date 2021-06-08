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
import 'dart:async';
import 'habbit-details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class HabitList extends StatefulWidget {
  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  HabitDataBaseHelper databaseHelper = HabitDataBaseHelper();
  HabitDataBaseHelper helper = HabitDataBaseHelper();
  HabitWithCueLog_DBHelper cueLogHelper = HabitWithCueLog_DBHelper();
  List<Habit> habitList;
  int count = 0;
  String _chosenValue = 'همه';
  String _chosenPriority = 'همه';
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
    }

    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text("لیست عادت ها"),
            backgroundColor: Colors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "گروه:",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.black,
                        ),
                        // color: Colors.black,
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        width: 100.0,
                        height: 40.0,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            // splashColor: Colors.white,
                            // highlightColor: Colors.white,
                            // buttonColor: Colors.white,
                            hoverColor: Colors.grey,
                            // padding: EdgeInsets.all(35.0),
                            // alignedDropdown: true,
                            // materialTapTargetSize: MaterialTapTargetSize.padded,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              iconSize: 30.0,
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                // Icons.arrow_drop_down_circle,
                              ),
                              iconEnabledColor: Colors.white,
                              dropdownColor: Colors.black,
                              itemHeight: 50.0,
                              focusColor: Colors.black,
                              value: _chosenValue,
                              elevation: 5,
                              style: TextStyle(color: Colors.white),
                              items: <String>[
                                'همه',
                                'سلامتی',
                                'کار',
                                'درس',
                                'شخصی',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "لطفا یک دسته را انتخاب کنید",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  habitList.forEach((element) {
                                    void f(item) {
                                      debugPrint(element.category);
                                    }
                                  });
                                  _chosenValue = value;
                                  // helper.getHabitByCategoryList(value);
                                  if (value != 'همه')
                                    updateListViewByCategory(value);
                                  else
                                    (updateListView());
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "اولویت:",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.black,
                        ),
                        // color: Colors.black,
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        width: 100.0,
                        height: 40.0,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            hoverColor: Colors.grey,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              iconSize: 30.0,
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                // Icons.arrow_drop_down_circle,
                              ),
                              iconEnabledColor: Colors.white,
                              dropdownColor: Colors.black,
                              itemHeight: 50.0,
                              focusColor: Colors.black,
                              value: _chosenPriority,
                              elevation: 5,
                              style: TextStyle(color: Colors.white),
                              items: <String>[
                                'همه',
                                'زیاد',
                                'کم',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "لطفا یک دسته را انتخاب کنید",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  habitList.forEach((element) {
                                    void f(item) {
                                      debugPrint(element.category);
                                    }
                                  });
                                  _chosenPriority = value;
                                  // helper.getHabitByCategoryList(value);
                                  if (value != 'همه') {
                                    if (value == 'زیاد')
                                      updateListViewByPriority(1);
                                    else
                                      updateListViewByPriority(2);
                                  } else
                                    (updateListView());
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                getHabitListView(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            onPressed: () {
              navigateToDetail(Habit("", "", "", 1, 0), "اضافه کردن عادت");
              debugPrint("back");
            },
          ),
        ),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeHabitDatabase();
    dbFuture.then((database) {
      Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      // Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      habitListFuture.then((habitList) {
        debugPrint('...');
        setState(() {
          this.habitList = habitList;
          this.count = habitList.length;
        });
      });
      debugPrint('.............4');
    });
  }

  void updateListViewByCategory(String category) {
    final Future<Database> dbFuture = databaseHelper.initalizeHabitDatabase();
    dbFuture.then((database) {
      Future<List<Habit>> habitListFuture =
          databaseHelper.getHabitByCategoryList(category);
      // Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      habitListFuture.then((habitList) {
        debugPrint('...');
        setState(() {
          this.habitList = habitList;
          this.count = habitList.length;
        });
      });
    });
  }

  void updateListViewByPriority(int priority) {
    final Future<Database> dbFuture = databaseHelper.initalizeHabitDatabase();
    dbFuture.then((database) {
      Future<List<Habit>> habitListFuture =
          databaseHelper.getHabitByPriorityList(priority);
      // Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      habitListFuture.then((habitList) {
        debugPrint('...');
        setState(() {
          this.habitList = habitList;
          this.count = habitList.length;
        });
      });
    });
  }

  ListView getHabitListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      // this.habitList[position].priority
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue,
          //        backgroundColor: Color.fromARGB(100, 255, 192, 7),

          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: this.habitList[position].priority == 1
                  ? Colors.red
                  : Colors.green,
              //   NetworkImage(
              //       "https://image.flaticon.com/icons/png/128/3260/3260291.png"),
            ),
            title: Text(
              this.habitList[position].title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            subtitle: Text(
              this.habitList[position].description == null
                  ? ""
                  : this.habitList[position].description.toString(),
              // this.habitList[position].description.toString(),
              style: TextStyle(color: Colors.white),
            ),
            trailing: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30.0,
                  semanticLabel: "Edit",
                ),
              ),
              onTap: () {
                navigateToDetail(this.habitList[position], "ویرایش");
              },
            ),
            onTap: () async {
              debugPrint("pressed");
              Habit currentHabit = this.habitList[position];
              //create date format
              // DateTime now = new DateTime.now();
              // DateTime date = new DateTime(now.year, now.month, now.day);
              // String today = date.year.toString() +
              //     date.month.toString() +
              //     date.day.toString();
              String today = Jalali.now().year.toString() +
                  '/' +
                  Jalali.now().month.toString() +
                  '/' +
                  Jalali.now().day.toString();
              int HabitLogID = await getid(currentHabit.id, today);
              //create habit log object
              debugPrint("on top in habit list");
              debugPrint(currentHabit.type.toString());
              if (currentHabit.type == 0) {
                Habit_without_Cue_log habitlog =
                    Habit_without_Cue_log(currentHabit.id, today);
                navigateToLog(habitlog, currentHabit, "گزارش عادت");
              } else {
                if (HabitLogID != -1) {
                  debugPrint("Habit_with_Cue_log.withID");
                  Habit_with_Cue_log habitCuelog = Habit_with_Cue_log.withID(
                      HabitLogID, currentHabit.id, today);
                  navigateToCueLog(habitCuelog, currentHabit, "گزارش عادت");
                } else {
                  debugPrint("Habit_with_Cue_log");
                  Habit_with_Cue_log habitCuelog =
                      Habit_with_Cue_log(currentHabit.id, today);
                  navigateToCueLog(habitCuelog, currentHabit, "گزارش عادت");
                }
              }
            },
          ),
        );
      },
      scrollDirection: Axis.vertical,
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

  Future<int> getid(int id, String Date) async {
    debugPrint('in get id func');
    int logexist = await cueLogHelper.getID(id, Date).then((value) {
      debugPrint(value.toString() +
          'value return form exist in getId func----------------------------');
      return value;
    });
    // var result = await helper.getHabitLogsMap(habitInfo.id);
    // debugPrint(logexist.toString() + '---------------/////////////');
    // return logexist;
    debugPrint(logexist.toString());
    return logexist;
  }

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
      return HabitWithCue_Page(
          habitLog, habitinfo, "   گزارش عادت   "); //habitLog,
    }));
    if (result == true) {
      updateListView();
    } else if (result == null) {
      debugPrint("خطا");
    }
  }
}
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
