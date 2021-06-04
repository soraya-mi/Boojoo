import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SignUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:boojoo/SideMenu/SignUpPage.dart';
import 'package:boojoo/SideMenu/restPassword.dart';
import 'package:boojoo/SideMenu/SharedPref_Class.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';

int message;
String placeholder;
String tmp="not login";
String tmp1;
String AccessTokenLogIn="";
String RefreshTokenLogIn="";
String UsernNameFromTokenLogIn="";
String EmailFromTokenLogIn="";
String PKTokenLogIn="";
String IsLoggedIN="";
// ignore: missing_return
Future<AlbumLogIn> createAlbum(String username, String password) async {
  final http.Response response = await http.post(
    Uri.http('185.235.43.184','/auth/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  print(response.body);
  print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  print(response.statusCode);
  print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
  tmp1=username;
  message=response.statusCode;
  placeholder=response.body;

  if(message==200){
    IsLoggedIN="True";
  }
  else{
    IsLoggedIN="False";
  }
  List<String>ServerResponseInList=placeholder.split(",");
  List<String>accesstoken=ServerResponseInList[0].split(":");
  List<String>refreshtoken=ServerResponseInList[1].split(":");
  List<String>pktoken=ServerResponseInList[2].split(":");
  List<String>usernametoken=ServerResponseInList[3].split(":");
  List<String>emailtoken=ServerResponseInList[4].split(":");
  AccessTokenLogIn=accesstoken[1].substring(1,accesstoken[1].length-1);
  RefreshTokenLogIn=refreshtoken[1].substring(1,refreshtoken[1].length-1);
  UsernNameFromTokenLogIn=usernametoken[1].substring(1,usernametoken[1].length-1);
  EmailFromTokenLogIn=emailtoken[1].substring(1,emailtoken[1].length-1);
  PKTokenLogIn=pktoken[2];

}

Future<AlbumLogIn> fetchAlbum() async {
  //final http.Response responseFromBack = await http.get(
  //Uri.http('37.152.182.36:8000','api/rest-auth/login/');
  final http.Response responseFromBack =await http.get(Uri.http('185.235.43.184','/schema/swagger-ui/#/auth/auth_login_create'));

  // Appropriate action depending upon the
  // server response
  print("3000000000000000000000"+responseFromBack.body);

}


class AlbumLogIn {
  final String username;

  final String password;

  AlbumLogIn({this.username, this.password});

  factory AlbumLogIn.fromJson(Map<String, dynamic> json) {
    return AlbumLogIn(
      username: json['username'],

      password: json['password'],
    );
  }
}


class LoginPage extends StatefulWidget {
  @override

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePwd = true;
  //SharedPreferences preferencesLogIn;
  final TextEditingController usernameController = TextEditingController();
  //final TextEditingController emailaddController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<AlbumLogIn> _futureAlbumLogIn;//this is for sending
  Future<AlbumLogIn> futureAlbumLogIn;//this is for fetching
  final LogInPrefs = MySharedPreferences.instance;
  void showFlushBar(BuildContext context,String Message){
    Flushbar(
      //message:Message ,

     //icon:,
      leftBarIndicatorColor: Colors.amber,
     messageText: Text(Message,textAlign: TextAlign.right,style: TextStyle(color: Colors.white,fontSize: 20),),
      //brar icon , inas,
      messageSize: 20,
      backgroundColor: Colors.black,
      borderColor: Colors.amber,
      messageColor: Colors.white,
      duration: Duration(seconds: 2),
    )..show(context);

  }



  @override
  void initState() {
    super.initState();
    // initializePreference().whenComplete((){
    //   setState(() {});
    // });
    futureAlbumLogIn = fetchAlbum();
    //final String myStringLoggedIn=await LogInPrefs.getStringValuesSF("ISLOGGEDIN");
   // if(myStringLoggedIn=="True"){//redirect to maraym homepage
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           MyHomePage()), //NoteList()),
      // );
    }


  // Future<void> initializePreference() async{
  //   this.LogInPrefs = await SharedPreferences.getInstance();
  // }
  void isInternetConnected()async{
    var result=await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.none)
    {

      showFlushBar(context, "اینترنت متصل نیست");
    }
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
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),

      body:Center(
        child:SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 40,bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('نام کاربری', style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      alignment: Alignment.centerRight,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                        controller: usernameController,
                        //placeholder:usernameController.text,
                        decoration: InputDecoration(

                            hintText: "barname",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('رمز عبور', style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                              ),
                              controller: passwordController,
                              obscureText: hidePwd,
                              decoration: InputDecoration(
                                  hintText: "****",
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: IconButton(
                                onPressed: togglePwdVisibility,
                                icon: IconButton(
                                  icon: hidePwd == true ? Icon(
                                      Icons.visibility_off
                                  ) : Icon(Icons.visibility),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>restPassword()));
                        print("onTap called.");
                      },

                      child: Container(
                      padding: EdgeInsets.only(top: 5, right: 20),
                      alignment: Alignment.centerRight,
                      child: Text('رمز خود را فراموش کرده اید؟'),

                    ),

                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.amber],
                            stops: [0, 1],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),

                      child: InkWell(
                        onTap:  (){
                          setState(() {


                            //get data with their key that we named them above

                            //final String myStringUsername = await LogInPrefs.getStringValuesSF("username_SHP");
                            // final  String myStringAccessToken =  await LogInPrefs.getStringValuesSF("access token_SHP");
                            // final String  myStringRefreshToken = await LogInPrefs.getStringValuesSF("refresh token_SHP");
                            // final  String myStringEmail = await LogInPrefs.getStringValuesSF("email_SHP");
                            // final String myStringPK = await LogInPrefs.getStringValuesSF("PK_SHP");
                            // final String myStringLoggedIn=await LogInPrefs.getStringValuesSF("ISLOGGEDIN");
                            // print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<,");
                            // print(myStringAccessToken);
                            // print(myStringRefreshToken);
                            // print(myStringUsername);
                            // print(myStringEmail);
                            // print(myStringPK);
                            // print(myStringLoggedIn);
                            // print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<,");

                            Timer(Duration(seconds: 2), () {
                              print(" This line is execute after 5 seconds");
                              //saves the data with their key and va
                              LogInPrefs.addStringToSF("username_SHP", UsernNameFromTokenLogIn/*project"*/);
                              LogInPrefs.addStringToSF("access token_SHP", AccessTokenLogIn);
                              LogInPrefs.addStringToSF("refresh token_SHP", RefreshTokenLogIn);
                              LogInPrefs.addStringToSF("email_SHP", EmailFromTokenLogIn);
                              LogInPrefs.addStringToSF("PK_SHP", PKTokenLogIn);
                              LogInPrefs.addStringToSF("ISLOGGEDIN", IsLoggedIN);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        profile()), //NoteList()),
                              );

                              if (message == 200) {// redirect to maryam home page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          profile()), //NoteList()),
                                );
                              }
                              else {

                                // final snackBar2 =  SnackBar(content: Text(" !خطایی رخ داده است ",textAlign: TextAlign.right));
                                // ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                                showFlushBar(context, "خطایی رخ داده است");
                              }

                            });
                            isInternetConnected();
                            _futureAlbumLogIn =   createAlbum(usernameController.text,
                                passwordController.text);


                            // }
                            print(placeholder);
                            print("ffffffffffffffffffffffffffffffff");
                            print(usernameController.text);



                          });
                        },

                        child: Center(
                          child: Text("وارد شدن", style: TextStyle(

                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          ),),

                        ),

                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      child: Center(
                        child: Text('---- راه حل دیگر ----'),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 30,),
                        Container(
                          width: 50,
                          height: 50,
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("حساب کاربری ندارید ؟  "),
                        InkWell(
                          onTap: openSignUpPage,
                          child: Text("ایجاد حساب کاربری", style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w700
                          ),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          //),

        ],
      ),
        ),
          ),
    );

  }



  void openSignUpPage()
  {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
  }
  void togglePwdVisibility()
  {
    hidePwd = !hidePwd;
    setState(() {

    });
  }
}



