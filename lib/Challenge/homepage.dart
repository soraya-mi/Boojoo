import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:boojoo/Challenge/Challenges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:boojoo/Habit/habbit-list.dart';
import 'package:boojoo/Task/task-list.dart';

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
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
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
  List<Widget> _screens = [MyChallenges(), HabitList(), TaskList(),  ];
  void _onPageChanged(int index){
    index = index;
  }

  
  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.home), Text('خانه'), Colors.amber),
    NavigationItem(Icon(Icons.person), Text('پروفایل'), Colors.blueAccent),
    NavigationItem(Icon(Icons.add_alarm_outlined), Text('عادت'), Colors.purpleAccent),
    NavigationItem(Icon(Icons.settings), Text('چالش'), Colors.teal)
  ];
  
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
                  color: IsSelected ? backgroundColor : Colors.black
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
          color: Colors.white,
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
