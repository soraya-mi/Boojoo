import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'LoginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boojoo/SideMenu//SharedPref_Class.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
//import 'home-page.dart';
int messageStatusCode=-1;
String tmpUsername="";
String backAnswer="";
String errorTeller="کاربر گرامی خطایی رخ داده است. \n نام کاربری نباید تکراری باشد  همچنین رمز عبور باید حداقل شامل 10 کاراکتر از جمله حروف و اعداد باشد";
String AccessTokenSignUp="";
String RefreshTokenSignUp="";
String UsernNameFromTokenSignUp="";
String EmailFromTokenSignUp="";
String PKTokenSignUp="";

// ignore: missing_return
Future<AlbumSignUp> createAlbumSigUp(String username,String email,String password1, String password2) async {
  final http.Response response1 = await http.post(
    Uri.http('185.235.43.184', '/auth/registration/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'email':email,
      'password1': password1,
      'password2': password2,
    }),
  );
  print("ddd");
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  print(response1.statusCode);
  print(response1.body);
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  tmpUsername=username;
  backAnswer=response1.body;
  messageStatusCode=response1.statusCode;

  List<String>ServerResponseInListS=backAnswer.split(",");
  List<String>accesstokenS=ServerResponseInListS[0].split(":");
  List<String>refreshtokenS=ServerResponseInListS[1].split(":");
  List<String>pktokenS=ServerResponseInListS[2].split(":");
  List<String>usernametokenS=ServerResponseInListS[3].split(":");
  List<String>emailtokenS=ServerResponseInListS[4].split(":");
  AccessTokenSignUp=accesstokenS[1].substring(1,accesstokenS[1].length-1);
  RefreshTokenSignUp=refreshtokenS[1].substring(1,refreshtokenS[1].length-1);
  UsernNameFromTokenSignUp=usernametokenS[1].substring(1,usernametokenS[1].length-1);
  EmailFromTokenSignUp=emailtokenS[1].substring(1,emailtokenS[1].length-1);
  PKTokenLogIn=pktokenS[2];


}
class AlbumSignUp {
  final String username;
  final String email;

  final String password1;
  final String password2;


  AlbumSignUp({this.username,this.email, this.password1, this.password2});

