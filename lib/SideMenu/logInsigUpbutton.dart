
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
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

/*void main() {
  runApp(entrancePage());
}*/

class entrancePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginsignupButton(),
      routes: {
        '/LoginPage': (context)=>LoginPage(),
        '/SignUpPage':(context)=>SignUpPage(),
      },
    );
  }
}
class loginsignupButton extends StatefulWidget {
  @override
  _loginsignupButtonState createState() => _loginsignupButtonState();
}

class _loginsignupButtonState extends State<loginsignupButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Center(
            // child: Text("به برنامه ... خوش آمدید", style: TextStyle(
            //fontSize: 40,
            // fontWeight: FontWeight.w700,
            //),),
            //),
            //SizedBox(height: 10,),
            // Container(
            //   padding: EdgeInsets.all(30),
            //   //child: Image.asset('assets/img.png'),
            // ),
            // SizedBox(height: 150,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffffeb3b), Color(0xffffc107)],
                  stops: [0,1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: openSignUp,
                child: Center(
                  child: Text("ایجاد حساب کاربری", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffffc107),Color(0xffffeb3b)],
                  stops: [0,1],
                ),
                //color: Color(0xffebebeb),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: openLogin,
                child: Center(
                  child: Text("وارد شدن", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
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
  void openSignUp()
  {
    Navigator.pushNamed(context, '/SignUpPage');
  }
  void openLogin()
  {
    Navigator.pushNamed(context, '/LoginPage');
  }
}

