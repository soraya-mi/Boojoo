import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:boojoo/SideMenu/SideBarMenuMain.dart';

int message;
String placeholder;
String tmp="not login";
String tmp1;
// ignore: missing_return
Future<AlbumResetPassword> createAlbumResetPassword(String email) async {
  final http.Response response = await http.post(
    Uri.http('185.235.43.184','/auth/password/reset/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
    }),
  );
  print(response.body);
  print("dddd"+email);
  tmp1=email;
  message=response.statusCode;
  placeholder=response.body;
  print(message);
  print("11111111111111111111111111111111111111111111111");
  /*if (response.statusCode == 200) {

      print("200000000000000000000000000000000000000000000000000000000000000000000000000000");
    return AlbumLogIn.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album sending data.');
  }*/
}

Future<AlbumResetPassword> fetchAlbum() async {
  //final http.Response responseFromBack = await http.get(
  //Uri.http('37.152.182.36:8000','api/rest-auth/login/');
  final http.Response responseFromBack =await http.get(Uri.http('37.152.182.36:8000','api/rest-auth/password/reset/'));

  // Appropriate action depending upon the
  // server response
  print("3000000000000000000000"+responseFromBack.body);
  /*if (responseFromBack.statusCode == 200) {
    return AlbumLogIn.fromJson(json.decode(responseFromBack.body));
  } else {
    throw Exception('Failed to load album fetching data');
  }*/
}


class AlbumResetPassword{
  final String email;
  AlbumResetPassword({this.email});

  factory AlbumResetPassword.fromJson(Map<String, dynamic> json) {
    return AlbumResetPassword(
      email: json['email'],
    );
  }
}
class restPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: resetPasswordPAge(),
    );
  }
}
class resetPasswordPAge extends StatefulWidget {
  @override
  _resetPasswordPAgeState createState() => _resetPasswordPAgeState();
}

class _resetPasswordPAgeState extends State<resetPasswordPAge> {
  final TextEditingController PasswordReseter = TextEditingController();
  Future<AlbumResetPassword> _futureAlbumResetPassword;

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
                //Navigator.pop(context);
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 50.0, top: 10.0, right: 50.0, bottom: 10.0),
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  'ایمیل خود را در کادر زیر وارد نمایید', style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(
                    left: 50.0, top: 10.0, right: 50.0, bottom: 10.0),
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
                  controller: PasswordReseter,
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 50,
                margin: EdgeInsets.only(
                    left: 50.0, top: 10.0, right: 50.0, bottom: 10.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.amber],
                      stops: [0, 1],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),

                child: InkWell(
                  onTap: () {
                    setState(() {
                      _futureAlbumResetPassword=  createAlbumResetPassword(PasswordReseter.text);
                      Timer(Duration(seconds: 1), () {

                        //print(" This line is execute after 5 seconds");

                        if (message == 200) {
                          final snackBar1 = SnackBar(content: Text(
                              " لطفا ایمیل خود را چک کنید  " ,
                              textAlign: TextAlign.right));
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBar1);
                          print("reset is done correctly");
                        }
                        else {

                          if (placeholder.contains("valid") ) {
                            final snackBar2 = SnackBar(content: Text(
                                "ایمیل نا معتبر است",
                                textAlign: TextAlign.right));
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar2);
                            print("error email");
                          }
                        }
                      });
                    });
                    print("on tap");
                  },
                  child: Center(
                    child: Text("ارسال", style: TextStyle(
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
