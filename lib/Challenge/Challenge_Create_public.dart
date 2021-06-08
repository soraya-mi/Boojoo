import 'dart:ui';
import 'package:boojoo/Challenge/Challenge_Create_public2.dart';
import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:ant_icons/ant_icons.dart';

class challenge_create_public extends StatefulWidget {

  final String challengeid;

  challenge_create_public ({this.challengeid});


  @override
  _challenge_create_publicState createState() => _challenge_create_publicState();
}

class _challenge_create_publicState extends State<challenge_create_public> {

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController  _controller;
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';


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
  TextEditingController _passwordcontroller = TextEditingController();

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
        showTimePicker: true,
        hore24Format: false);
    if (picked != null) setState(() => _value2 = picked);
  }



  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: 'home');
    _getValue();

    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'favorite';
        _controller?.text = 'favorite';
      });
    });
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
      appBar: AppBar(title: Text(IsEditing ? 'ویرایش چالش' : 'چالش جدید'),
        // backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
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
                    hintText: '  توضیحات :'
                ),
              ),


              TextFormField(
                controller: _passwordcontroller,
                decoration: InputDecoration(
                    hintText: '  رمز :'
                ),
              ),



              Center(
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget> [
                        new RaisedButton(
                          color: Colors.indigo ,
                          disabledColor: Colors.indigoAccent,
                          onPressed: null,
                          child: new Text('شروع چالش'),
                        ),
                        new RaisedButton(
                          color: Colors.lightBlueAccent ,
                          onPressed: _selectDate2,
                          child: new Text(' پایان چالش '),
                        ),
                      ],
                    ),

                    Container(width: 60,
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 35, ),
                      child: Column(
                        children: <Widget>[
                          Container(width: 59,),
                          Text(
                            selectedDate.toString().substring(0,20),
                            textAlign: TextAlign.center,
                          ),
                          Divider(),
                          Container(height: 10,),
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


              Container(height: 18),
              Container(height: 1, color: Colors.black26,),
              Container(height: 18,),
              // Row(
              //   children: [
              //     // Container(
              //     //   padding: EdgeInsets.all(0.0),
              //     //   margin: EdgeInsets.only(left:0.0),
              //     //   child: DropdownButton<ListItem>(
              //     //       dropdownColor: Colors.amber,
              //     //       iconEnabledColor: Colors.amber ,
              //     //       value: _selectedItem,
              //     //       items: _dropdownMenuItems,
              //     //       onChanged: (value) {
              //     //         setState(() {
              //     //           _selectedItem = value;
              //     //           if(value.value==0)
              //     //             _temp = "PU";
              //     //           else
              //     //             _temp = "PR";
              //     //         });
              //     //       }),
              //     //   //  _type = _selectedItem[1]
              //     // ),
              //
              //     Container(width: 180,),
              //
              //     Text(' : نوع چالش '),
              //   ],
              // ),


              Form(
                key: _oFormKey,
                child: Column(
                  children: <Widget>[
                    IconPicker(
                      controller: _controller,
                      //initialValue: _initialValue,
                      icon: Icon(AntIcons.ant_cloud),
                      labelText: "Icon",
                      enableSearch: true,
                      onChanged: (val) => setState(() => _valueChanged = val),
                      validator: (val) {
                        setState(() => _valueToValidate = val ?? '');
                        return null;
                      },
                      onSaved: (val) => setState(() => _valueSaved = val ?? ''),
                    ),
                    SizedBox(height: 25),
                    // SelectableText(_valueChanged),
                    Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            final loForm = _oFormKey.currentState;

                            if (loForm?.validate() == true) {
                              loForm?.save();
                            }
                          },
                          child: Text('ثبت'),
                        ),
                        SizedBox(width: 50,),
                        // SelectableText(_valueToValidate),
                        // SelectableText(_valueSaved),
                        ElevatedButton(
                          onPressed: () {
                            final loForm = _oFormKey.currentState;
                            loForm?.reset();

                            setState(() {
                              _valueChanged = '';
                              _valueToValidate = '';
                              _valueSaved = '';
                            });
                          },
                          child: Text('انتخاب مجدد'),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Container(height: size.height - 600,),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                                      challenge_create_public2(
                                        title: _titleController.toString(),
                                        descrip: _descriptioncontroller
                                            .toString(),
                                        like: 0,
                                        start: selectedDate.toString(),
                                        end: "1391-10-9",
                                        p_or_p: "PR",
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



