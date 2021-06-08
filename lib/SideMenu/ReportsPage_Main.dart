import 'package:boojoo/MoodTracker/PieChartMoodTracker.dart';
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
                title: Text('گزارش مود',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.mood, color: Colors.orange,size:50),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              chartMaker())
                  )
                },
              ),
              Divider(),
              ListTile(
                title: Text('گزارش عادت',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.directions_run, color: Colors.teal,size:50),
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
                title: Text('گزارش چالش',textAlign: TextAlign.right,style: TextStyle(fontSize: 20)),
                trailing: Icon(Icons.stacked_line_chart_rounded, color: Colors.cyanAccent,size:50),
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

//   return DefaultTabController(
//       length: 3,
//    child: Scaffold(
//     appBar: AppBar(
//
//         // brightness: Brightness.light,
//         backgroundColor: Colors.amber,
//         // elevation: 0,
//         bottom:TabBar(
//           indicator: BoxDecoration(
//               borderRadius: BorderRadius.circular(50), // Creates border
//               color: Colors.greenAccent),
//           tabs:<Widget>[
//             Tab(
//               text:'موود',
//             ),
//             Tab(
//               text:'عادت',
//             ),
//             Tab(
//               text:'چالش',
//             ),
//           ],
//         ),
//         leading: Container(
//           margin: EdgeInsets.all(5),
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             color: Colors.grey.withOpacity(0.5),
//           ),
//           child: IconButton(
//             onPressed: () {
//
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SideMeunPage()),
//               );
//               //Navigator.of(context).pop(true);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//           ),
//         ),
//     ),
//      body: TabBarView(
//        children: <Widget>[
//          chartMaker(),
//          PlaceHolder(),
//          PlaceHolder(),
//
//        ],
//       //children: Containers,
//      ),
//    ),
//   );
// }

