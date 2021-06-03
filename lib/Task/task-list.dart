import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'dart:async';
import 'task-database.dart';
import 'task.dart';
import 'task-details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
  String _chosenValue = 'همه';
}

class _TaskListState extends State<TaskList> {
  TaskDataBaseHelper databaseHelper = TaskDataBaseHelper();
  TaskDataBaseHelper helper = TaskDataBaseHelper();
  List<Task> taskList;
  int count = 0;
  List<bool> Complpeted = new List();
  String _chosenValue = 'همه';
  String _chosenDate = 'همه';
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

  @override
  Widget build(BuildContext context) {
    // Complpeted.add(false);

    debugPrint("****");
    if (taskList == null) {
      taskList = List<Task>();
      updateListView();
      debugPrint("null");
    }
    List<bool> completed;

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

    // if (Complpeted != []) updateCompleted();
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.end,
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
                      value: _chosenDate,
                      elevation: 5,
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

                          _chosenDate = value;
                          String selectedDate = Jalali.now().year.toString() +
                              '/' +
                              Jalali.now().month.toString() +
                              '/' +
                              Jalali.now().day.toString();
                          // helper.getHabitByCategoryList(value);
                          if (value != 'همه')
                            updateListViewByDate(value);
                          else
                            (updateListView());
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
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),

          color: Colors.lightBlue[300], //fromARGB(255, 159, 231, 245),
          color: this.Complpeted[position]
              ? Colors.green
              : Colors.amber, //fromARGB(255, 159, 231, 245),
          //this.Complpeted[position]
          //               ? Colors.amber[300]

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
                              Complpeted[position] = false,
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
                              Complpeted[position] = true,
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

//functions
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

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeTaskDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        debugPrint('...');
        setState(() {
          this.taskList = taskList;
          this.count = taskList.length;
          // for (int i = 0; i < taskList.length; i++) {
          //   Complpeted.add(false);
          //   debugPrint(i.toString() + Complpeted[i].toString());
          // }
        });
      });
    });
  }

  void updateCompleted() {
    setState(() {
      debugPrint("--------------");
      debugPrint(taskList.length.toString());
      for (int i = 0; i < taskList.length; i++) {
        // Complpeted.add(taskList[i].completed == 0);
        // Complpeted.insert(i, true);
        // Complpeted.add(this.taskList[i].completed == 0);
        if (Complpeted.length != 0)
          debugPrint(i.toString() + Complpeted[i].toString());
        debugPrint("t" + taskList.length.toString());
      }
    });
  }

  void updateListViewByCategory(String category) {
    final Future<Database> dbFuture = databaseHelper.initalizeTaskDatabase();
    dbFuture.then((database) {
      Future<List<Task>> habitListFuture =
          databaseHelper.getTaskByCategoryList(category);
      // Future<List<Habit>> habitListFuture = databaseHelper.getHabitList();
      habitListFuture.then((habitList) {
        debugPrint('...');
        setState(() {
          this.taskList = habitList;
          this.count = habitList.length;
        });
      });
    });
  }

  void updateListViewByDate(String date) {
    final Future<Database> dbFuture = databaseHelper.initalizeTaskDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture =
          databaseHelper.getTodayTasksList(date);
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
// Container(
//   // color: Colors.black,
//   alignment: Alignment.topRight,
//   padding: const EdgeInsets.only(right: 20.0),
//   width: 100.0,
//   child: DropdownButtonHideUnderline(
//     child: ButtonTheme(
//       // splashColor: Colors.white,
//       // highlightColor: Colors.white,
//       // buttonColor: Colors.white,
//       hoverColor: Colors.grey,
//       // padding: EdgeInsets.all(35.0),
//       // alignedDropdown: true,
//       // materialTapTargetSize: MaterialTapTargetSize.padded,
//       child: DropdownButton<String>(
//         isExpanded: true,
//         iconSize: 20.0,
//         dropdownColor: Colors.amber[100],
//         itemHeight: 50.0,
//         focusColor: Colors.black,
//         value: _chosenValue,
//         elevation: 5,
//         style: TextStyle(color: Colors.black),
//         iconEnabledColor: Colors.black,
//         items: <String>[
//           'همه',
//           'سلامتی',
//           'کار',
//           'درس',
//           '1',
//           'شخصی',
//         ].map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(
//               value,
//               style: TextStyle(color: Colors.black),
//             ),
//           );
//         }).toList(),
//         hint: Text(
//           "لطفا یک دسته را انتخاب کنید",
//           style: TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//               fontWeight: FontWeight.w500),
//         ),
//         onChanged: (String value) {
//           setState(() {
//             taskList.forEach((element) {
//               void f(item) {
//                 debugPrint(element.category);
//               }
//             });
//             _chosenValue = value;
//             // helper.getHabitByCategoryList(value);
//             if (value != 'همه')
//               updateListViewByCategory(value);
//             else
//               (updateListView());
//           });
//         },
//       ),
//     ),
//   ),
// ),
// String selectedDate = Jalali.now().formatFullDate();
