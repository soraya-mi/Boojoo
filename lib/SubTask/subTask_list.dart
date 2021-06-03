import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'subTask.dart';
import '../Task/task-database.dart';
import '../Task//task.dart';
import 'package:sqflite/sqflite.dart';
import 'subTask_database.dart';

class subTaskList extends StatefulWidget {
  final Task task;
  subTaskList(this.task);

  @override
  // _subTaskListState createState() => _subTaskListState();
  State<StatefulWidget> createState() {
    return subTaskListState(this.task);
  }
}

class subTaskListState extends State<subTaskList> {
  subTaskListState(this.task);
  SubTaskDataBaseHelper databaseHelper = SubTaskDataBaseHelper();
  TaskDataBaseHelper taskDB = TaskDataBaseHelper();
  List<SubTask> subTaskList;
  Task task;
  int count = 0;
  // TextEditingController subTaskNameController = TextEditingController();
  String newSubTask;
  @override
  Widget build(BuildContext context) {
    debugPrint("****");
    if (subTaskList == null) {
      subTaskList = List<SubTask>();
      updateListView();
      debugPrint("null");
    }
    Future<bool> _onBackPressed() {
      Navigator.pop(context, false);
    }

    // updateListView();
    TextEditingController subTaskNameController = TextEditingController();
    debugPrint(task.title);
    debugPrint(task.toString() + "lllllllllllllll");
    // debugPrint(task.title.length.toString());
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            // "Dfd",
            task.title.length == 0 ? "" : task.title,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Text("توضیح" +
                            (task.description == null ? "" : task.description)),
                        Divider(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("تاریخ:  " +
                                (task.date == null ? "" : (task.date))),
                            Text("شروع :  " +
                                (task.startTime == null ? "" : task.startTime)),
                            Text("  پایان :  " +
                                (task.endTime == null ? "" : task.endTime)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "وضعیت :   " +
                                  (task.completed == 0
                                      ? "انجام نشده"
                                      : "انجام شده"),
                            ),
                            Text(
                              "اولویت : " +
                                  (task.priority == null
                                      ? ""
                                      : (task.priority == 2 ? "کم" : "زیاد")),
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              controller: subTaskNameController,
                              // style: textStyle,
                              onChanged: (value) {
                                // if(value!=null){}
                                newSubTask = value;
                                // return value;
                                // this.
                                // updateTitle();
                              },
                              // textDirection: TextDirection.RTL,
                              decoration: InputDecoration(
                                labelText: 'نام زیر وظیفه',
                                // labelStyle: textStyle,
                              ),
                            ),
                          ),
                        ),
                        //
                        ElevatedButton(
                          // textColor: Colors.white,
                          // color: Colors.teal[300],
                          // padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            debugPrint("Save button clicked");
                            setState(() {
                              debugPrint("Save button clicked");
                              if (newSubTask != null) {
                                saveSubTask(SubTask(this.task.id, newSubTask));
                                updateListView();
                              } else {
                                _showAlertDialog(
                                    "لطفا نام زیر وظیفه را وارد کنید");
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(child: getTaskListView()),
          ],
        ),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeSubTaskDatabase();
    dbFuture.then((database) {
      Future<List<SubTask>> taskListFuture =
          databaseHelper.getSubTasksList(task.id);
      taskListFuture.then((subtaskList) {
        debugPrint('...');
        setState(() {
          this.subTaskList = subtaskList;
          this.count = subtaskList.length;
        });
      });
    });
  }

  // int getSubTaskId()
  ListView getTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      //ReorderableListView.builder
      itemCount: count,
      itemBuilder: (context, position) {
        final item = subTaskList[position];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Dismissible(
                key: Key(item.name),
                direction: DismissDirection.startToEnd,
                confirmDismiss: (direction) async {
                  // this.subTaskList[position].completed = 1;
                  // _delete(subTaskList[position]);
                  _delete(this.subTaskList[position]);
                  updateListView();
                  return true;
                },
                onDismissed: (direction) {
                  // Remove the item from the data source.+
                  updateListView();
                  setState(() {});
                },
                background: Container(
                  color: Colors.redAccent[100],
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    child: Icon(
                      Icons.delete_rounded,
                      color: Colors.black,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: Card(
                  margin: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.amber[300], //fromARGB(255, 159, 231, 245),
                  // elevation: 4.0,
                  shadowColor: Colors.white,
                  child: ListTile(
                    // onLongPress: ,
                    // leading: CircleAvatar(
                    //     backgroundImage: NetworkImage(
                    //         "https://learncodeonline.in/mascot.png")),
                    title: Text(
                      this.subTaskList[position].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                    // trailing: GestureDetector(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Icon(
                    //       Icons.edit,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // navigateToDetail(this.taskList[position], "ویرایش");
                    //   },
                    // ),
                    onTap: () {
                      debugPrint(this.subTaskList[position].toString());
                      showDialog(
                        context: context,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      // title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void saveSubTask(SubTask subtask) async {
    // moveToLastScreen();
    // note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    // if (task.id != null) {
    //   result = await databaseHelper.updateSubTask(subtask);
    // } else {
    result = await databaseHelper.insertSubTask(subtask);
    // }
    //     {
    //   print(this.task);
    //   _showAlertDialog("با موفقیت ذخیره شد");
    //   print(this.task);
    // }
    if (result == 0) {
      _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
    }
  }

  void _delete(SubTask subtask) async {
    // moveToLastScreen();
    debugPrint("sdfsdf");
    // if (task.id == null) {
    //   // _showAlertDialog("لطفا عنوان وظیفه را وارد کنید");
    //   return;
    // }
    int result = await databaseHelper.deleteSubTask(subtask.id);

    // if (result != 0) {
    //   _showAlertDialog("وظیفه با موفقیت حذف شد");
    // } else {
    //   _showAlertDialog("متاسفانه خطایی رخ داد");
    // }
  }
}
