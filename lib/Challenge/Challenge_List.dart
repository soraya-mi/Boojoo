import 'package:boojoo/Challenge/API_Response.dart';
import 'package:boojoo/Challenge/Challenge_Delete.dart';
import 'package:boojoo/Challenge/Challenge_Modify.dart';
import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:boojoo/Challenge/Challenges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/Challenge/Challenge_for_list.dart';
import 'package:get_it/get_it.dart';

class challengelist extends StatefulWidget {

  @override
  _challengelistState createState() => _challengelistState();
}

class _challengelistState extends State<challengelist> {

  challengeservice get service => GetIt.I<challengeservice>();
  APIresponse<List<challenge_for_list>> _apiResponse;
  bool _isLoading = false;

  String FormatDateTime (DateTime time)
  {
    return '${time.year}/${time.month}/${time.day}';
  }

  @override
  void initState(){
    _fetchchallenge();
    super.initState();
  }

  _fetchchallenge() async{
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getchallengelist();

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      // appBar: AppBar(title: Text("چالش های برتر"),),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => challengemodify()));
    //      },
    //
    //     child: Icon(Icons.add),
    // ),
      body: Builder(
        builder: (_){

          if(_isLoading){
            return Center(child: CircularProgressIndicator());
          }

          if(_apiResponse?.error){
           return Center(child: Text(_apiResponse.errormassege));
          }
         return ListView.separated(
            separatorBuilder : (_, __) => Divider(height: 1, color: Colors.black45,),
            itemBuilder : (_, index)
            {
              return Column(
                children: [
                  Dismissible(
                    key: ValueKey(_apiResponse.data[index].id),
                    direction: DismissDirection.startToEnd,
                    onDismissed:(direction) {

                    },
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context,
                          builder: (_) => ch_delete()
                      );
                      return result;
                    },
                    background: Container(
                      color: Colors.redAccent,
                      padding: EdgeInsets.only(left: 16),
                      child: Align(child: Icon(Icons.delete_rounded, color: Colors.white,), alignment: Alignment.centerLeft,),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(_apiResponse.data[index].icon),
                      ),
                      title: Text( _apiResponse.data[index].title,
                        style: TextStyle(color: Theme.of(context).primaryColorDark),
                      ),
                      subtitle: Text('started at : ${FormatDateTime(_apiResponse.data[index].startdate)}'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => challengemodify(
                          challengeid: _apiResponse.data[index].title,
                        )));
                      } ,
                    ),
                  ),
                ],
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      )
    );
  }
}
