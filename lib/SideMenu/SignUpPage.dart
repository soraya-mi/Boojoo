import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'LoginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
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
//import 'home-page.dart';
int messageStatusCode=-1;
String tmpUsername="";
String backAnswer="";
String errorTeller="کاربر گرامی خطایی رخ داده است. \n نام کاربری نباید تکراری باشد  همچنین رمز عبور باید حداقل شامل 10 کاراکتر از جمله حروف و اعداد باشد";
// ignore: missing_return
Future<AlbumSignUp> createAlbumSigUp(String username,String email,String password1, String password2) async {
  final http.Response response1 = await http.post(
    Uri.http('37.152.182.36:8000', 'api/rest-auth/registration/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'email':email,
      'password1': password1,
      'password2': password2,
    }),
  );
  print("ddd");
  print(response1.statusCode);
  tmpUsername=username;
  backAnswer=response1.body;
  messageStatusCode=response1.statusCode;
  /*if (response1.statusCode == 201) {
    return AlbumSignUp.fromJson(jsonDecode(response1.body));
  } else {
    throw Exception('Failed to create album.');
  }*/
}
class AlbumSignUp {
  final String username;
  final String email;

  final String password1;
  final String password2;


  AlbumSignUp({this.username,this.email, this.password1, this.password2});

  factory AlbumSignUp.fromJson(Map<String, dynamic> json) {
    return AlbumSignUp(
      username: json['username'],
      email: json['email'],

      password1: json['password1'],
      password2: json['password2'],
    );
  }
}
Future printSixToTen() async {
  for(int i = 6; i <= 10; ++i) {
    await new Future.delayed(const Duration(seconds: 1), () {
      print(i);
    });
  }
}
void wastetime(){
  for(int i=11;i<=20;i++)
  {
    print(i);
  }
}
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController password1Controller=TextEditingController();
  final TextEditingController password2Controller=TextEditingController();
  Future<AlbumSignUp> _futureAlbumSignUp;
  bool hidePwd = true;
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
            onPressed: (){Navigator.pop(context);},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child:SingleChildScrollView(
          child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          SingleChildScrollView(
            // child: Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(40)),
            //     color: Colors.grey.withOpacity(0.3),
            //   ),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 40,bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('نام کاربری', style: TextStyle(
                        color:Colors.black.withOpacity(0.7),
                        fontSize: 15,
                        //print("username is on");
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                        decoration: InputDecoration(
                            hintText: "مثال : ghazal ",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('ایمیل', style: TextStyle(
                        color:Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                        controller: emailController,

                        decoration: InputDecoration(
                            hintText: "مثال : gmail.com",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('رمز عبور', style: TextStyle(
                        color:Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                              obscureText: hidePwd,
                              controller: password1Controller,
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
                                  ): Icon(Icons.visibility),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text(' تایید رمز عبور', style: TextStyle(
                        color:Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                              obscureText: hidePwd,
                              controller: password2Controller,
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
                                  ): Icon(Icons.visibility),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(top: 5, right: 20),
                    //   alignment: Alignment.centerRight,
                    //   child: Text('رمز عبور خود را فراموش کرده اید؟'),
                    // ),
                     SizedBox(height: 50,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffffeb3b), Color(0xffffc107)],
                            stops: [0,1],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {

                            Timer(Duration(seconds: 5), () {
                              //print(" This line is execute after 5 seconds");

                              if (messageStatusCode == 201) {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           MyHomePage()), //NoteList()),
                                // );
                                final snackBar1 = SnackBar(content: Text(
                                    " .عزیز حساب کاربری شما ساخته شد  " + /*usernameController.text*/
                                        tmpUsername,
                                    textAlign: TextAlign.right));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar1);
                                print("sign up");
                              }

                              else {

                                if (backAnswer.contains("password") ) {
                                  final snackBar2 = SnackBar(content: Text(
                                      ".رمز عبور باید حداقل شامل 10 کاراکتر حرف و عدد باشد",
                                      textAlign: TextAlign.right));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar2);
                                  print("error password");
                                }
                                if (backAnswer.contains("username")) {
                                  final snackBar2 = SnackBar(content: Text(
                                      ".نام کاربری مورد نظر قبلا انتخاب شده است",
                                      textAlign: TextAlign.right));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar2);
                                  print("error username");
                                }
                                if (backAnswer.contains("email")) {
                                  final snackBar2 = SnackBar(content: Text(
                                      ".ایمیل مورد نظر اکانت دارد. لطفا با یک ایمیل دیگر اقدام کنید",
                                      textAlign: TextAlign.right));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar2);
                                  print("error email");
                                }
                              }
                            });

                            /*else
                            {
                              final snackBar3 =  SnackBar(content: Text(" .لطفا صبر کنید ",textAlign: TextAlign.right));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                            }*/
                          });
                          print("on tap");
                          _futureAlbumSignUp =  createAlbumSigUp(usernameController.text,emailController.text,
                              password1Controller.text,password2Controller.text);
                          Timer(Duration(seconds: 5), () {
                            print(" This line is execute after 5 seconds");
                          });
                          final snackBar3 =  SnackBar(content: Text(" .لطفا صبر کنید ",textAlign: TextAlign.right));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                        },


                        child: Center(
                          child: Text("ساخت حساب کاربری", style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("اکانت دارید؟ "),
                        InkWell(
                          onTap: openLoginPage,
                          child: Text(" وارد شدن ", style: TextStyle(
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

        ],
      ),
    ),
      ),
    );
  }
  void openLoginPage()
  {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  void togglePwdVisibility()
  {
    hidePwd = !hidePwd;
    setState(() {

    });
  }
}