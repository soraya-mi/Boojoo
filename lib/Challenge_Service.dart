import 'dart:convert';
import 'package:api_test/Challenge_Detail.dart';
import 'package:api_test/Challenge_for_list.dart';
import 'package:api_test/API_Response.dart';
import 'package:api_test/insert_note.dart';
import 'package:http/http.dart' as http;

class challengeservice{

  static const API = 'http://37.152.182.36:8001';
  static const headers = {
    'apikey' : '',
    'Content-Type' : 'application/json'
  };

  Future<APIresponse<List<challenge_for_list>>> getchallengelist(){
    return http.get(API + '/challenges/', headers : headers).
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
      return APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!');
    }).catchError((_) => APIresponse<List<challenge_for_list>>(error: true, errormassege: 'an error occured!'));

  }


  Future<APIresponse<challenge_for_list>> getchallenge(String id){
    return http.get(API + id, headers : headers).
    then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIresponse<challenge_for_list>(
            data: challenge_for_list.fromJson(jsonData));
      }
      return APIresponse<challenge_for_list>(error: true, errormassege: 'An error occured!');
    }).catchError((_) => APIresponse<challenge_for_list>(error: true, errormassege: 'An error occured!'));

  }

  Future<APIresponse<bool>> createchallenge(challengedetail item){
    return http.post(API + '/challenge/add/', headers : headers, body: json.encode(item.toJson())).
    then((data) {
      print(data.statusCode);
      if (data.statusCode == 201) {
        print(data.statusCode);
        return APIresponse<bool>(data: true);
      }
      return APIresponse<bool>(error: true, errormassege: 'An error occured!');
    }).catchError((_) => APIresponse<bool>(error: true, errormassege: 'An error occured!'));

  }

}