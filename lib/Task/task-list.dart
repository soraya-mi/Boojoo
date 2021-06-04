import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'task-database.dart';
import 'task.dart';
import 'task-details.dart';
import 'package:boojoo/SubTask/subTask_database.dart';
import 'package:boojoo/SubTask/subTask_list.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskDataBaseHelper databaseHelper = TaskDataBaseHelper();
  TaskDataBaseHelper helper = TaskDataBaseHelper();
  SubTaskDataBaseHelper subTaskdatabaseHelper = SubTaskDataBaseHelper();
  List<Task> taskList;
  int count = 0;
  String _chosenValue = 'همه';
  String _chosenDate = 'همه';
  List<bool> Complpeted = new List();
  String label;
  String selectedDate = Jalali.now().formatFullDate();
  @override
  Widget build(BuildContext context) {
    debugPrint("****");
    if (taskList == null) {
      taskList = List<Task>();
      updateListView();
      debugPrint("****//");
      debugPrint(this.count.toString());
      for (int i = 0; i < this.count; i++) {
        debugPrint("//****//");
        debugPrint(i.toString());
        // this.Complpeted.add(this.taskList[i].completed == 0 ? true : false);
      }
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
            title: Text(
              "لیست وظایف",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amber,
            // backgroundColor: Color.fromARGB(a, r, g, b),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // alignment: WrapAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "دسته",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                      width: 10.0,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      width: 90.0,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          colorScheme: ColorScheme.light(
                            background: Colors.green,
                          ),
                          buttonColor: Colors.green,
                          hoverColor: Colors.grey,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 25.0,
                            dropdownColor: Colors.amber[100],
                            itemHeight: 50.0,
                            focusColor: Colors.black,
                            value: _chosenValue,
                            elevation: 3,
                            style: TextStyle(color: Colors.black),
                            iconEnabledColor: Colors.black,
                            items: <String>[
                              'همه',
                              'سلامتی',
                              'کار',
                              'درس',
                              'شخصی',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                onTap: () {
                                  debugPrint("value" + value + _chosenValue);
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                  debugPrint(value + " " + _chosenValue);
                                },
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
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
                                taskList.forEach((element) {
                                  void f(item) {
                                    debugPrint('++' + element.category);
                                    // _chosenValue = value;
                                    debugPrint("/././." + value);
                                  }
                                });
                                _chosenValue = value;
                                // helper.getHabitByCategoryList(value);
                                if (value != 'همه') {
                                  debugPrint("in hame");
                                  // updateListView();
                                  updateListViewByCategory(value);
                                } else
                                  updateListView();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "تاریخ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      width: 90.0,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          colorScheme: ColorScheme.light(
                            background: Colors.green,
                          ),
                          buttonColor: Colors.green,
                          hoverColor: Colors.grey,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 25.0,
                            dropdownColor: Colors.amber[100],
                            itemHeight: 50.0,
                            focusColor: Colors.black,
                            value: _chosenDate,
                            elevation: 3,
                            style: TextStyle(color: Colors.black),
                            iconEnabledColor: Colors.black,
                            items: <String>[
                              'همه',
                              'امروز',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                onTap: () {
                                  debugPrint("value" + value + _chosenDate);
                                  setState(() {
                                    _chosenDate = value;
                                  });
                                  debugPrint(value + " " + _chosenDate);
                                },
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "لطفا یک تاریخ را انتخاب کنید",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                taskList.forEach((element) {
                                  void f(item) {
                                    // debugPrint('++' + element.category);
                                    // _chosenValue = value;
                                    // debugPrint("/././." + value);
                                  }
                                });
                                _chosenDate = value;
                                // helper.getHabitByCategoryList(value);
                                if (value != 'همه') {
                                  debugPrint("in hame");
                                  // updateListView();
                                  String today = Jalali.now().year.toString() +
                                      '/' +
                                      Jalali.now().month.toString() +
                                      '/' +
                                      Jalali.now().day.toString();
                                  debugPrint(today);
                                  updateListViewByDate(today);
                                } else
                                  updateListView();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ElevatedButton(
                        // color: Colors.teal,
                        onPressed: () async {
                          Jalali picked = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1385, 8),
                            lastDate: Jalali(1450, 9),
                          );
                          if (picked != null && picked != selectedDate)
                            setState(() {
                              label = picked.formatFullDate();
                              String today = picked.year.toString() +
                                  '/' +
                                  picked.month.toString() +
                                  '/' +
                                  picked.day.toString();
                              updateListViewByDate(today);
                            });
                        },
                        child: Text('تاریخ '),
                      ),
                    ),
                  ],
                ),
                getTaskListView(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber,
            child: Icon(Icons.add),
            onPressed: () {
              navigateToDetail(Task("", "", "", "", 2), "اضافه کردن وظیفه");
            },
          ),
        ),
      ),
    );
  }

  ListView getTaskListView() {
    return ListView.builder(
      //ReorderableListView.builder
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: this.taskList[position].completed == 1
              ? Colors.green
              : Colors.amber[300],
          // this.Complpeted[position] ? Colors.green : Colors.amber[300],
          // this.Complpeted[position]
          //     ? Colors.green
          //     : Colors.amber[300], //fromARGB(255, 159, 231, 245),
          //this.Complpeted[position]
          //               ? Colors.green
          elevation: 4.0, shadowColor: Colors.white,
          child: ListTile(
            // leading: CircleAvatar(
            //     backgroundImage:
            //         NetworkImage("https://learncodeonline.in/mascot.png")),
            title: Text(
              this.taskList[position].title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            subtitle: Text(
              "",
              // this.taskList[position].description.toString(),
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
                navigateToDetail(this.taskList[position], "ویرایش");
              },
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("آیا وظیفه کامل شد؟"),
                  actions: <Widget>[
                    //"no" button
                    Center(
                      child: Row(
                        children: [
                          TextButton(
                            child: Text(
                              "خیر",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            // onPressed: () => Navigator.pop(context, false),
                            onPressed: () => {
                              this.taskList[position].completed = 0,
                              updateListView(),
                              updateTask(this.taskList[position]),
                              debugPrint(
                                  this.taskList[position].completed.toString()),
                              Navigator.pop(context, false),
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.amber,
                              ),
                            ),

                            // color: Colors.green,
                          ),
                          SizedBox(
                            width: 140,
                          ),
                          //"yes" button
                          TextButton(
                            child: Text(
                              "بله",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () => {
                              // debugPrint("fffffff"),
                              this.taskList[position].completed = 1.toInt(),
                              // debugPrint(this.taskList[position].title.toString()),
                              updateListView(),
                              updateTask(this.taskList[position]),
                              // updateTask(this.taskList[position]);
                              Navigator.pop(context, true),
                            },
                            // Navigator.pop(context, true),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void updateTask(Task task) async {
    // moveToLastScreen();
    // note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (task.id != null) {
      result = await helper.updateTask(task);
    } else {
      result = await helper.insertTask(task);
    }

    // if (result != 0) {
    //   print(this.task);
    //   // _showAlertDialog("با موفقیت ذخیره شد");
    //   print(this.task);
    // } else {
    //   // _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
    // }
  }

  void navigateToDetail(Task task, String title) async {
    debugPrint(task.title);
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskDetail(task, title);
    }));
    if (result == true) {
      updateListView();
    } else if (result == null) {
      Text("وظیفه ای برای نمایش وجود ندارد");
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeTaskDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        debugPrint('...');
        setState(() {
          this.taskList = taskList;
          this.count = taskList.length;
          // debugPrint("//////////////////////");
          // debugPrint(taskList.toString());
          // for (int i = 0; i < count; i++) {
          //   Complpeted[i] = (taskList[i].completed == 1 ? true : false);
          //   // debugPrint(Task.fromMapObject(taskMapList[i]).toString());
          // }
          // debugPrint("))))))))))");
          // debugPrint(Complpeted.toString());
          // debugPrint(count.toString());
          // debugPrint(Complpeted.toString());
        });
      });
    });
  }

  void updateListViewByCategory(String category) {
    final Future<Database> dbFuture = databaseHelper.initalizeTaskDatabase();
    dbFuture.then((database) {
      Future<List<Task>> habitListFuture =
          databaseHelper.getTaskByCategoryList(category);
      // Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      habitListFuture.then((taskList) {
        debugPrint('...');
        setState(() {
          this.taskList = taskList;
          this.count = taskList.length;
        });
      });
    });
  }

  void updateListViewByDate(String Date) {
    final Future<Database> dbFuture = databaseHelper.initalizeTaskDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture =
          databaseHelper.getTodayTasksList(Date);
      // Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      taskListFuture.then((taskList) {
        debugPrint('...');
        setState(() {
          this.taskList = taskList;
          this.count = taskList.length;
        });
      });
    });
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
