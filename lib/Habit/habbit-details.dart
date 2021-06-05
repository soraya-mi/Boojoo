import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'habit.dart';
import 'habit-database.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../HabitDays/HabitDays_database.dart';
import '../Habit-without-Cue-Log/habit_without_cue_database.dart';
import '../Habit-With-Cue-Log/habit_with_cue_database.dart';
import '../HabitDays/habitDays.dart';
// import 'package:icon_picker/icon_picker.dart';
// import 'package:ant_icons/ant_icons.dart';

class HabitDetail extends StatefulWidget {
  final String appBarTitle;
  final Habit habit;
  // HabitDays habitdays;
  HabitDetail(this.habit, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return HabitDetailState(this.habit, this.appBarTitle);
  }
}

class HabitDetailState extends State<HabitDetail> {
  //variables
  static var _prioities = ["high", "low"];
  HabitDataBaseHelper helper = HabitDataBaseHelper();
  HabitDaysDataBaseHelper daysDBHelper = HabitDaysDataBaseHelper();
  HabitWithoutCueLog_DBHelper HabitWithoutCueLogDBhelper =
      HabitWithoutCueLog_DBHelper();
  HabitWithCueLog_DBHelper HabitWithCueLogDBhelper = HabitWithCueLog_DBHelper();

  String appBarTitle;
  Habit habit;
  HabitDays habitdays;
  //---
  String label;
  String selectedDate = Jalali.now().formatFullDate();
  String start = "", end = "";
  HabitDetailState(this.habit, this.appBarTitle);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController completedController = TextEditingController(); //why??
  TextEditingController cueController = TextEditingController();
  TextEditingController _controller;
  // TextFormField amountOfGHabitGoal = TextFormField();
  // TextFormField cueController = TextFormField();
  int _currentIntValue = 0;
  bool a, b;
  bool hasWeekRepetition = false;
  String _chosenValue = ' ';
  int habitdaysID;
  List<bool> isSelected;
  int sat = 0, sun = 0, mon = 0, tue = 0, wed = 0, thu = 0, fri = 0;
  //icons

