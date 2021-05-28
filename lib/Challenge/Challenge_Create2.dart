import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/Challenge/Challenge_Create.dart';
import 'package:boojoo/Challenge/Challenge_Detail.dart';
import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:ant_icons/ant_icons.dart';


class challenge_create2 extends StatefulWidget {

  final String challengeid;
  final String title;
  final String descrip;
  final int like;
  final String start;
  final String end;
  final String p_or_p;
  const challenge_create2({Key key,this.challengeid, this.title, this.descrip, this.like, this.start,
  this.end, this.p_or_p}): super (key: key);

  @override
  _challenge_create2State createState() => _challenge_create2State();

}

class _challenge_create2State extends State<challenge_create2> {

  bool get IsEditing => widget.challengeid != null;
  challengeservice get ch_detail_service => GetIt.I<challengeservice>();
  String errormessage;

  bool _isLoading = false;

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController  _controller;
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';

  static List<Days> _days = [
    Days(id: 1, name: "شنبه"),
    Days(id: 2, name: "یکشنبه"),
    Days(id: 3, name: "دوشنبه"),
    Days(id: 4, name: "سه شنبه"),
    Days(id: 5, name: "چهارشنبه"),
    Days(id: 6, name: "پنجشنبه"),
    Days(id: 7, name: "جمعه")
  ];
  final _items = _days
      .map((animal) => MultiSelectItem(animal, animal.name))
      .toList();

  List<Days> _selecteddays1 = [];
  List<Days> _selecteddays = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selecteddays = _days;
    super.initState();

    _controller = TextEditingController(text: 'home');
    _getValue();
  }
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'favorite';
        _controller?.text = 'favorite';
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('چالش جدید'),
      ),
      body: Scrollbar(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Form(
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
                             child: Text('Submit'),
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
                             child: Text('Reset'),
                           ),
                         ],
                       )
                      ],
                    ),
                  ),
                ),


                Container(
                  height: 20,
                ),

                //days1
                MultiSelectBottomSheetField<Days>(
                  key: _multiSelectKey,
                  initialChildSize: 0.7,
                  maxChildSize: 0.95,
                  title: Text("Animals"),
                  buttonText: Text("Favorite Animals"),
                  items: _items,
                  searchable: true,
                  validator: (values) {
                    if (values == null || values.isEmpty) {
                      return "Required";
                    }
                    List<String> names = values.map((e) => e.name).toList();
                    if (names.contains("Frog")) {
                      return "Frogs are weird!";
                    }
                    return null;
                  },
                  onConfirm: (values) {
                    setState(() {
                      _selecteddays1 = values;
                    });
                    _multiSelectKey.currentState.validate();
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (item) {
                      setState(() {
                        _selecteddays1.remove(item);
                      });
                      _multiSelectKey.currentState.validate();
                    },
                  ),
                ),


                //days2
                // Container(
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).primaryColor.withOpacity(.4),
                //     border: Border.all(
                //       color: Theme.of(context).primaryColor,
                //       width: 2,
                //     ),
                //   ),
                //   child: Column(
                //     children: <Widget>[
                //       MultiSelectBottomSheetField(
                //         initialChildSize: 0.4,
                //         listType: MultiSelectListType.CHIP,
                //         searchable: true,
                //         buttonText: Text("روزهای هفته"),
                //         title: Text("Animals"),
                //         items: _items,
                //         onConfirm: (values) {
                //           _selecteddays1 = values;
                //         },
                //         chipDisplay: MultiSelectChipDisplay(
                //           onTap: (value) {
                //             setState(() {
                //               _selecteddays1.remove(value);
                //             });
                //           },
                //         ),
                //       ),
                //       _selecteddays1 == null || _selecteddays1.isEmpty
                //           ? Container(
                //           padding: EdgeInsets.all(10),
                //           alignment: Alignment.centerLeft,
                //           child: Text(
                //             "None selected",
                //             style: TextStyle(color: Colors.black54),
                //           ))
                //           : Container(),
                //     ],
                //   ),
                // ),


                //days3
                // MultiSelectDialogField(
                //   items: _items,
                //   title: Text("Animals"),
                //   selectedColor: Colors.blue,
                //   decoration: BoxDecoration(
                //     color: Colors.blue.withOpacity(0.1),
                //     borderRadius: BorderRadius.all(Radius.circular(40)),
                //     border: Border.all(
                //       color: Colors.blue,
                //       width: 2,
                //     ),
                //   ),
                //   buttonIcon: Icon(
                //     Icons.select_all_outlined,
                //     color: Colors.blue,
                //   ),
                //   buttonText: Text(
                //     "روزهای هفته ",
                //     style: TextStyle(
                //       color: Colors.blue[800],
                //       fontSize: 16,
                //     ),
                //   ),
                //   onConfirm: (results) {
                //     //_selectedAnimals = results;
                //   },
                // ),


                //days4
                // MultiSelectDialogField(
                //   onConfirm: (val) {
                //     _selecteddays = val;
                //   },
                //   items: _items,
                //   initialValue:
                //   _selecteddays  , // setting the value of this in initState() to pre-select values.
                // ),


                //days5
                // MultiSelectChipField(
                //   items: _items,
                //   initialValue: [_days[1]],
                //   title: Text("روزهای هفته"),
                //   headerColor: Colors.amberAccent,
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.orange),
                //   ),
                //   selectedChipColor: Colors.amber,
                //   selectedTextStyle: TextStyle(color: Colors.blue[800]),
                //   onTap: (values) {
                //     _selecteddays1 = values;
                //   },
                // ),

                Container(height: 30,),

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text('ذخیره'),
                    color: Theme.of(context).primaryColor,
                    onPressed: () async{
                      if (IsEditing)
                      {
                        //update the page
                      }
                      else {


                        setState(() {
                          _isLoading = true;
                        });
                        print(widget.p_or_p.substring(0,1));
                        // print(_valuePicker2.substring(0,9));
                        final challenge = challengedetail(
                          title: widget.title,
                          description: widget.descrip,
                          likenumber: 0,
                          days: ["SUN"],
                          startdate: "1380-4-6",//_valuePiker1.substring(0,7),
                          enddate: "2015-7-1",//_valuePicker2.substring(0,9),
                          progress_type: "BO",
                          private_pub: widget.p_or_p,
                        );

                        final result = await ch_detail_service.createchallenge(challenge);

                        setState(() {
                          _isLoading = false;
                        });

                        final title = 'انجام شد !';
                        final text = result.error ? (result.errormassege ?? 'خطایی رخ داده !') : 'چالش جدید با موفقیت ایجاد شد !' ;

                        showDialog(
                            context: context,
                            builder: (_)=> AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: <Widget> [
                                FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Ok")
                                )
                              ],

                            )
                        ).then((data){
                          if(result.data){
                            Navigator.of(context).pop();
                          }
                        });

                      }



                    },
                  ),
                ),


              ],
            ),
          )
      ),
    );
  }
}

class Days{
  final int id;
  final String name;

  Days({ this.id, this.name});
}