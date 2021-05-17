import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:boojoo/slider/SliderModel.dart';

// void main(){
//   runApp(OnBoarApp());
// }
class OnBoarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"ّبوژووو...",
      home:HomeOnBoarding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class HomeOnBoarding extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<HomeOnBoarding> {
  List<SliderModel>slides=new List<SliderModel>();
  int CurrentIndexOfSlide=0;
  PageController screenController=new PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides=getSlides();
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
        itemCount: slides.length,// here we have 3 slides : todolist , habit and challange
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
            GestureDetector(
              //InkWell(

                onTap: (){
                  screenController.animateToPage(slides.length-1, duration: Duration(milliseconds: 200), curve:Curves.decelerate);
                },
                child:Text("skip")
              //),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                for(int i=0;i<slides.length;i++) CurrentIndexOfSlide==i ? SlideIndexDefiner(true) : SlideIndexDefiner(false)

              ],
            ),
            //InkWell(
            GestureDetector(

              onTap: (){

                screenController.animateToPage(CurrentIndexOfSlide+1, duration: Duration(milliseconds: 200), curve:Curves.decelerate);
              },
              child:Text("Next"),
            ),
          ],
        ),

      ):Container(

        height: 100,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow, Colors.amber],
              stops: [0, 1],
            ),
            borderRadius: BorderRadius.all(Radius.circular(0))
        ),

        child: InkWell(
          onTap:  (){
            setState(()  {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => homepage()),
              // );

            });
          },

          child: Center(
            child: Text("شروع", style: TextStyle(

                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15
            ),),

          ),

        ),
      ),
      /*padding: EdgeInsets.symmetric(horizontal: 20),
        //color:Colors.amber,
        height: Platform.isAndroid ? 100 : 100,
        alignment: Alignment.center,

        child:ElevatedButton(
          //shape: Border.all(width: 2.0, color: Colors.lightBlue),
        //padding: EdgeInsets.only(left: 20, right: 20, top: 40,bottom: 40),


        child:Text("Start",style: TextStyle(fontWeight: FontWeight.bold),),

      ),*/


    );
  }
}
class Slider extends StatelessWidget {
  String ImageAssetPath ,title , description;
  Slider({this.ImageAssetPath,this.title,this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(ImageAssetPath),
          SizedBox(height: 20,),
          Text(title,style: TextStyle(fontSize: 30),textAlign:TextAlign.center,),
          SizedBox(height: 20,),
          Text(description,style: TextStyle(fontSize: 20),textAlign:TextAlign.center),
        ],
      ),
    );
  }
}

