import 'package:flutter/material.dart';
import 'dart:async';
import 'task-database.dart';
import 'task.dart';
import 'task-details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskDataBaseHelper databaseHelper = TaskDataBaseHelper();
  TaskDataBaseHelper helper = TaskDataBaseHelper();
  List<Task> taskList;
  int count = 0;

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
          title: Text(
            "لیست وظایف",
            style: TextStyle(color: Colors.black),
          ),
          // backgroundColor: Colors.amber,
          // backgroundColor: Color.fromARGB(a, r, g, b),
        ),
        body: getTaskListView(),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.amber,
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
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.lightBlue[300], //fromARGB(255, 159, 231, 245),
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
                            // style: ButtonStyle(
                            //   backgroundColor: MaterialStateProperty.all<Color>(
                            //      Colors.amber,
                            //   ),
                            // ),

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
                            // style: ButtonStyle(
                            //   backgroundColor: MaterialStateProperty.all<Color>(
                            //        Colors.amber),
                            // ),
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
}
