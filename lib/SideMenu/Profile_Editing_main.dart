import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:random_color/random_color.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:boojoo/SideMenu//SharedPref_Class.dart';
import 'dart:core';

final ProfilePrefs = MySharedPreferences.instance;
int flag = 0;
String tmp1 = "", tmp2 = "", tmpUserName = "usrname", tmpEmail = "email";

String hintTextDefiner_Username() {
  Timer(Duration(seconds: 2), () async {
    final String returnie =
        await ProfilePrefs.getStringValuesSF("username_SHP");
    print(" timer1 for gettings username");
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRrusername");
    print(returnie);
    tmpUserName = returnie;
  });
  Timer(Duration(seconds: 4), () async {
    print(" timer2 for printting username");
    print(tmpUserName);
    print("LLLLLLLLLLLLLLLLLLLLLL username");

    return tmpUserName;
  });
}

String hintTextDefiner_Email() {
  Timer(Duration(seconds: 0), () async {
    final String returnie = await ProfilePrefs.getStringValuesSF("email_SHP");
    print(" timer1 for gettings email");
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRr email");
    print(returnie);
    tmpUserName = returnie;
  });

  Timer(Duration(seconds: 2), () async {
    print(" timer2 for printting email");
    print(tmpUserName);
    print("LLLLLLLLLLLLLLLLLLLLLL email");

    return tmpUserName;
  });
}

// String tmp1=hintTextDefiner_Username();
// String tmp2=hintTextDefiner_Email();
int pictureCounter = 0;
int back_answer_edit_profile_code;
String back_answer_edit_profile_message;
// String tmpUserName=hintTextDefiner_Username();
// String tmpEmail=hintTextDefiner_Email();
Future<AlbumEditProfile> CreatAlbumProfile(
    String UserName, String Email) async {
  final http.Response ResponseEditProfile = await http.post(
    Uri.http('37.152.182.36:8000', 'api/rest-auth/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'EditedUserName': UserName,
      'EditedEmail': Email,
    }),
  );
  back_answer_edit_profile_code = ResponseEditProfile.statusCode;
  back_answer_edit_profile_message = ResponseEditProfile.body;
}

class AlbumEditProfile {
  final String EditedUserName;
  final String EditedEmail;

  AlbumEditProfile({this.EditedUserName, this.EditedEmail});

  factory AlbumEditProfile.fromJson(Map<String, dynamic> json) {
    return AlbumEditProfile(
      EditedUserName: json['EditedUserName'],
      EditedEmail: json['EditedEmail'],
    );
  }
}

// void main(){
//   runApp(profile());
// }

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print("HELLO");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: profilePage_Main(),
    );
  }
}

class profilePage_Main extends StatefulWidget {
  @override
  _profilePage_MainState createState() => _profilePage_MainState();
}

class _profilePage_MainState extends State<profilePage_Main> {
  final TextEditingController EditedUserName = TextEditingController();
  final TextEditingController EditEmail = TextEditingController();
  Future<AlbumEditProfile> _futureAlbumEditProfile; //this is for sending
  Future<AlbumEditProfile> futureAlbumEditProfile; //this is for fetching

  RandomColor _randomColor = RandomColor();
  Color _color =
      RandomColor().randomColor(colorBrightness: ColorBrightness.light);
  File _image; //creat an object of file
  final imagePicker = ImagePicker(); //this is the object of imagepicker class
  Future getImage() async {
    final image = await imagePicker.getImage(
        source:
            ImageSource.gallery); //this allows us to get picture from gallaey
    setState(() {
      _image = File(image.path);
    });
    ProfilePrefs.addStringToSF("PathProfilePicture", _image.path);
    pictureCounter += 1;
    ProfilePrefs.addIntToSF("pictureCount", pictureCounter);
  }

  String imageDefiner() {
    String tmpPath;
    Timer(Duration(seconds: 2), () async {
      final String returnie =
          await ProfilePrefs.getStringValuesSF("PathProfilePicture");
      print(" timer1 for path of profile picture");
      print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRProfile picture");
      print(returnie);
      tmpPath = returnie;
    });
    Timer(Duration(seconds: 4), () async {
      print(" timer2 for  cheking path");
      print(tmpPath);
      print("LLLLLLLLLLLLLLLLLLLLLL path");

      if (tmpPath == null) {
        return 'assets/software-engineer.png';
      } else {
        return tmpPath;
      }
    });
  }

  //get from shared prefrences

