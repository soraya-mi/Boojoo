import 'dart:async';
import 'dart:convert';
import 'package:boojoo/Challenge/Challenge_Detail.dart';
import 'package:boojoo/Challenge/Challenge_Detail2.dart';
import 'package:boojoo/Challenge/Challenge_for_list.dart';
import 'package:boojoo/Challenge/API_Response.dart';
import 'package:boojoo/SideMenu/LoginPage.dart';
import 'package:boojoo/SideMenu/Profile_Editing_main.dart';
import 'package:boojoo/SideMenu/SharedPref_Class.dart';
import 'package:http/http.dart' as http;

import 'join_private_detail.dart';
import 'join_public_detail.dart';

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
    Uri.http('37.152.182.36:8000','api/auth/token/refresh/'),
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

    // updatePrefs.removeValuesString("access token_SHP");//this removes the prevoius content of acess token
    // updatePrefs.addStringToSF("access token_SHP", back_answer_refresh_token_body);//this assign the new value of access token to it
    // final  String myStringAccessToken =  await updatePrefs.getStringValuesSF("access token_SHP");// this is for printing the result to check
    // print(myStringAccessToken);

  }
  else{
    print("something bad happens ");
  }


}
final updatePrefs=MySharedPreferences.instance;//write in the statfull
Future<AlbumRefresh> futureAlbumRefresh;//write this in statefull

//use this function when you want to click on a button and send refresh token to back;
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





final token= MySharedPreferences.instance;
String hintTextDefiner_Email(){

  Timer(Duration(seconds: 2), ()async {
    final String returnie=await token.getStringValuesSF("access token_SHP");
    print(" timer1 for gettings email");
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRr email");
    print(returnie);
    tmpUserName = returnie;
  }
  );

  Timer(Duration(seconds: 4), () {

    print(" timer2 for printting email");
    print(tmpUserName);
    print("LLLLLLLLLLLLLLLLLLLLLL email");

    return tmpUserName;

  }
  );
}
String auth_token= hintTextDefiner_Email();
class challengeservice{
  String API = 'http://185.235.43.184/';
  Map<String, String> headers = {
    'Authorization': 'Bearer $auth_token',
    'Content-Type' : 'application/json'
  };



