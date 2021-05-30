import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/slider/LoadingPageMain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:boojoo/slider/OnBoardScreenMain.dart';
import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void setupLocator(){
  GetIt.I.registerLazySingleton(() => challengeservice());

}

//coomet 3

//comment for test

//void main() => runApp(new MyApp());

void main() {
  setupLocator();
  runApp(MyApp());
}
//second comment for test
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      color: Colors.white,
      home: new Splash(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) =>  LoadingPageApp()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => OnBoarApp()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        //child: new Text('Loading...'),
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Hello'),
//       ),
//       body: new Center(
//         child: new Text('This is the second page'),
//       ),
//     );
//   }
// }
//
// class IntroScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('IntroScreen'),
//       ),
//       body: new Center(
//         child: new Text('This is the IntroScreen'),
//       ),
//     );
//   }
// }
// class OnBoarApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title:"ّبوژووو...",
//       home:HomeOnBoarding(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
// class LoadingPageApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title:"ّبوژووو...",
//       home:HomeLoading(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
