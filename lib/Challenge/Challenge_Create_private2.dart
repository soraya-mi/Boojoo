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

  List<String> _WeekDays = [];
  List<String> _Days = ["SAT", "SUN", "MON", "TUE", "WED", "THU", "FRI"];

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
  List<bool> isSelected;
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    isSelected = [true, false, false, false];

    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('چالش جدید'),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                ToggleButtons(
                  children: <Widget>[
                    // first toggle button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'سلامتی',
                      ),
                    ),
                    // second toggle button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ورزش',
                      ),
                    ),
                    // third toggle button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'زندگی',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'سرگرمی',
                      ),
                    ),
                  ],
                  // logic for button selection below
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    });
                  },
                  isSelected: isSelected,
                ),



                Container(
                  height: 20,
                ),


                //select days
                MultiSelectChipField(
                  items: _items,
                  initialValue: [_days[1]],
                  title: Text("روزهای هفته"),
                  headerColor: Colors.amberAccent,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                  ),
                  selectedChipColor: Colors.amber,
                  selectedTextStyle: TextStyle(color: Colors.blue[800]),
                  onTap: (values) {
                    _selecteddays1 = values;
                    for(int i = 0; i < _selecteddays1.length; i++)
                      {
                        _WeekDays.add(_Days[_selecteddays1[i].id]);
                      }
                  },
                ),

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
                          days: _WeekDays,
                          startdate: widget.start,//_valuePiker1.substring(0,7),
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