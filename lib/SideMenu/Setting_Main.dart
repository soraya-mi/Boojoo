import 'package:flutter/cupertino.dart';
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
class SettingMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingMainPage(),

    );
  }
}
class SettingMainPage extends StatefulWidget {
  @override
  _SettingMainPageState createState() => _SettingMainPageState();
}

class _SettingMainPageState extends State<SettingMainPage> {
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
                //Navigator.of(context).pop(true);
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
                ListTile(
                  title: Text('اعلان / یاداور',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                  trailing: Icon(Icons.notifications, color: Colors.orange,size:50),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PlaceHolder())
                    )
                  },
                ),
                Divider(),
              ListTile(
                title: Text('تغییر رمز عبور',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.lock, color: Colors.teal,size:50),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              restPassword())
                  )
                },
              ),
              Divider(),
              ListTile(
                title: Text('تم',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.color_lens_outlined, color: Colors.cyanAccent,size:50),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlaceHolder())
                  )
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