  final Map<String, IconData> myIconCollection = {
    'مورد علاقه': Icons.favorite,
    // 'خانه': Icons.home,
    'ورزش': Icons.sports,
    'درس': Icons.school,
    'شخصی': Icons.person_pin,
  };

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getHabitDaysID(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (habit.id != null) {}
          habitdays = HabitDays(habit.id);
          if (this.habit.type == 1) {
            a = false;
            b = true;
          } else {
            a = true;
            b = false;
          }
          TextStyle textStyle = Theme.of(context).textTheme.title;
          titleController.text = habit.title;
          descriptionController.text = habit.description;
          // if (habit.cue != Null) cueController.text = habit.cue.toString();
          return WillPopScope(
            onWillPop: () {
              moveToLastScreen();
            },
            child: Scaffold(
              backgroundColor: Colors.teal[50],
              appBar: AppBar(
                title: Text(appBarTitle),
                backgroundColor: Colors.blue,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  // padding: EdgeInsets.only(right: 200),
                  onPressed: () {
                    moveToLastScreen();
                  },
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(12.0),
                child: Scaffold(
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15.0),
                  // ),
                  body: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      // first Element:title
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.0, bottom: 1.0, left: 10.0),
                        child: TextField(
                          controller: titleController,
                          style: textStyle,
                          onChanged: (value) {
                            updateTitle();
                          },
                          decoration: InputDecoration(
                            labelText: 'عنوان',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.title_rounded),
                            ),
                          ),
                        ),
                      ),
                      // second Element:description
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.0, bottom: 5.0, left: 10.0),
                        child: TextField(
                          controller: descriptionController,
                          style: textStyle,
                          onChanged: (value) {
                            updateDescription();
                          },
                          decoration: InputDecoration(
                            labelText: 'توضیحات',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.description),
                            ),
                          ),
                        ),
                      ),
                      //priority
                      Padding(
                        padding: EdgeInsets.only(top: 3.0, bottom: 5.0),
                        //dropdown menu
                        child: Container(
                          width: 40.0,
                          child: new ListTile(
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(30),
                            // ),
                            leading: Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: const Icon(
                                Icons.priority_high_rounded,
                              ),
                            ),
                            title: Container(
                              alignment: Alignment.centerRight,
                              // margin: EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0),
                              padding: const EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.lightBlueAccent[50],
                              ),
                              width: 30.0,
                              height: 40.0,
                              child: DropdownButton(
                                  // isExpanded: true,
                                  items: _prioities
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: dropDownStringItem != "low"
                                                  ? Colors.red
                                                  : Colors.green)),
                                    );
                                  }).toList(),
                                  value: getPriorityAsString(habit.priority),
                                  onChanged: (valueSelectedByUser) {
                                    setState(() {
                                      debugPrint("p is" + valueSelectedByUser);
                                      updatePriorityAsInt(valueSelectedByUser);
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                      //forth Element:Date picker
                      Wrap(
                        spacing: 8.0,
                        // alignment: WrapAlignment.center,
                        // direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "زمان:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Container(
                            width: 70.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.lightBlueAccent,
                              onPressed: () async {
                                Jalali picked = await showPersianDatePicker(
                                  context: context,
                                  initialDate: Jalali.now(),
                                  firstDate: Jalali(1385, 8),
                                  lastDate: Jalali(1450, 9),
                                );
                                if (picked != null && picked != selectedDate)
                                  setState(() {
                                    // label = picked.formatFullDate();
                                    // this.habit.startDate = picked.toString();

                                    start = picked.year.toString() +
                                        '/' +
                                        picked.month.toString() +
                                        '/' +
                                        picked.day.toString();
                                    updateStartDate(start);
                                    // debugPrint(this.habit.startDate);
                                  });
                              },
                              child: Text(
                                'شروع ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ),

                          Container(
                            width: 70.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.lightBlueAccent,
                              onPressed: () async {
                                Jalali picked = await showPersianDatePicker(
                                  context: context,
                                  initialDate: Jalali.now(),
                                  firstDate: Jalali(1385, 8),
                                  lastDate: Jalali(1450, 9),
                                );
                                if (picked != null && picked != selectedDate)
                                  setState(() {
                                    // label = picked.formatFullDate();
                                    // this.habit.endDate = picked.toString();

                                    // debugPrint(this.habit.endDate);
                                    end = picked.year.toString() +
                                        '/' +
                                        picked.month.toString() +
                                        '/' +
                                        picked.day.toString();
                                    updateEndDate(end);
                                  });
                              },
                              child: Text('پایان '),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              end,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 20.0,
                          // ),
                        ],
                      ),
                      Divider(),
                      //repetition
                      Text(
                        "تکرار هفتگی:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Center(
                        child: Wrap(
                          children: [
                            //saturday
                            ClipOval(
                              child: Material(
                                color: sat == 0
                                    ? Colors.grey
                                    : Colors.green, // button color
                                child: InkWell(
                                  radius: 10.0,
                                  // highlightColor: Colors.yellow,
                                  // splashColor: Colors.green, // inkwell color
                                  child: SizedBox(
                                      width: 46,
                                      height: 46,
                                      child: Center(child: Text("ش"))),
                                  onTap: () {
                                    setState(
                                      () {
                                        sat = sat == 0 ? 1 : 0;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            //sunday
                            ClipOval(
                              child: Material(
                                color: sun == 0
                                    ? Colors.grey
                                    : Colors.green, // button color
                                child: InkWell(
                                  child: SizedBox(
                                    width: 46,
                                    height: 46,
                                    child: Center(child: Text("ی")),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        sun = sun == 0 ? 1 : 0;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            //monday
                            ClipOval(
                              child: Material(
                                color: mon == 0
                                    ? Colors.grey
                                    : Colors.green, // button color
                                child: InkWell(
                                  child: SizedBox(
                                    width: 46,
                                    height: 46,
                                    child: Center(child: Text("د")),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        mon = mon == 0 ? 1 : 0;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            //tuesday
                            ClipOval(
                              child: Material(
                                color: tue == 0
                                    ? Colors.grey
                                    : Colors.green, // button color
                                child: InkWell(
                                  child: SizedBox(
                                    width: 46,
                                    height: 46,
                                    child: Center(child: Text("س")),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        tue = tue == 0 ? 1 : 0;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            //wednesday
                            ClipOval(
                              child: Material(
                                color: wed == 0
                                    ? Colors.grey
                                    : Colors.green, // button color
                                child: InkWell(
                                  child: SizedBox(
                                    width: 46,
                                    height: 46,
                                    child: Center(child: Text("چ")),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        wed = wed == 0 ? 1 : 0;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            //thursday
                            ClipOval(
                              child: Material(
                                color: thu == 0
                                    ? Colors.grey
                                    : Colors.green, // button color
                                child: InkWell(
                                  child: SizedBox(
                                    width: 46,
                                    height: 46,
                                    child: Center(child: Text("پ")),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        thu = thu == 0 ? 1 : 0;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            //friday
                            ClipOval(
                              child: Material(
                                color: fri == 0
                                    ? Colors.grey
                                    : Colors.green, // button color
                                child: InkWell(
                                  radius: 20.0,
                                  child: SizedBox(
                                    width: 46,
                                    height: 46,
                                    child: Center(child: Text("ج")),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        fri = fri == 0 ? 1 : 0;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          // alignment: WrapAlignment.start,
                          // crossAxisAlignment: WrapCrossAlignment.center,
                          // runAlignment: WrapAlignment.start,
                          // width: 10.0,
                          children: [
                            Text(
                              "تکرار روزانه:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            NumberPicker(
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black26),
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                backgroundBlendMode: BlendMode.lighten,
                                // color: Colors.red,
                              ),
                              itemHeight: 50.0,
                              axis: Axis.horizontal,
                              // itemHeight: 20.0,
                              textStyle: TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.bold,
                                // backgroundColor: Colors.red,
                              ),
                              value: _currentIntValue,
                              minValue: 0,
                              maxValue: 100,
                              step: 1,
                              // haptics: true,
                              onChanged: (value) => setState(
                                () {
                                  _currentIntValue = value;
                                  // this.habit.number = _currentIntValue;
                                  updateNumber(value);
                                },
                              ),
                              itemWidth: 60.0,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      //Cue text field
                      Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: Row(
                          children: [
                            Text(
                              " نوع عادت:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  // this.habit.type = 0;
                                  updateType(0);
                                  // print(this.habit.type);
                                  // print("0--------------");
                                  a = value;
                                });
                              },
                              value: a,
                              hoverColor: Colors.yellow,
                            ),
                            Text("بدون هدف"),
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  // this.habit.type = 1;
                                  updateType(1);
                                  // print(this.habit.type);
                                  b = value;
                                });
                              },
                              value: b,
                            ),
                            Text("با هدف"),
                          ],
                        ),
                      ),

                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "هدف:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 40.0, width: 200.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            // height: maxLines * 24.0,
                            child: TextFormField(
                              controller: cueController,
                              onChanged: (value) {
                                int a = int.parse(value);
                                updateCue(a);
                              },
                              // validator: (val) {
                              //   if (val.isEmpty) _showAlertDialog("خطا");
                              // },
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(40.0),
                                  // borderSide: new BorderSide(),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                //fillColor: Colors.green

                                labelText: 'یک عدد صحیح وارد کنید',
                                labelStyle: TextStyle(
                                    fontSize: 15.0, color: Colors.blueGrey),
                                enabled: b,
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  // child: Icon(Icons.auto_awesome),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      //fifth Elemtn:number picker
                      //category
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "دسته بندی:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.black,
                              ),
                              width: 100.0,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
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
                                    focusColor: Colors.white,
                                    value: _chosenValue,
                                    // elevation: 5,
                                    style: TextStyle(color: Colors.white),

                                    items: <String>[
                                      'سلامتی',
                                      'کار',
                                      'درس',
                                      'شخصی',
                                      ' ',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
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
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        _chosenValue = value;
                                        habit.category = value;
                                        if (value == ' ') habit.category = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      //Icon
                      // IconPicker(
                      //   initialValue: 'favorite',
                      //   icon: Icon(Icons.apps),
                      //   labelText: "آیکون",
                      //   title: "یک آیکون انتخاب کنید",
                      //   cancelBtn: "CANCEL",
                      //   enableSearch: true,
                      //   searchHint: 'جستجو',
                      //   iconCollection: myIconCollection,
                      //   onChanged: (val) => debugPrint("[][][" + val),
                      //   onSaved: (val) => print(val),
                      // ),
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
                                    _save();
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
        },
      );

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
      case "high":
        // debugPrint("adbc,dabf,jvadc");
        habit.priority = 1;
        // debugPrint(habit.priority.toString());
        break;
      case "low":
        habit.priority = 2;
        // debugPrint(habit.priority.toString());
        break;
      default:
    }
    // debugPrint("val" + value.toString());
  }

//update fields functions
  void updateTitle() {
    habit.title = titleController.text;
  }

  void updateDescription() {
    habit.description = descriptionController.text;
  }

  void updateStartDate(String date) {
    this.habit.startDate = date;
  }

  void updateEndDate(String date) {
    this.habit.endDate = date;
  }

  void updateNumber(int number) {
    this.habit.number = _currentIntValue;
  }

  void updateType(int Type) {
    this.habit.type = Type;
  }

  void updateCue(int value) {
    this.habit.cue = value;
  }

  void updateAlarm() {}
  //DB functions

  void _save() async {
    // moveToLastScreen();
    // note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    debugPrint("p" + habit.priority.toString());
    if (habit.id != null) {
      print('tnnnnnnn');
      result = await helper.updateHabit(habit);
    } else {
      result = await helper.insertHabit(habit);
    }
    var saveDays = await saveHabitDays();
    if (result != 0) {
      print(this.habit);
      _showAlertDialog("با موفقیت ذخیره شد");
      print('thisssssss');
    } else {
      _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (habit.id == null) {
      _showAlertDialog("لطفا عنوان عادت را وارد کنید");
      return;
    }
    int result = await helper.deleteHabit(habit.id);
    if (habit.type == 0) {
      var r = await HabitWithoutCueLogDBhelper.deleteHabitLogs(habit.id);
      debugPrint("after deleter");
    } else {
      var r = await HabitWithCueLogDBhelper.deleteHabitLogs(habit.id);
      debugPrint("after deleter");
    }
    if (result != 0) {
      _showAlertDialog("عادت با موفقیت حذف شد");
    } else {
      _showAlertDialog("متاسفانه خطایی رخ داد");
    }
  }

  // void saveDays() async {
  //   debugPrint("in save");
  //   // moveToLastScreen();
  //   // note.date = DateFormat.yMMMd().format(DateTime.now());
  //   int result;
  //   if (habitdays.id != null) {
  //     debugPrint("not null");
  //     result = await daysDBHelper.updateHabitDays(habitdays);
  //   } else {
  //     result = await daysDBHelper.insertHabitDays(habitdays);
  //   }
  //
  //   if (result != 0) {
  //     print(this.habitdays);
  //     _showAlertDialog("با موفقیت ذخیره شد");
  //     print('thisssssss');
  //   } else {
  //     _showAlertDialog("متاسفانه هنگام ذخیره سازی خطایی رخ داد");
  //   }
  // }

  void deleteDays() async {
    moveToLastScreen();

    if (habitdays.id == null) {
      return;
    }
    int result = await daysDBHelper.deleteHabitDays(habitdays.id);

    // if (result != 0) {
    //   _showAlertDialog("عادت با موفقیت حذف شد");
    // } else {
    //   _showAlertDialog("متاسفانه خطایی رخ داد");
    // }
  }

  //maybe!!
  void updateDays() async {}
  //page functions
  void moveToLastScreen() {
    debugPrint('move');
    Navigator.pop(context, true);
    debugPrint('move2');
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      // title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  Future<int> getHabitDaysID() async {
    var result = await daysDBHelper.getHabitID(habit.id).then((value) {
      return value;
    });
    return result;
  }

  Future<int> saveHabitDays() async {
    debugPrint("in save days");
    if (sat == 1 ||
        sun == 1 ||
        mon == 1 ||
        tue == 1 ||
        wed == 1 ||
        thu == 1 ||
        fri == 1) {
      debugPrint("some days");
      int id = await getHabitDaysID();
      debugPrint("id=" + id.toString());
      if (id == -1) {
        // debugPrint(id.toString());
        var result = await daysDBHelper.insertHabitDays(
            HabitDays(habit.id, sat, sun, mon, tue, wed, thu, fri));
      } else {
        int lid = await id;
        var result = await daysDBHelper.updateHabitDays(
            HabitDays.withId(lid, habit.id, sat, sun, mon, tue, wed, thu, fri));
      }
    }
  }
}
// ToggleSwitch(
// minWidth: 90.0,
// minHeight: 70.0,
// initialLabelIndex: 2,
// cornerRadius: 20.0,
// activeFgColor: Colors.white,
// inactiveBgColor: Colors.grey,
// inactiveFgColor: Colors.white,
// labels: ['', '', ''],
// icons: [
// Icons.check,
// Icons.timelapse,
// Icons.motion_photos_on_rounded,
// ],
// iconSize: 30.0,
// activeBgColors: [
// Colors.blue,
// Colors.pink,
// Colors.purple
// ],
// onToggle: (index) {
// print('switched to: $index');
// },
// ),
