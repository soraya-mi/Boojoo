import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/SideMenu/SideBarMenuMain.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/SideMenu/placeHolder.dart';

class Reports_Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Reports_Main_page(),
    );
  }
}
class Reports_Main_page extends StatefulWidget {
  @override
  _Reports_Main_pageState createState() => _Reports_Main_pageState();
}

class _Reports_Main_pageState extends State<Reports_Main_page> {

  @override

  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 3,
     child: Scaffold(
      appBar: AppBar(

          // brightness: Brightness.light,
          backgroundColor: Colors.amber,
          // elevation: 0,
          bottom:TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // Creates border
                color: Colors.greenAccent),
            tabs:<Widget>[
              Tab(
                text:'موود',
              ),
              Tab(
                text:'عادت',
              ),
              Tab(
                text:'چالش',
              ),
            ],
          ),
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
                //Navigator.of(context).pop(true);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
      ),
       body: TabBarView(
         children: <Widget>[
           PlaceHolder(),
           PlaceHolder(),
           PlaceHolder(),

         ],
        //children: Containers,
       ),
     ),
    );
  }
}