  factory AlbumSignUp.fromJson(Map<String, dynamic> json) {
    return AlbumSignUp(
      username: json['username'],
      email: json['email'],

      password1: json['password1'],
      password2: json['password2'],
    );
  }
}
Future printSixToTen() async {
  for(int i = 6; i <= 10; ++i) {
    await new Future.delayed(const Duration(seconds: 1), () {
      print(i);
    });
  }
}
void wastetime(){
  for(int i=11;i<=20;i++)
  {
    print(i);
  }
}
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController password1Controller=TextEditingController();
  final TextEditingController password2Controller=TextEditingController();
  final SignUpPrefs = MySharedPreferences.instance;
  Future<AlbumSignUp> _futureAlbumSignUp;
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

  void isInternetConnected()async{
    var result=await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.none)
    {
      print("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWw");
      showFlushBar(context, "اینترنت متصل نیست");
    }
  }
  bool hidePwd = true;
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
            onPressed: (){Navigator.pop(context);},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child:SingleChildScrollView(
          child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          SingleChildScrollView(
            // child: Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(40)),
            //     color: Colors.grey.withOpacity(0.3),
            //   ),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 40,bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('نام کاربری', style: TextStyle(
                        color:Colors.black.withOpacity(0.7),
                        fontSize: 15,
                        //print("username is on");
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                        decoration: InputDecoration(
                            hintText: "مثال : ghazal ",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('ایمیل', style: TextStyle(
                        color:Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                        controller: emailController,

                        decoration: InputDecoration(
                            hintText: "مثال : gmail.com",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text('رمز عبور', style: TextStyle(
                        color:Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                              obscureText: hidePwd,
                              controller: password1Controller,
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
                                  ): Icon(Icons.visibility),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerRight,
                      child: Text(' تایید رمز عبور', style: TextStyle(
                        color:Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                              obscureText: hidePwd,
                              controller: password2Controller,
                              decoration: InputDecoration(
                                  hintText: "****",
                                  border: InputBorder.none
                              ),
                            ),
<<<<<<< HEAD
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {


                              Timer(Duration(seconds: 5), () {

                                if (messageStatusCode == 201) {
                                  print(" This line is execute after 5 seconds");
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           MyHomePage()), //NoteList()),
                                  // );

                                  showFlushBar(context,  " .عزیز حساب کاربری شما ساخته شد  " + tmpUsername);
                                  print("sign up");
                                  SignUpPrefs.addStringToSF("username_SHP_SI", UsernNameFromTokenSignUp);
                                  SignUpPrefs.addStringToSF("access token_SHP_SI", AccessTokenSignUp);
                                  SignUpPrefs.addStringToSF("refresh token_SHP_SI", RefreshTokenSignUp);
                                  SignUpPrefs.addStringToSF("email_SHP_SI", EmailFromTokenSignUp);
                                  SignUpPrefs.addStringToSF("PK_SHP_SI", PKTokenSignUp);
=======
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: IconButton(
                                onPressed: togglePwdVisibility,
                                icon: IconButton(
                                  icon: hidePwd == true ? Icon(
                                      Icons.visibility_off
                                  ): Icon(Icons.visibility),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(top: 5, right: 20),
                    //   alignment: Alignment.centerRight,
                    //   child: Text('رمز عبور خود را فراموش کرده اید؟'),
                    // ),
                     SizedBox(height: 50,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffffeb3b), Color(0xffffc107)],
                            stops: [0,1],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
>>>>>>> 9fdef8eedc2657b35673a5668abd7e9ece27cfae


                            Timer(Duration(seconds: 5), () {

                              if (messageStatusCode == 201) {
                                print(" This line is execute after 5 seconds");
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           MyHomePage()), //NoteList()),
                                // );

<<<<<<< HEAD
                              print("on tap");
                              _futureAlbumSignUp =  createAlbumSigUp(usernameController.text,emailController.text,
                                  password1Controller.text,password2Controller.text);
                              showFlushBar(context, "لطفا صبر کنید");
                            });

                          },
=======
                                showFlushBar(context,  " .عزیز حساب کاربری شما ساخته شد  " + tmpUsername);
                                print("sign up");
                                SignUpPrefs.addStringToSF("username_SHP_SI", UsernNameFromTokenSignUp);
                                SignUpPrefs.addStringToSF("access token_SHP_SI", AccessTokenSignUp);
                                SignUpPrefs.addStringToSF("refresh token_SHP_SI", RefreshTokenSignUp);
                                SignUpPrefs.addStringToSF("email_SHP_SI", EmailFromTokenSignUp);
                                SignUpPrefs.addStringToSF("PK_SHP_SI", PKTokenSignUp);

                              }

                              else {

                                if (backAnswer.contains("password") ) {
                                  showFlushBar(context, ".رمز عبور باید حداقل شامل 10 کاراکتر حرف و عدد باشد");
                                  print("error password");
                                }
                                if (backAnswer.contains("username")) {
                                 showFlushBar(context, ".نام کاربری مورد نظر قبلا انتخاب شده است");
                                  print("error username");
                                }
                                if (backAnswer.contains("email")) {
                                  showFlushBar(context,  ".ایمیل مورد نظر اکانت دارد. لطفا با یک ایمیل دیگر اقدام کنید");
                                  print("error email");
                                }
                              }
                            });

                            print("on tap");
                            _futureAlbumSignUp =  createAlbumSigUp(usernameController.text,emailController.text,
                                password1Controller.text,password2Controller.text);
                            showFlushBar(context, "لطفا صبر کنید");
                          });
>>>>>>> 9fdef8eedc2657b35673a5668abd7e9ece27cfae

                        },


                        child: Center(
                          child: Text("ساخت حساب کاربری", style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("اکانت دارید؟ "),
                        InkWell(
                          onTap: openLoginPage,
                          child: Text(" وارد شدن ", style: TextStyle(
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

        ],
      ),
    ),
      ),
    );
  }
  void openLoginPage()
  {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  void togglePwdVisibility()
  {
    hidePwd = !hidePwd;
    setState(() {

    });
  }
}




//commnt for test
