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
  List<bool> Complpeted = new List();

  @override
  Widget build(BuildContext context) {
    debugPrint("****");
    if (taskList == null) {
      taskList = List<Task>();
      updateListView();
      debugPrint("null");
    }
    Future<bool> _onBackPressed() {
      Navigator.pop(context, false);
    }

    // TODO: implement build
    return WillPopScope(
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // alignment: WrapAlignment.end,
            children: [
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 20.0),
                width: 100.0,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    colorScheme: ColorScheme.light(
                      background: Colors.green,
                    ),
                    buttonColor: Colors.green,
                    hoverColor: Colors.grey,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      iconSize: 20.0,
                      dropdownColor: Colors.amber[100],
                      itemHeight: 50.0,
                      focusColor: Colors.black,
                      value: _chosenValue,
                      elevation: 5,
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
          color: Colors.amber[300], //fromARGB(255, 159, 231, 245),
          elevation: 4.0, shadowColor: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage:
                    NetworkImage("https://learncodeonline.in/mascot.png")),
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
