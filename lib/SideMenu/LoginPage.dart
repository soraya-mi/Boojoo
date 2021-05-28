import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SignUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:boojoo/SideMenu/SignUpPage.dart';
import 'package:boojoo/SideMenu/restPassword.dart';

int message;
String placeholder;
String tmp="not login";
String tmp1;
// ignore: missing_return
Future<AlbumLogIn> createAlbum(String username, String password) async {
  final http.Response response = await http.post(
    Uri.http('37.152.182.36:8000','api/rest-auth/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  print(response.body);
  print("dddd"+username);
  tmp1=username;
  message=response.statusCode;
  placeholder=response.body;
  /*if (response.statusCode == 200) {

      print("200000000000000000000000000000000000000000000000000000000000000000000000000000");
    return AlbumLogIn.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album sending data.');
  }*/
}

Future<AlbumLogIn> fetchAlbum() async {
  //final http.Response responseFromBack = await http.get(
  //Uri.http('37.152.182.36:8000','api/rest-auth/login/');
  final http.Response responseFromBack =await http.get(Uri.http('37.152.182.36:8000','api/rest-auth/login/'));

  // Appropriate action depending upon the
  // server response
  print("3000000000000000000000"+responseFromBack.body);
  /*if (responseFromBack.statusCode == 200) {
    return AlbumLogIn.fromJson(json.decode(responseFromBack.body));
  } else {
    throw Exception('Failed to load album fetching data');
  }*/
}


class AlbumLogIn {
  final String username;

  final String password;

  AlbumLogIn({this.username, this.password});

  factory AlbumLogIn.fromJson(Map<String, dynamic> json) {
    return AlbumLogIn(
      username: json['username'],

      password: json['password'],
    );
  }
}
// saving data used shared prefrences
Future<bool>SaveLogInPrefrence_UserName(String username) async{
  SharedPreferences prefsLogIn=await SharedPreferences.getInstance();
  prefsLogIn.setString("username", username);
  return prefsLogIn.commit();
}
Future<bool>SaveLogInPrefrence_Password( String password) async{
  SharedPreferences prefsLogIn=await SharedPreferences.getInstance();
  prefsLogIn.setString("password", password);
  return prefsLogIn.commit();
}
Future<String>getNamePrefrenceLogIn() async{
  SharedPreferences prefsLogIn=await SharedPreferences.getInstance();
  return prefsLogIn.getString("username");
}

Future<String>getPasswordPrefrenceLogIn() async{
  SharedPreferences prefsLogIn=await SharedPreferences.getInstance();
  return prefsLogIn.getString("password");
}

class LoginPage extends StatefulWidget {
  @override

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePwd = true;
  final TextEditingController usernameController = TextEditingController();
  //final TextEditingController emailaddController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<AlbumLogIn> _futureAlbumLogIn;//this is for sending

  Future<AlbumLogIn> futureAlbumLogIn;//this is for fetching
  void SaveUsername(){
   // String UserName=usernameController.text;
    SaveLogInPrefrence_UserName(usernameController.text).then((bool commitedUsername) {
      //Navigator.of(context).pushNamed(homepage())
    });
  }
  @override
  void initState() {
    super.initState();
    futureAlbumLogIn = fetchAlbum();
  }
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
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),

      body:Center(
        child:SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SingleChildScrollView(
          //Expanded(
          //   child: Container(
          //     margin: EdgeInsets.only(left:10.0,top:10.0,right:10.0,bottom: 50.0),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(40)),
          //       color: Colors.grey.withOpacity(0.3),
          //     ),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 40,bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('نام کاربری', style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      alignment: Alignment.centerRight,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                        controller: usernameController,
                        //placeholder:usernameController.text,
                        decoration: InputDecoration(

                            hintText: "barname",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('رمز عبور', style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                              ),
                              controller: passwordController,
                              obscureText: hidePwd,
                              decoration: InputDecoration(
                                  hintText: "****",
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: IconButton(
                                onPressed: togglePwdVisibility,
                                icon: IconButton(
                                  icon: hidePwd == true ? Icon(
                                      Icons.visibility_off
                                  ) : Icon(Icons.visibility),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>restPassword()));
                        print("onTap called.");
                      },

                      child: Container(
                      padding: EdgeInsets.only(top: 5, right: 20),
                      alignment: Alignment.centerRight,
                      child: Text('رمز خود را فراموش کرده اید؟'),

                    ),

                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50,
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
                            Timer(Duration(seconds: 4), () {
                              print(" This line is execute after 5 seconds");

                              if (message == 200) {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           MyHomePage()), //NoteList()),
                                // );
                              }
                              else{
                                final snackBar2 =  SnackBar(content: Text(" !خطایی رخ داده است ",textAlign: TextAlign.right));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                              }
                            });
                            /*if (message == 200) {
                              /*final snackBar1 =  SnackBar(content: Text(" عزیز به برنامه خوش آمدید "+usernameController.text,textAlign: TextAlign.right));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar1);*/
                              print("log in" , );
                              tmp="login";
                              if (message == 200 && tmp1==usernameController.text) {
                                final snackBar1 =  SnackBar(content: Text(" عزیز به برنامه خوش آمدید "+/*usernameController.text*/tmp1,textAlign: TextAlign.right));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                              }
                              else{
                                final snackBar2 =  SnackBar(content: Text(" !خطایی رخ داده است ",textAlign: TextAlign.right));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                              }
                            }
                            else{
                              /*final snackBar2 =  SnackBar(content: Text(" !خطایی رخ داده است ",textAlign: TextAlign.right));
                             ScaffoldMessenger.of(context).showSnackBar(snackBar2);*/
                              print("cant log in");
                              tmp="not login";
                              final snackBar3 =  SnackBar(content: Text(" .لطفا صبر کنید ",textAlign: TextAlign.right));

                              ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                            }*/

                            _futureAlbumLogIn =   createAlbum(usernameController.text,
                                passwordController.text);

                            // }
                            print(placeholder);
                            print("ffffffffffffffffffffffffffffffff");
                            print(usernameController.text);


                          });
                        },

                        child: Center(
                          child: Text("وارد شدن", style: TextStyle(

                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          ),),

                        ),

                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      child: Center(
                        child: Text('---- راه حل دیگر ----'),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 30,),
                        Container(
                          width: 50,
                          height: 50,
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("حساب کاربری ندارید ؟  "),
                        InkWell(
                          onTap: openSignUpPage,
                          child: Text("ایجاد حساب کاربری", style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w700
                          ),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          //),

        ],
      ),
        ),
          ),
    );

  }



  void openSignUpPage()
  {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
  }
  void togglePwdVisibility()
  {
    hidePwd = !hidePwd;
    setState(() {

    });
  }
}

