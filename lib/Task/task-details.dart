import 'package:intl/intl.dart';
import 'task.dart';
import 'task-database.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class TaskDetail extends StatefulWidget {
  final String appBarTitle;
  final Task task;

  TaskDetail(this.task, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return TaskDetailState(this.task, this.appBarTitle);
  }
}

class TaskDetailState extends State<TaskDetail> {
  static var _prioities = ["high", "low"];
  TaskDataBaseHelper helper = TaskDataBaseHelper();
  String appBarTitle;
  Task task;
  String _chosenValue = ' ';
  var listChanged = null;
  //---
  String label;

  String selectedDate = Jalali.now().formatFullDate();

  // @override
  // void initState() {
  //   super.initState();
  //   label = 'انتخاب تاریخ زمان';
  // }
  //---
  TaskDetailState(this.task, this.appBarTitle);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController completedController = TextEditingController(); //why??
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titleController.text = task.title;
    descriptionController.text = task.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            // padding: EdgeInsets.only(right: 200),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListView(
              children: <Widget>[
                // first Element:title
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                      if (titleController.text.isEmpty)
                        _validate = false;
                      else
                        _validate = true;
                      debugPrint(_validate.toString());
                    },
                    decoration: InputDecoration(
                      labelText: 'عنوان',
                      labelStyle: textStyle,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.title_rounded),
                      ),
                    ),
                  ),
                ),

                // second Element:description
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                      labelText: 'توضیحات',
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.description),
                      ),
                    ),
                  ),
                ),
                //third Element:priority
                Container(
                  padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                  width: 20.0,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(50.0),
                  //   color: Colors.yellow,
                  // ),

                  //dropdown menu
                  child: new ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: const Icon(Icons.priority_high),
                    ),
                    title: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                          disabledHint: Text("لطفا انتخاب کنید"),
                          isExpanded: true,
                          iconSize: 20.0,
                          icon: IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            color: Colors.white,
                          ),
                          dropdownColor: Colors.white,
                          itemHeight: 50.0,
                          focusColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          isDense: false,
                          iconEnabledColor: Colors.black,
                          items: _prioities.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: dropDownStringItem != "low"
                                          ? Colors.red
                                          : Colors.green)),
                            );
                          }).toList(),
                          value: getPriorityAsString(task.priority),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              updatePriorityAsInt(valueSelectedByUser);
                            });
                          }),
                    ),
                  ),
                ),
                //forth Element:Date picker
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Colors.amber,
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
                              this.task.date = picked.toString();
                              debugPrint(this.task.date);
                            });
                        },
                        child: Text('تاریخ '),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    //fifth Element:Time picker
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.amber,
                      // color: Colors.teal,
                      onPressed: () async {
                        var picked = await showPersianTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          // builder: (BuildContext context, Widget child) {
                          //   return Directionality(
                          //     textDirection: TextDirection.rtl,
                          //     child: child,
                          //   );
                          // },
                        );
                        setState(() {
                          label = picked.persianFormat(context);
                          String time =
                              picked.hour.toString() + picked.minute.toString();
                          this.task.startTime = time; //picked.toString();
                          debugPrint(this.task.startTime);
                        });
                      },
                      child: Text('زمان شروع '),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      // style: ButtonStyle(
                      //   backgroundColor:
                      //       MaterialStateProperty.resolveWith<Color>(
                      //     (Set<MaterialState> states) {
                      //       if (states.contains(MaterialState.pressed))
                      //         return Theme.of(context)
                      //             .colorScheme
                      //             .primary
                      //             .withOpacity(1.0);
                      //       return null; // Use the component's default.
                      //     },
                      //   ),
                      // ),
                      // color: Colors.teal,
                      color: Colors.amber,
                      clipBehavior: Clip.antiAlias,
                      animationDuration: Duration(
                        seconds: 20,
                      ),
                      onPressed: () async {
                        var picked = await showPersianTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          // builder: (BuildContext context, Widget child) {
                          //   return Directionality(
                          //     textDirection: TextDirection.rtl,
                          //     child: child,
                          //   );
                          // },
                        );
                        setState(() {
                          label = picked.persianFormat(context);
                          String time =
                              picked.hour.toString() + picked.minute.toString();
                          this.task.endTime = time; //picked.toString();
                          debugPrint(this.task.endTime);
                        });
                      },
                      child: Text('زمان پایان '),
                    ),
                  ],
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    textBaseline: TextBaseline.alphabetic,
                    // alignment: AxisAlignment.center,
                    // verticalDirection: VerticalDirection.down,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "دسته بندی",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          // foregroundDecoration: BoxDecoration(
                          //   // borderRadius: BorderRadius.circular(30.0),
                          //   color: Colors.black,
                          // ),
                          padding: const EdgeInsets.all(0.0),
                          width: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.amber,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                disabledHint: Text("لطفا انتخاب کنید"),
                                isExpanded: true,
                                iconSize: 20.0,
                                icon: IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  color: Colors.white,
                                ),
                                dropdownColor: Colors.white,
                                itemHeight: 50.0,
                                focusColor: Colors.white,
                                value: _chosenValue,
                                // elevation: 5,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                                isDense: false,
                                iconEnabledColor: Colors.black,
                                items: <String>[
                                  'سلامتی',
                                  'کار',
                                  'درس',
                                  'شخصی',
                                  ' ',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
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
                                    _chosenValue = value;
                                    task.category = value;
                                    if (value == ' ') task.category = null;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // last Element:save and delete buttons in a row
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      //save button
                      Expanded(
                        child: ElevatedButton(
                          // textColor: Colors.white,
                          // color: Colors.teal[300],
                          // padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ذخیره',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            debugPrint("Save button clicked");
                            setState(() {
                              debugPrint("Save button clicked");
                              if (_validate) {
                                _save();
                              } else {
                                debugPrint("sfsfgsfdg");
                                _showAlertDialog("لطفا نام وظیفه را وارد کنید");
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      //delete button
                      Expanded(
                        child: ElevatedButton(
                          // textColor: Colors.white,
                          // color: Colors.teal[300],
                          // padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'حذف',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Converting the Priority into String for showing to User
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _prioities[0];
        break;
      case 2:
        priority = _prioities[1];
        break;
      default:
    }
    return priority;
  }

  //Convert Priority to Int to Save it into Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case "High":
        task.priority = 1;
        break;
      case "Low":
        task.priority = 2;
        break;
      default:
    }
  }

  void updateTitle() {
    task.title = titleController.text;
  }

  void updateDescription() {
    task.description = descriptionController.text;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save() async {
    moveToLastScreen();
    debugPrint(_validate.toString());
    // note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (task.id != null) {
      result = await helper.updateTask(task);
    } else {
      result = await helper.insertTask(task);
    }

    if (result != 0) {
      print(this.task);
      _showAlertDialog("با موفقیت ذخیره شد");
      print(this.task);
    } else {
      _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (task.id == null) {
      _showAlertDialog("لطفا عنوان وظیفه را وارد کنید");
      return;
    }
    int result = await helper.deleteTask(task.id);

    if (result != 0) {
      _showAlertDialog("وظیفه با موفقیت حذف شد");
    } else {
      _showAlertDialog("متاسفانه خطایی رخ داد");
    }
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      // title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
