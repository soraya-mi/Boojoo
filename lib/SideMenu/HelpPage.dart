import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:video_player/video_player.dart';
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



class  HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelpPageMain(),

    );
  }
}class HelpPageMain extends StatefulWidget {
  HelpPageMain({Key key}) : super(key: key);

  @override
  _HelpPageMainState createState() => _HelpPageMainState();
}

class _HelpPageMainState extends State<HelpPageMain> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
       // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      //'https://youtu.be/uilkmUoXoLU',
      'https://hajifirouz1.cdn.asset.aparat.com/aparat-video/8aab344f4c66a9d768e0ca7235be2bfc33632878-144p.mp4?wmsAuthSign=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6ImM2ZTI1Yzk0N2ZjY2MxM2NmMDhjOGMzNWNlYThjODEwIiwiZXhwIjoxNjIxODg3MTEzLCJpc3MiOiJTYWJhIElkZWEgR1NJRyJ9.8x56XiNqqaiwUH-0MDc4UsYmDK9mDHFQCIerWh0eMrQ',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

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
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body:Center(
      child:SingleChildScrollView(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Container(
        height: 400,
        width: MediaQuery.of(context).size.width*0.75,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.amber,Colors.yellow],
        //     stops: [0,1],
        //   ),
        //   borderRadius: BorderRadius.all(Radius.circular(15)),
        // ),
      child:FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      ),

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
          onTap: (){
    setState(() {
          // If the video is playing, pause it.
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            // If the video is paused, play it.
            _controller.play();
          }
        });
          },
            child: Center(
              child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
            ),
          ),
        ),

    ],
    ),
    ),
      ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



