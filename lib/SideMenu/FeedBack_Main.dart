import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sidemenuwithdrwaer/SideMenu/SideBarMenuMain.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sidemenuwithdrwaer/SideMenu/FeedBack_Main.dart';
import 'package:sidemenuwithdrwaer/SideMenu/AboutUs.dart';
import 'package:sidemenuwithdrwaer/SideMenu/HelpPage.dart';
import 'package:sidemenuwithdrwaer/SideMenu/ReportsPage_Main.dart';
import 'package:sidemenuwithdrwaer/SideMenu/Setting_Main.dart';
import 'package:sidemenuwithdrwaer/SideMenu/logInsigUpbutton.dart';
import 'package:sidemenuwithdrwaer/SideMenu/LoginPage.dart';
import 'package:sidemenuwithdrwaer/SideMenu/SignUpPage.dart';
import 'package:sidemenuwithdrwaer/SideMenu/restPassword.dart';
import 'package:sidemenuwithdrwaer/SideMenu/placeHolder.dart';
import 'package:sidemenuwithdrwaer/SideMenu/SideBarMenuMain.dart';

int message;
String placeholder;
String tmp="not login";
String tmp1;
// ignore: missing_return
Future<AlbumFeedBack> createAlbumFeedBack(String username, String content) async {
  final http.Response response = await http.post(
    Uri.http('37.152.182.36:8000', 'api/rest-auth/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'content': content,
    }),
  );
  print(response.body);
  print("dddd" + username);
  tmp1 = username;
  message = response.statusCode;
  placeholder = response.body;
}

Future<AlbumFeedBack> fetchAlbum() async {
  final http.Response responseFromBack =await http.get(Uri.http('37.152.182.36:8000','api/rest-auth/login/'));
  print("3000000000000000000000"+responseFromBack.body);

}


class AlbumFeedBack {
  final String username;

  final String content;

  AlbumFeedBack({this.username, this.content});

  factory AlbumFeedBack.fromJson(Map<String, dynamic> json) {
    return AlbumFeedBack(
      username: json['username'],

      content: json['content'],
    );
  }
}

// void main() {
//   runApp(FeedBack());
// }

class FeedBack extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MakeSendFeedBack(),

    );
  }
}
class MakeSendFeedBack extends StatefulWidget {
  @override
  _MakeSendFeedBackState createState() => _MakeSendFeedBackState();
}

class _MakeSendFeedBackState extends State<MakeSendFeedBack> {
  String ContentForDB = "";
  final TextEditingController FeedBack_content = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<AlbumFeedBack> _futureAlbumFeedBack;//this is for sending
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.all(5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.withOpacity(0.5),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SideMeunPage()),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          )
      ),

      body: Center(
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left:50.0,top:10.0,right:50.0,bottom: 10.0),
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerRight,
                child: Text('نام کاربری', style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(left:50.0,top:10.0,right:50.0,bottom: 10.0),
                padding: EdgeInsets.symmetric(
                    vertical: 2, horizontal: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 15),
                      color: Colors.grey,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                alignment: Alignment.centerRight,
                child: TextField(
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey
                  ),
                  controller: usernameController,
                  //placeholder:usernameController.text,
                  decoration: InputDecoration(

                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(left:50.0,top:10.0,right:50.0,bottom: 10.0),
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerRight,
                child: Text('پیشنهاد/انتقاد', style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),),
              ),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left:50.0,top:10.0,right:50.0,bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 15),
                      color: Colors.grey,
                    ),
                  ],
                ),
                //child:AutoDirection(
                child: TextField(
                  textAlign: TextAlign.right,
                  textInputAction: TextInputAction.newline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    //hintText: "پیشنهادات، انتقادات و مشکلات اپ را در حداکثر 5 خط بنویسید",
                    hintStyle: TextStyle(
                      color:Colors.grey,
                    ),
                  ),
                  controller: FeedBack_content,

                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 50,
                margin: EdgeInsets.only(left:50.0,top:10.0,right:50.0,bottom: 10.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.amber],
                      stops: [0, 1],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),

                child: InkWell(
                  onTap:  (){
                    setState(()  {
                      _futureAlbumFeedBack=  createAlbumFeedBack(usernameController.text,FeedBack_content.text);
                      //Timer(Duration(seconds: 1), () {

                      //print(" This line is execute after 5 seconds");

                      //   if (message == 200) {
                      //     final snackBar1 = SnackBar(content: Text(
                      //         " لطفا ایمیل خود را چک کنید  " ,
                      //         textAlign: TextAlign.right));
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         snackBar1);
                      //     print("reset is done correctly");
                      //   }
                      //   else {
                      //
                      //     if (placeholder.contains("valid") ) {
                      //       final snackBar2 = SnackBar(content: Text(
                      //           "ایمیل نا معتبر است",
                      //           textAlign: TextAlign.right));
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //           snackBar2);
                      //       print("error email");
                      //     }
                      //   }
                      // });
                      print(usernameController.text);
                      print("////////////");
                      print(FeedBack_content.text);
                      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

                    });
                  },


                  child:Center(
                    child: Text("ثبت", style: TextStyle(

                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),),

                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

