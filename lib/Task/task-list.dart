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
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.black,
                      ),
                      width: 100.0,
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.black,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            minWidth: 40.0,
                            colorScheme: ColorScheme.light(
                              background: Colors.green,
                            ),
                            buttonColor: Colors.green,
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
                              value: _chosenValue,
                              elevation: 5,
                              style: TextStyle(color: Colors.black),
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
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
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
                                      // _chosenValue = value;
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
                    ),
                    Text(
                      "تاریخ",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.black,
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
                      child: Text(
                        'تاریخ ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.0,
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
        // final item = taskList[position];

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: this.taskList[position].completed == 1
              ? Colors.green
              : Colors.amber,
          elevation: 4.0,
          shadowColor: Colors.white,
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
                              debugPrint("fffffff"),
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
            onLongPress: () {
              debugPrint("long");
              navigateToSubTask(taskList[position]);
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

  void _delete(Task task) async {
    // moveToLastScreen();
    debugPrint(task.id.toString());
    // if (task.id == null) {
    //   _showAlertDialog("لطفا عنوان وظیفه را وارد کنید");
    //   return;
    // }
    int result = await helper.deleteTask(task.id);
    int deleteSubTasks =
        await subTaskdatabaseHelper.deleteAllSubTasksOfTask(task.id);
    if (result != 0 && deleteSubTasks != 0) {
      _showAlertDialog("وظیفه با موفقیت حذف شد");
      updateListView();
    } else {
      _showAlertDialog("متاسفانه خطایی رخ داد");
    }
  }

  void navigateToSubTask(Task task) async {
    debugPrint(task.title);
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return subTaskList(task);
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
          debugPrint("error?");
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
      debugPrint(count.toString());
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

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      // title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
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
//dismissable
// return Dismissible(
// key: Key(item.id.toString()),
// direction: DismissDirection.endToStart,
// confirmDismiss: (direction) async {
// // this.subTaskList[position].completed = 1;
// // _delete(subTaskList[position]);
// // taskList.remove(taskList[position]);
// // int p = position;
// // _delete(this.taskList[position]);
// // taskList.removeAt(p);
// debugPrint("confdis");
// updateListView();
// setState(() {
// // if (p != 0) {
// //   debugPrint("000000000000000");
// //   updateListView();
// // }
// });
// return true;
// },
// onDismissed: (direction) {
// if (direction == DismissDirection.endToStart) {
// setState(() {
// _delete(taskList[position]);
// });
// // Remove the item from the data source.+
// debugPrint("dis");
// updateListView();
// }
// ;
// },
// background: Container(
// margin: EdgeInsets.symmetric(
// vertical: 2.7,
// ),
// color: Colors.redAccent[100],
// // padding: EdgeInsets.only(left: 16),
// child: Align(
// child: Icon(
// Icons.delete_rounded,
// color: Colors.black,
// ),
// alignment: Alignment.centerLeft,
// ),
// ),
//pick PDatePickerEntryMode
// Container(
//   alignment: Alignment.topRight,
//   padding: const EdgeInsets.only(right: 20.0),
//   width: 90.0,
//   child: DropdownButtonHideUnderline(
//     child: ButtonTheme(
//       colorScheme: ColorScheme.light(
//         background: Colors.green,
//       ),
//       buttonColor: Colors.green,
//       hoverColor: Colors.grey,
//       child: DropdownButton<String>(
//         isExpanded: true,
//         iconSize: 25.0,
//         dropdownColor: Colors.amber[100],
//         itemHeight: 50.0,
//         focusColor: Colors.black,
//         value: _chosenDate,
//         elevation: 3,
//         style: TextStyle(color: Colors.black),
//         iconEnabledColor: Colors.black,
//         items: <String>[
//           'همه',
//           'امروز',
//         ].map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             onTap: () {
//               debugPrint("value" + value + _chosenDate);
//               setState(() {
//                 _chosenDate = value;
//               });
//               debugPrint(value + " " + _chosenDate);
//             },
//             child: Text(
//               value,
//               style: TextStyle(color: Colors.black),
//             ),
//           );
//         }).toList(),
//         hint: Text(
//           "لطفا یک تاریخ را انتخاب کنید",
//           style: TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//               fontWeight: FontWeight.w500),
//         ),
//         onChanged: (String value) {
//           setState(() {
//             taskList.forEach((element) {
//               void f(item) {
//                 // debugPrint('++' + element.category);
//                 // _chosenValue = value;
//                 // debugPrint("/././." + value);
//               }
//             });
//             _chosenDate = value;
//             // helper.getHabitByCategoryList(value);
//             if (value != 'همه') {
//               debugPrint("in hame");
//               // updateListView();
//               String today = Jalali.now().year.toString() +
//                   '/' +
//                   Jalali.now().month.toString() +
//                   '/' +
//                   Jalali.now().day.toString();
//               debugPrint(today);
//               updateListViewByDate(today);
//             } else
//               updateListView();
//           });
//         },
//       ),
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(right: 20.0),
//   child: RaisedButton(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(30),
//     ),
//     color: Colors.amber,
//     onPressed: () async {
//       setState(() {
//         String today = Jalali.now().year.toString() +
//             '/' +
//             Jalali.now().month.toString() +
//             '/' +
//             Jalali.now().day.toString();
//         debugPrint(today);
//         updateListViewByDate(today);
//       });
//     },
//     child: Text('امروز'),
//   ),
// ),
