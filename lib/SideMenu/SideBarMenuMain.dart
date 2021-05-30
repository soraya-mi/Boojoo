import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:boojoo/SideMenu/FeedBack_Main.dart';
import 'package:boojoo/SideMenu/AboutUs.dart';
import 'package:boojoo/SideMenu/HelpPage.dart';
import 'package:boojoo/SideMenu/ReportsPage_Main.dart';
import 'package:boojoo/SideMenu/Setting_Main.dart';
import 'package:boojoo/SideMenu/logInsigUpbutton.dart';

import 'package:boojoo/MoodTracker/MoodTracker_Main.dart';


void main() {
  runApp(SideMunuDrawer());
}
class SideMunuDrawer extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SideMeunPage(),
    );
  }
}

class SideMeunPage extends StatefulWidget {
  @override
  _SideMeunPageState createState() => _SideMeunPageState();
}

class _SideMeunPageState extends State<SideMeunPage> {
  List itemss=['گزارش چالش','گزارش مود','گزارش عادت'];
  String valuechoose;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    '....بوژووو',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
                decoration: BoxDecoration(
                color: Colors.amber,
                ),
              ),
              ListTile(
                title: Text('ایجاد حساب/ ورود',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.account_circle_sharp, color: Colors.greenAccent,size:50),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              entrancePage())
                  ),
                },
              ),
              Divider(),
              ListTile(
                title: Text('مودترکر',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.mood_sharp, color: Colors.teal,size:50),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MoodTrackere())
                  ),
                },
              ),
              Divider(),
              ListTile(
                trailing: Icon(Icons.bar_chart,color: Colors.deepOrangeAccent,size: 50,),
                title: Text('گزارش ها',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Reports_Main())
                  ),
                },
              ),
              Divider(),
              ListTile(
                trailing: Icon(Icons.settings , color:Colors.blueAccent,size:50),
                title: Text('تنظیمات',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SettingMain())
                  ),
                },
              ),
              Divider(),
              ListTile(
                trailing: Icon(Icons.border_color,color: Colors.purpleAccent,size: 50,),
                title: Text('ارسال نظر / ارتباط با ما',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                    FeedBack())
                  )
                },
              ),
              Divider(),
              ListTile(
                trailing: Icon(Icons.help,color: Colors.tealAccent,size: 50,),
                title: Text('راهنما',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HelpPage())
                  )
                },
              ),
              Divider(),
              ListTile(
                trailing: Icon(Icons.info_outline,color: Colors.pinkAccent,size: 50,),
                title: Text('درباره ما',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AboutUs())
                  )
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.amber),//change the color of side menu icon
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SideMeunPage()),
                // );
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'امروز حالت چه طور بود؟',
              ),
              SizedBox(height: 50),

              SizedBox(height: 50,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width*0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber,Colors.yellow],
                    stops: [0,1],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: InkWell(
                  //onTap: SendToDB,
                  child: Center(
                    child: Text("ثبت", style: TextStyle(
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
}