  Future<APIresponse<List<challenge_for_list>>> getchallengelist() async{
    await sendRefreshTokenToBack();
    return http.get(API + 'challenge/my-challenges', headers : headers).
    then((data){
      print(data.statusCode);
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final challenges = <challenge_for_list>[];
        for(var i in jsonData)
        {
          challenges.add(challenge_for_list.fromJson(i));
        }
        return APIresponse<List<challenge_for_list>>(data: challenges);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!');
    }).catchError((_) => APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!'));

  }


  Future<APIresponse<challengedetail>> getchallenge(int id) async{
    await sendRefreshTokenToBack();
    return http.get(API + 'challenge/challenge/', headers : headers).
    then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIresponse<challengedetail>(
            data: challengedetail.fromJson(jsonData));
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<challengedetail>(error: true, errormassege: 'An error occured!');
    }).catchError((_) => APIresponse<challengedetail>(error: true, errormassege: 'An error occured!'));

  }

  Future<APIresponse<bool>> createchallengepublic(challengedetail item) async{
    await sendRefreshTokenToBack();
    return http.post(API + 'challenge/public-challenge/add/', headers : headers, body: json.encode(item.toJson())).
    then((data) {
      print(data.statusCode);
      if (data.statusCode == 201) {
        print(data.statusCode);
        return APIresponse<bool>(data: true);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<bool>(error: true, errormassege: 'An error occured!');
    }).catchError((_) => APIresponse<bool>(error: true, errormassege: 'An error occured!'));

  }
  Future<APIresponse<bool>> createchallengeprivate(challengedetail2 item) async{
    await sendRefreshTokenToBack();
    return http.post(API + 'challenge/private-challenge/add/', headers : headers, body: json.encode(item.toJson())).
    then((data) {
      print(data.statusCode);
      if (data.statusCode == 201) {
        print(data.statusCode);
        return APIresponse<bool>(data: true);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<bool>(error: true, errormassege: 'An error occured!');
    }).catchError((_) => APIresponse<bool>(error: true, errormassege: 'An error occured!'));

  }

  Future<APIresponse<List<challenge_for_list>>> getchallenge_pr_life() async{
    await sendRefreshTokenToBack();
    return http.get(API + 'challenge/private-challenges-lifestyle/', headers : headers).
    then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final challenges = <challenge_for_list>[];
        for(var i in jsonData)
        {
          challenges.add(challenge_for_list.fromJson(i));
        }
        return APIresponse<List<challenge_for_list>>(data: challenges);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!');
    }).catchError((_) => APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!'));

  }

  Future<APIresponse<List<challenge_for_list>>> getchallenge_pr_health() async{
    await sendRefreshTokenToBack();
    return http.get(API + 'challenge/private-challenges-health/', headers : headers).
    then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final challenges = <challenge_for_list>[];
        for(var i in jsonData)
        {
          challenges.add(challenge_for_list.fromJson(i));
        }
        return APIresponse<List<challenge_for_list>>(data: challenges);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!');
    }).catchError((_) => APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!'));

  }

  Future<APIresponse<List<challenge_for_list>>> getchallenge_pr_sport() async{
    await sendRefreshTokenToBack();
    return http.get(API + 'challenge/private-challenges-sport/', headers : headers).
    then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final challenges = <challenge_for_list>[];
        for(var i in jsonData)
        {
          challenges.add(challenge_for_list.fromJson(i));
        }
        return APIresponse<List<challenge_for_list>>(data: challenges);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!');
    }).catchError((_) => APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!'));

  }

  Future<APIresponse<List<challenge_for_list>>> getchallenge_pu_life() async{
    await sendRefreshTokenToBack();
    return http.get(API + 'challenge/public-challenges-lifestyle/', headers : headers).
    then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final challenges = <challenge_for_list>[];
        for(var i in jsonData)
        {
          challenges.add(challenge_for_list.fromJson(i));
        }
        return APIresponse<List<challenge_for_list>>(data: challenges);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!');
    }).catchError((_) => APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!'));

  }

  Future<APIresponse<List<challenge_for_list>>> getchallenge_pu_health() async{
    await sendRefreshTokenToBack();
    return http.get(API + 'challenge/public-challenges-health/', headers : headers).
    then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final challenges = <challenge_for_list>[];
        for(var i in jsonData)
        {
          challenges.add(challenge_for_list.fromJson(i));
        }
        return APIresponse<List<challenge_for_list>>(data: challenges);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }

      return APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!');
    }).catchError((_) => APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!'));

  }

  Future<APIresponse<List<challenge_for_list>>> getchallenge_pu_sport() async{
    await sendRefreshTokenToBack();
    return http.get(API + 'challenge/public-challenges-sport/', headers : headers).
    then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final challenges = <challenge_for_list>[];
        for(var i in jsonData)
        {
          challenges.add(challenge_for_list.fromJson(i));
        }
        return APIresponse<List<challenge_for_list>>(data: challenges);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!');
    }).catchError((_) => APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!'));

  }

  Future<APIresponse<bool>> joinprivatechallenge(joinprivateinfo item) async{
    await sendRefreshTokenToBack();
    return http.post(API + 'challenge/join-private-challenge/', headers : headers, body: json.encode(item.toJson())).
    then((data) {
      print(data.statusCode);
      if (data.statusCode == 201) {
        print(data.statusCode);
        return APIresponse<bool>(data: true);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<bool>(error: true, errormassege: 'An error occured!');
    }).catchError((_) => APIresponse<bool>(error: true, errormassege: 'An error occured!'));

  }
  Future<APIresponse<bool>> joinpublicchallenge(joinpublicinfo item) async{
    await sendRefreshTokenToBack();
    return http.post(API + 'challenge/join-public-challenge/', headers : headers, body: json.encode(item.toJson())).
    then((data) {
      print(data.statusCode);
      if (data.statusCode == 201) {
        print(data.statusCode);
        return APIresponse<bool>(data: true);
      }
      else if(data.statusCode == 401){
        return APIresponse<List<challenge_for_list>>(error: true, errormassege: '(:جانم اول لاگین کن');
      }
      return APIresponse<bool>(error: true, errormassege: 'An error occured!');
    }).catchError((_) => APIresponse<bool>(error: true, errormassege: 'An error occured!'));

  }

}