  // hintTextDefiner_Email()async{
  //   final String returnie=await ProfilePrefs.getStringValuesSF("email_SHP");
  //   print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRr");
  //   print(returnie.runtimeType);
  //   tmpEmail=returnie;
  //   print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR"+tmpEmail);
  //   return returnie;
  // }

  void showFlushBar(BuildContext context, String Message) {
    Flushbar(
      //message:Message ,

      //icon:,
      leftBarIndicatorColor: Colors.lightBlue,
      messageText: Text(
        Message,
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      //brar icon , inas,
      messageSize: 20,
      backgroundColor: Colors.lightBlueAccent,
      borderColor: Colors.indigo,
      messageColor: Colors.white,
      duration: Duration(seconds: 2),
    )..show(context);
  }

  void isInternetConnected() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      print("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWw");
      showFlushBar(context, "اینترنت متصل نیست");
    }
  }

  @override
  void initState() {
    tmp1 = hintTextDefiner_Username();
    tmp2 = hintTextDefiner_Email();
    super.initState();
  }

  Widget build(BuildContext context) {
    tmp1 = hintTextDefiner_Username();
    tmp2 = hintTextDefiner_Email();
    // tmpUserName=hintTextDefiner_Username();
    // tmpEmail=hintTextDefiner_Email();
    // print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDd");
    // print(tmp1);
    // print(tmpEmail);
    // print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SideMeunPage()),
                // );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              SizedBox(
                height: 150,
                width: 150,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    GestureDetector(onTap: () {
                      setState(() {
                        flag = 1;
                      });
                    }),
                    ClipRRect(
                      //Image.file(_image)
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: _color,

                        //child: _image==null ?Image.asset('assets/software-engineer.png'): FileImage(_image),
                        backgroundImage: _image == null
                            ? AssetImage('assets/software-engineer.png')
                            : FileImage(_image /*imageDefiner()*/),
                        //backgroundImage: imageFile==null ?AssetImage('assets/software-engineer.png'): Image.file(File(imageFile.path)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        // height:100,
                        //width:100,
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 25,
                            color: Colors.black,
                          ),
                          onPressed: getImage, //(){
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Container(
                child: ListTile(
                  trailing: Icon(
                    Icons.account_circle_sharp,
                    color: Colors.grey,
                  ),
                  title: TextField(
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    controller: EditedUserName,
                    decoration: InputDecoration(
                        hintText: tmp1 == "" ? tmp1 : tmpUserName,
                        border: InputBorder.none),
                  ),
                  leading: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),

                  // onTap: () => {
                  //   // Navigator.push(
                  //   //     context,
                  //   //     MaterialPageRoute(
                  //   //         builder: (context) =>
                  //   //             editUsername())
                  //   // ),
                  // },
                ),
                height: 60,
                margin: EdgeInsets.only(
                    left: 50.0, top: 10.0, right: 50.0, bottom: 10.0),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
              ),
              SizedBox(height: 30),
              Container(
                child: ListTile(
                  trailing: Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                  title: TextField(
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    controller: EditEmail,
                    decoration: InputDecoration(
                        hintText: tmp2 == "" ? tmp2 : tmpEmail,
                        border: InputBorder.none),
                  ),
                  leading: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ),
                height: 60,
                margin: EdgeInsets.only(
                    left: 50.0, top: 10.0, right: 50.0, bottom: 10.0),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
              ),
              SizedBox(height: 30),
              Container(
                child: ListTile(
                  trailing: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "ویرایش",
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    setState(() {
                      Timer(Duration(seconds: 2), () {
                        print(" This line is execute after 5 seconds");

                        if (back_answer_edit_profile_code == 200) {
                          showFlushBar(context, "مشخصات پروفایل شما ویرایش شد");
                        } else {
                          showFlushBar(context, "خطایی رخ داده است");
                        }
                      });
                      isInternetConnected();
                      _futureAlbumEditProfile = CreatAlbumProfile(
                          EditedUserName.text, EditEmail.text);
                    });
                  },
                ),
                height: 60,
                margin: EdgeInsets.only(
                    left: 50.0, top: 10.0, right: 50.0, bottom: 10.0),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
              ),
              SizedBox(height: 30),
              Container(
                child: ListTile(
                  trailing: Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  title: Text(
                    "خروج",
                    textAlign: TextAlign.right,
                  ),
                  onTap: () => {
                    ProfilePrefs.removeAll(),
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             homepage())
                    // ),
                  },
                ),
                height: 60,
                margin: EdgeInsets.only(
                    left: 50.0, top: 10.0, right: 50.0, bottom: 10.0),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
