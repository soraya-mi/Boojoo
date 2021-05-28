import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/SideMenu/SideBarMenuMain.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class  AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutUsMain(),

    );
  }
}
class AboutUsMain extends StatefulWidget {
  @override
  _AboutUsMainState createState() => _AboutUsMainState();
}

class _AboutUsMainState extends State<AboutUsMain> {
  @override
  String bodyAbotUs="بوژووو\n"
      "نسخه 1.0.0\n"
      "توسعه یافته توسط تیم بوژووو";
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
              Container(
                height: 200,
                margin: EdgeInsets.only(left:50.0,top:10.0,right:50.0,bottom: 10.0),
                padding: EdgeInsets.symmetric(
                    vertical: 2, horizontal: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 15),
                      color: Colors.grey,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                alignment: Alignment.centerRight,
                child:
                AnimatedTextKit(
                  repeatForever: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText( bodyAbotUs,textAlign: TextAlign.right , textStyle: const TextStyle(
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

