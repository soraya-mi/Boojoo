import 'package:api_test/Challenge_Detail.dart';
import 'package:api_test/Challenge_for_list.dart';
import 'package:api_test/Challenge_Service.dart';
import 'package:api_test/insert_note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class challengemodify extends StatefulWidget {

  final String challengeid;

  challengemodify ({this.challengeid});


  @override
  _challengemodifyState createState() => _challengemodifyState();
}

class _challengemodifyState extends State<challengemodify> {

  String _chosenValue = 'One';

  bool get IsEditing => widget.challengeid != null;

  challengeservice get ch_detail_service => GetIt.I<challengeservice>();

  String errormessage;
  challenge_for_list challenge;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();

  bool _isLoading = false;


  // @override
  // void initState() {
  //   super.initState();
  //
  //  setState(() {
  //    _isLoading = true;
  //  });
  //
  //   if(IsEditing){
  //     ch_detail_service.getchallenge(widget.challengeid)
  //         .then((response){
  //
  //       setState(() {
  //         _isLoading = false;
  //       });
  //
  //       if(response.error){
  //         errormessage = response.errormassege ?? 'An error occured';
  //       }
  //       challenge = response.data;
  //       _titleController.text = challenge.title;
  //       _descriptioncontroller.text = challenge.private_pub;
  //     });
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(IsEditing ? 'edit challenge' : 'new challenge')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child:CircularProgressIndicator() ) : Column(
          children: <Widget> [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: 'name :'
              ),
            ),

            TextField(
              controller: _descriptioncontroller,
              decoration: InputDecoration(
                  hintText: 'description :'
              ),
            ),


           SizedBox(
             width: double.infinity,
             child:  RaisedButton(
               color: Theme.of(context).primaryColor,
               textColor: Colors.white,
               child: Text('pick time'),
               onPressed: () {
                 showDatePicker(
                     context: context,
                     initialDate: DateTime.now(),
                     firstDate: DateTime(2000,),
                     lastDate: DateTime(2021)
                 ).then((date) {
                 });
               },
             ),
           ),

            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white),),
                color: Theme.of(context).primaryColor,
                onPressed: () async{
                  if (IsEditing)
                  {
                    //update the page
                  }
                  else {
                    final challenge = challengedetail(
                      // id: 1,
                      // title: _titleController.text,
                      // content: _titleController.text,
                    );

                    final result = await ch_detail_service.createchallenge(challenge);

                    final title = 'Done';
                    final text = result.error ? (result.errormassege ?? 'An error occured!') : 'your note created!' ;
                  }

                  Navigator.of(context).pop();

                },
              ),
            ),


            DropdownButton<String>(
              focusColor:Colors.white,
              value: _chosenValue,
              //elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor:Colors.black,
              items: <String>[
                'private',
                'public',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style:TextStyle(color:Colors.black),),
                );
              }).toList(),
              hint:Text(
                "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (String value) {
                setState(() {
                  _chosenValue = value;
                });
              },
            ),




          ],
        ),
      ),
    );
  }

}


