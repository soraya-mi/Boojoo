import 'dart:ui';
import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:boojoo/Challenge/Challenges.dart';
import 'package:boojoo/MoodTracker/MoodTracker_Main.dart';
import 'package:boojoo/SideMenu/AboutUs.dart';
import 'package:boojoo/SideMenu/FeedBack_Main.dart';
import 'package:boojoo/SideMenu/HelpPage.dart';
import 'package:boojoo/SideMenu/Profile_Editing_main.dart';
import 'package:boojoo/SideMenu/ReportsPage_Main.dart';
import 'package:boojoo/SideMenu/Setting_Main.dart';
import 'package:boojoo/SideMenu/logInsigUpbutton.dart';
import 'package:boojoo/ui/home/home_page_mychallenges.dart';
import 'package:boojoo/ui/home/home_page_body_mychallenges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:boojoo/Habit/habbit-list.dart';
import 'package:boojoo/Task/task-list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// void setupLocator(){
//   GetIt.I.registerLazySingleton(() => challengeservice());
//
// }
//
// void main() {
//   setupLocator();
//   runApp(App());
// }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlue , fontFamily: 'calibri'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      title: '',

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentindex = 0;

  @override

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 1,
      //   title: Text('بوژووو'),
      // ),
      bottomNavigationBar: ButtomNavyBar(),
      // backgroundColor: Colors.amber.shade100,
      // appBar: AppBar(
      //   title: Text('بوژووو'),
      // ),
      // body: Container(),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentindex,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         title: Text('پروفایل'),
      //         backgroundColor: Colors.blueAccent
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.add_alarm_rounded),
      //         title: Text('عادت'),
      //         backgroundColor: Colors.purpleAccent
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.tag_faces_outlined),
      //         title: Text('مود'),
      //         backgroundColor: Colors.amber
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         title: Text('خانه'),
      //         backgroundColor: Colors.teal
      //     ),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _currentindex = index;
      //     });
      //   },
      // ),
    );
  }
}

class ButtomNavyBar extends StatefulWidget {
  @override
  _ButtomNavyBarState createState() => _ButtomNavyBarState();
}

class _ButtomNavyBarState extends State<ButtomNavyBar> {

  int index = 0;
  Color backgroundColor = Colors.white;

  PageController _pageController = PageController();
  List<Widget> _screens = [HomePageMyChallenges(), HabitList(), TaskList(), profile() ];
  void _onPageChanged(int index){
    index = index;
  }

  
  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.group), Text('   چالش'),Colors.blue),
    NavigationItem(Icon(Icons.add_alarm_outlined), Text('   عادت'),Colors.blue),
    NavigationItem(Icon(Icons.calendar_today), Text('   وظایف'), Colors.blue),
    NavigationItem(Icon(Icons.person), Text('   پروفایل'),Colors.blue)
  ];
  // gradient: new LinearGradient(
  // colors: [
  // const Color(0xFF3366FF),
  // const Color(0xFF00CCFF)
  // ],
  // begin: const FractionalOffset(0.0, 0.0),
  // end: const FractionalOffset(1.0, 0.0),
  // stops: [0.0, 1.0],
  // tileMode: TileMode.clamp
  // ),
  
  Widget _buildItem(NavigationItem item, bool IsSelected){
    return AnimatedContainer(
      duration: Duration(milliseconds: 270),
      height: double.maxFinite,
      width: IsSelected ? 125 : 50,
      padding: IsSelected ?
      EdgeInsets.only(left: 16, right: 16) : null,
      decoration: IsSelected ? BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.all(Radius.circular(50))
      ) : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(data: IconThemeData(
                  size: 24,
                  color: IsSelected ? backgroundColor : Colors.lightBlueAccent
              ),
                  child: item.icon),
              Padding(padding: const EdgeInsets.only(left: 8),
                  child: IsSelected ?
                  DefaultTextStyle.merge(
                      style: TextStyle(
                          color: backgroundColor
                      ),
                      child: item.title
                  )
                      : Container()
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    'بوژووو...',
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
      body: PageView(
        controller: _pageController,
        children: _screens,
       // onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        width:MediaQuery.of(context).size.width ,
        height: 56,
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item){
            var itemIndex = items.indexOf(item);

            return GestureDetector(
              child: _buildItem(item, index == itemIndex),
              onTap: (){
                setState(() {
                  index = itemIndex;
                  _pageController.jumpToPage(itemIndex);
                });
              }
            );
          }).toList()
        ),
      ),
    );
  }
}


class NavigationItem{
  final Icon icon;
  final Text title;
  final Color color;

  NavigationItem(this.icon, this.title, this.color);
}