//codes for getting new access token using refresh token
int back_answer_refresh_token_status_code;
String back_answer_refresh_token_body;
class AlbumRefresh {
  final String newAccessToken;
  AlbumRefresh({this.newAccessToken});
  factory AlbumRefresh.fromJson(Map<String,dynamic>json){
    return     AlbumRefresh(
      newAccessToken: json['newAccessToken'],
    );
  }

}//write this class before statefull class that you have
Future<AlbumRefresh> createAlbumRefresh(String newAccessToken)async{
  final http.Response responseNewAccessToken=await http.post(
      Uri.http('185.235.43.184','/auth/token/refresh/'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String,String>{
      'newAccessToken':newAccessToken,
  }),


);
back_answer_refresh_token_status_code=responseNewAccessToken.statusCode;
back_answer_refresh_token_body=responseNewAccessToken.body;
print("DEBUG BACK ANSWER STATUS");
print(back_answer_refresh_token_status_code);
print("DEBUF BACK ANSWER BODY");
print(back_answer_refresh_token_body);
if(back_answer_refresh_token_status_code==200){
  print("access token is going to be updated");

  updatePrefs.removeValuesString("access token_SHP");//this removes the prevoius content of acess token
  updatePrefs.addStringToSF("access token_SHP", back_answer_refresh_token_body);//this assign the new value of access token to it
  final  String myStringAccessToken =  await updatePrefs.getStringValuesSF("access token_SHP");// this is for printing the result to check
  print(myStringAccessToken);

}
else{
  print("something bad happens ");
}


}
final updatePrefs=MySharedPreferences.instance;//write in the statfull
Future<AlbumRefresh> futureAlbumRefresh;//write this in statefull

//use this function wen you want to click on a button and send refresh token to back;
void sendRefreshTokenToBack(){
  String tmpRefresh;
  Timer(Duration(seconds: 2), ()async {
    final String returnie=await updatePrefs.getStringValuesSF("refresh token_SHP");
    print(" timer1 for gettings refresh token");
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRr refresh token");
    print(returnie);
    tmpRefresh = returnie;
  }
  );
  Timer(Duration(seconds: 4), () {
    print(" timer2 for printting refresh token");
    print(tmpRefresh);
    print("LLLLLLLLLLLLLLLLLLLLLL refesh token");
    futureAlbumRefresh =   createAlbumRefresh(tmpRefresh);//this sends refresh token to back

  }
  );

}













