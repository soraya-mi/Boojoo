import 'package:boojoo/Challenge/challenge_group_public.dart';
import 'package:boojoo/ui/home/home_page_body_mychallenges.dart';
import 'package:flutter/material.dart';
import '../text_style.dart';


class HomePageMyChallenges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new GradientAppBar("چالش ها"),
          new HomePageBodyMyCallenges(),
          // new MySpeedDialButten()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => TabBarchallengePublicGroup()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Center(
        child: new Text(
          title,
          style: Style.titleTextStyleblack,
          // style:const TextStyle(
          //   color: Colors.white,
          //   fontFamily: 'Poppins',
          //   fontWeight: FontWeight.w600,
          //   fontSize: 36.0
          // ),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [const Color(0xFF3366FF), const Color(0xFF00CCFF)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}

// class MySpeedDialButten extends StatefulWidget {
//   @override
//   State createState() => new MySpeedDialButtenState();
// }
//
// class MySpeedDialButtenState extends State<MySpeedDialButten> with TickerProviderStateMixin {
//   AnimationController _controller;
//
//   static const List<IconData> icons = const [ Icons.sms, Icons.mail, Icons.phone ];
//
//   @override
//   void initState() {
//     _controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//   }
//
//   Widget build(BuildContext context) {
//     Color backgroundColor = Theme.of(context).cardColor;
//     Color foregroundColor = Theme.of(context).accentColor;
//     return new Scaffold(
//       appBar: new AppBar(title: new Text('Speed Dial Example')),
//       floatingActionButton: new Column(
//         mainAxisSize: MainAxisSize.min,
//         children: new List.generate(icons.length, (int index) {
//           Widget child = new Container(
//             height: 70.0,
//             width: 56.0,
//             alignment: FractionalOffset.topCenter,
//             child: new ScaleTransition(
//               scale: new CurvedAnimation(
//                 parent: _controller,
//                 curve: new Interval(
//                     0.0,
//                     1.0 - index / icons.length / 2.0,
//                     curve: Curves.easeOut
//                 ),
//               ),
//               child: new FloatingActionButton(
//                 heroTag: null,
//                 backgroundColor: backgroundColor,
//                 mini: true,
//                 child: new Icon(icons[index], color: foregroundColor),
//                 onPressed: () {},
//               ),
//             ),
//           );
//           return child;
//         }).toList()..add(
//           new FloatingActionButton(
//             heroTag: null,
//             child: new AnimatedBuilder(
//               animation: _controller,
//               builder: (BuildContext context, Widget child) {
//                 return new Transform(
//                    transform: new Matrix4.rotationZ(_controller.value * 0.5 * 3.14),
//                   alignment: FractionalOffset.center,
//                   child: new Icon(_controller.isDismissed ? Icons.share : Icons.close),
//                 );
//               },
//             ),
//             onPressed: () {
//               if (_controller.isDismissed) {
//                 _controller.forward();
//               } else {
//                 _controller.reverse();
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
