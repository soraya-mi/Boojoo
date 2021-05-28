import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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

class PlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PalceHolderPage(),
    );
  }
}
class PalceHolderPage extends StatefulWidget {
  @override
  _PalceHolderPageState createState() => _PalceHolderPageState();
}

class _PalceHolderPageState extends State<PalceHolderPage> {
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
          )
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Image.asset('assets/software-engineer.png'),

              Container(
                alignment: Alignment.center,
                child:
                AnimatedTextKit(
                  repeatForever: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText( "در دست ساخت",textAlign: TextAlign.right , textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

