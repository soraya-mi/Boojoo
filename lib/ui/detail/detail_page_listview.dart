import 'dart:async';

import 'package:boojoo/Challenge/API_Response.dart';
import 'package:boojoo/Challenge/Challenge_Detail.dart';
import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:boojoo/Challenge/join_private_detail.dart';
import 'package:boojoo/SideMenu/Profile_Editing_main.dart';
import 'package:boojoo/SideMenu/SharedPref_Class.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/model/planets.dart';
import 'package:boojoo/ui/common/plannet_summary2.dart';
import 'package:boojoo/ui/common/separator.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../text_style.dart';
import 'package:boojoo/Challenge/join_private_detail.dart';


class DetailPage extends StatefulWidget {

  final challengedetail planet;

  DetailPage(this.planet);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  TextEditingController _passwordcontroller = TextEditingController();

  challengeservice get service => GetIt.I<challengeservice>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Builder(builder: (_) {
        if (widget.planet.private_pub == 'PU') {
          return new Container(
            constraints: new BoxConstraints.expand(),
            color: new Color(0xFF736AB7),
            child: new Stack(
              children: <Widget>[
                // _getBackground(),
                _getGradient(),
                _getContentPU(),
                _getToolbar(context),
              ],
            ),
          );
        }
        else {
          return new Container(
            constraints: new BoxConstraints.expand(),
            color: new Color(0xFF736AB7),
            child: new Stack(
              children: <Widget>[
                // _getBackground(),
                _getGradient(),
                _getContentPR(),
                _getToolbar(context),
              ],
            ),
          );
        }
      }
      ),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            new Color(0x00736AB7),
            new Color(0xFF736AB7)
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContentPU() {
    final _overviewTitle = "توضیحات";
    final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

    void _doSomething() async {
      Timer(Duration(seconds: 3), () {
        _btnController.success();
      });
    }
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 32.0),
        children: <Widget>[
          new challenge_for_listSummary2(
            widget.planet,
            horizontal: false,
          ),
          new Container(
            child: RoundedLoadingButton(
              child: new Text("بیا تو!", style: Style.titleTextStyle),
              controller: _btnController,
              onPressed: () async {
                // print(_valuePicker2.substring(0,9));
                final ProfilePrefs = MySharedPreferences.instance;
                String hintTextDefiner_Username() {
                  Timer(Duration(seconds: 2), () async {
                    final String returnie =
                    await ProfilePrefs.getStringValuesSF("PK_SHP");
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
                int UserId= int.parse(hintTextDefiner_Username()) ;



                final joinreq = joinprivateinfo(
                      user_id:  UserId,
                      challenge_id: widget.planet.id,
                      password: _passwordcontroller.toString()
                  );

                  final result =
                  await service.joinprivatechallenge(joinreq);

                  if (result.error){
                  final title = 'انجام شد !';
                  final text = result.error
                      ? (result.errormassege ?? 'خطایی رخ داده !')
                      : 'چالش جدید با موفقیت ایجاد شد !';

                  showDialog(
                      context: context,
                      builder: (_) =>
                          AlertDialog(
                            title: Text(title),
                            content: Text(text),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"))
                            ],
                          )).then((data) {
                    if (result.data) {
                      Navigator.of(context).pop();
                    }
                  }
                  );
                }

                else{
                    _doSomething();
                }


              },
              color: new Color(0xff00c6ff),
            ),

          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_overviewTitle,
                  style: Style.headerTextStyle,),
                new Separator(),
                new Text(
                    widget.planet.description, style: Style.commonTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
















  Container _getContentPR() {
    final _overviewTitle = "توضیحات";
    final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

    void _doSomething() async {
      Timer(Duration(seconds: 3), () {
        _btnController.success();
      });
    }
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 32.0),
        children: <Widget>[
          new challenge_for_listSummary2(widget.planet,
            horizontal: false,
          ),
          TextFormField(
            controller: _passwordcontroller,
            decoration: InputDecoration(
                hintText: 'رمز اول بلا!',
                labelStyle: Style.titleTextStyle
            ),
          ),
          new Container(
            child: RoundedLoadingButton(
              child: new Text("بیا تو!", style: Style.titleTextStyle),
              controller: _btnController,
              onPressed: () async {
                // print(_valuePicker2.substring(0,9));
                final ProfilePrefs = MySharedPreferences.instance;
                String hintTextDefiner_Username() {
                  Timer(Duration(seconds: 2), () async {
                    final String returnie =
                    await ProfilePrefs.getStringValuesSF("PK_SHP");
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
                int UserId= int.parse(hintTextDefiner_Username()) ;



                final joinreq = joinprivateinfo(
                    user_id: UserId,
                    challenge_id: widget.planet.id,
                    password: _passwordcontroller.toString()
                );

                final result =
                await service.joinprivatechallenge(joinreq);

                if (result.error){
                  final title = 'انجام شد !';
                  final text = result.error
                      ? (result.errormassege ?? 'خطایی رخ داده !')
                      : 'چالش جدید با موفقیت ایجاد شد !';

                  showDialog(
                      context: context,
                      builder: (_) =>
                          AlertDialog(
                            title: Text(title),
                            content: Text(text),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"))
                            ],
                          )).then((data) {
                    if (result.data) {
                      Navigator.of(context).pop();
                    }
                  }
                  );
                }

                else{
                  _doSomething();
                }


              },
              color: new Color(0xff00c6ff),
            ),

          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_overviewTitle,
                  style: Style.headerTextStyle,),
                new Separator(),
                new Text(
                    widget.planet.description, style: Style.commonTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }





















  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top),
      child: new BackButton(color: Colors.white),
    );
  }
}

