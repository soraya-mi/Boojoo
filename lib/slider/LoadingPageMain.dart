import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:boojoo/slider/slideLoadingScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
// void main(){
//   runApp(LoadingPageApp());
// }

class LoadingPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"ّبوژووو...",
      home:HomeLoading(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class HomeLoading extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();



}

class _HomeState extends State<HomeLoading> {
  List<SliderModelLoading>slides=new List<SliderModelLoading>();
  int CurrentIndexOfSlide=0;
  PageController screenController=new PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides=getSlides();
    // Timer(Duration(seconds: 3),
    //         ()=>Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder:
    //             (context) =>
    //             homepage()
    //         )
    //     )
    // );
  }


  Widget SlideIndexDefiner(bool isCurrenSlide){
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 40,bottom: 40),
      margin: EdgeInsets.only(right:5),
      //padding: EdgeInsets.symmetric(vertical: 50 , horizontal: 50),
      height: isCurrenSlide ? 5 : 5,
      width:  isCurrenSlide ? 10:5,
      decoration: BoxDecoration(
        color: isCurrenSlide ? Colors.amber : Colors.black,
        borderRadius: BorderRadiusDirectional.circular(10),
        //borderRadius:isCurrenSlide ? BorderRadius.horizontal(Radius,Left:Radius.zero Radius ,Right:Radius.zero ) :BorderRadiusDirectional.circular(10),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:PageView.builder(

        controller : screenController,
        itemCount: slides.length,
        onPageChanged: (val){
          setState(() {
            CurrentIndexOfSlide=val;
          });
        },
        itemBuilder: (context, index){
          return Slider(ImageAssetPath: slides[index].GetImageAssetPath(),
              title: slides[index].GetTitle(),
              description: slides[index].Getdescription()
          );
        },
      ) ,
      bottomSheet:CurrentIndexOfSlide!=slides.length-1 ? Container(
        height: Platform.isAndroid ? 100 : 100
        ,
        margin: EdgeInsets.only(right:5),
        //padding: EdgeInsets.only(left: 20, right: 20, top: 40,bottom: 40),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                for(int i=0;i<slides.length;i++) CurrentIndexOfSlide==i ? SlideIndexDefiner(true) : SlideIndexDefiner(false)

              ],
            ),

          ],
        ),

      ):Container(
        height: Platform.isAndroid ? 100 : 100,
        alignment: Alignment.center,
        //padding: EdgeInsets.only(left: 20, right: 20, top: 40,bottom: 40),
        padding: EdgeInsets.symmetric(horizontal: 20),
        color:Colors.white,

        //child:Text("Start",style: TextStyle(fontWeight: FontWeight.bold),),

      ),

    );
  }
}
class Slider extends StatelessWidget {

  String ImageAssetPath ,title , description;
  Slider({this.ImageAssetPath,this.title,this.description});
  @override
  Timer _time;
  void redirector(){
    _time=Timer.periodic(Duration(seconds: 2), (timer) {
      print("fffff");
    });
  }
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(ImageAssetPath),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,),
          SizedBox(height: 20,),

          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(description,textAlign: TextAlign.center )
            ],
          ),







        ],

      ),

    );

  }

}


// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:Text("GeeksForGeeks")),
//       body: Center(
//           child:Text("Home page",textScaleFactor: 2,)
//       ),
//     );
//   }
// }
