import 'dart:ui';
import 'package:api_test/Challenge_Create2.dart';
import 'package:api_test/Challenge_Detail.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
//import 'package:persian_datepicker/persian_datepicker.dart/persian_date.dart';
import 'package:api_test/Challenge_for_list.dart';
import 'package:api_test/Challenge_Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';


class challenge_create extends StatefulWidget {

  final String challengeid;

  challenge_create ({this.challengeid});


  @override
  _challenge_createState createState() => _challenge_createState();
}

class _challenge_createState extends State<challenge_create> {

  String _type;

  List<ListItem> _dropdownItems = [
    ListItem(1, "عمومی"),
    ListItem(2, "شخصی")
  ];


  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  String _chosenValue = 'One';

  bool get IsEditing => widget.challengeid != null;

  challengeservice get ch_detail_service => GetIt.I<challengeservice>();

  String errormessage;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();

  bool _isLoading = false;

  PersianDate persianDate1 ,persianDate2 = PersianDate();
  String _datetime1, _datetime2= '';
  String _format = 'yyyy-mm-dd';
  String _temp = "PU";
  String _value1 = '';
  String _value2 = '';
  String _valuePiker1 = '';
  String  _valuePicker2 = '';
  DateTime selectedDate = DateTime.now();

  Future _selectDate1() async {
    String picked = await jalaliCalendarPicker(
        context: context,
        convertToGregorian: false,
        showTimePicker: false,
        hore24Format: false);
    if (picked != null) setState(() => _value1 = picked);
  }

  Future _selectDate2() async {
    String picked = await jalaliCalendarPicker(
        context: context,
        convertToGregorian: false,
        showTimePicker: false,
        hore24Format: false);
    if (picked != null) setState(() => _value2 = picked);
  }



  @override
  void initState() {
    super.initState();


    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(IsEditing ? 'edit challenge' : 'new challenge'),
      backgroundColor: Colors.amber,),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _isLoading ? Center(child:CircularProgressIndicator() ) : Column(
            children: <Widget> [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                    hintText: ' عنوان : ',
                ),
              ),

              TextFormField(
                controller: _descriptioncontroller,
                decoration: InputDecoration(
                    hintText: '  جمله انگیزشی :'
                ),
              ),





              Center(
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget> [
                        new RaisedButton(
                          color: Colors.amber ,
                          onPressed: _selectDate1,
                          child: new Text('شروع چالش'),
                        ),
                        new RaisedButton(
                          color: Colors.amber ,
                          onPressed: _selectDate2,
                          child: new Text(' پایان چالش '),
                        ),
                      ],
                    ),

                      Container(width: 50,
                        ),

                      Container(
                        padding: EdgeInsets.only(top: 30, ),
                        child: Column(
                        children: <Widget>[
                          Container(width: 59,),
                          Text(
                            _value1,
                            textAlign: TextAlign.center,
                          ),
                          Divider(),
                          Text(
                            _valuePiker1,
                            textAlign: TextAlign.center,
                          ),
                          Container(width: 50,),
                          Text(
                            _value2,
                            textAlign: TextAlign.center,
                          ),
                          Divider(),
                          Text(
                            _valuePicker2,
                            textAlign: TextAlign.center,
                          ),


                        //   new RaisedButton(
                        //     onPressed: _showDatePicker,
                        //     child: new Text('یادآور'),
                        //   ),

                        ],
                    ),
                      ),


                  ],
                ),
              ),


              Container(height: 1, color: Colors.black38,),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(0.0),
                    margin: EdgeInsets.only(left:0.0),
                    child: DropdownButton<ListItem>(
                        dropdownColor: Colors.amber,
                        iconEnabledColor: Colors.amber ,
                        value: _selectedItem,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value;
                            if(value.value==0)
                              _temp = "PU";
                            else
                              _temp = "PR";
                          });
                        }),
                    //  _type = _selectedItem[1]
                  ),

                  Container(width: 180,),

                  Text(' : نوع چالش '),
                ],
              ),



              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('ادامه', style: TextStyle(color: Colors.white),),
                      color: Theme.of(context).primaryColor,
                      onPressed: _titleController.text.isEmpty != true ? () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    challenge_create2(
                                      title: _titleController.toString(),
                                      descrip: _descriptioncontroller
                                          .toString(),
                                      like: 0,
                                      start: "1391-4-9",
                                      end: "1391-10-9",
                                      p_or_p: _temp,
                                    )
                            )
                        );
                      } : null
                    ),
                  ),
                ],
              ),




        ],
          ),
        ),
      ),
    );

  }



//   void _showDatePicker() {
//     final bool showTitleActions = false;
//     DatePicker.showDatePicker(context,
//         minYear: 1300,
//         maxYear: 1450,
// /*      initialYear: 1368,
//       initialMonth: 05,
//       initialDay: 30,*/
//         confirm: Text(
//           'تایید',
//           style: TextStyle(color: Colors.red),
//         ),
//         cancel: Text(
//           'لغو',
//           style: TextStyle(color: Colors.cyan),
//         ),
//         dateFormat: _format, onChanged: (year, month, day) {
//           if (!showTitleActions) {
//             _changeDatetime(year, month, day);
//           }
//         }, onConfirm: (year, month, day) {
//           _changeDatetime(year, month, day);
//           _valuePiker1 = " تاریخ ترکیبی : $_datetime   سال : 1$year   ماه :   $month  روز :  $day";
//         });
//   }

  void _changeDatetime(int year, int month, int day) {
    setState(() {
      _datetime1 = '$year-$month-$day';
    });
  }


}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}



