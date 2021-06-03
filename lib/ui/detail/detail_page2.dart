import 'dart:async';

import 'package:flutter/material.dart';
import 'package:boojoo/model/planets.dart';
import 'package:boojoo/ui/common/plannet_summary2.dart';
import 'package:boojoo/ui/common/separator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../text_style.dart';


class DetailPage2 extends StatelessWidget {

  final Planet planet;

  DetailPage2(this.planet);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: new Color(0xFF736AB7),
        child: new Stack (
          children: <Widget>[
            // _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }
  //
  // Container _getBackground () {
  //   return new Container(
  //           child: new Image.network(planet.picture,
  //             fit: BoxFit.cover,
  //             height: 300.0,
  //           ),
  //           constraints: new BoxConstraints.expand(height: 295.0),
  //         );
  // }

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


  Container _getContent() {
    final _overviewTitle = "توضیحات";
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 32.0),
        children: <Widget>[
          new PlanetSummary2(planet,
            horizontal: false,
          ),
          new Expanded(
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size(46, 46), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: new Color(0xFF333366), // button color
                      child: InkWell(
                        splashColor:  new Color(0xFF736AB7),  // splash color
                        onTap: () {}, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.favorite_rounded,color: new Color(0xFF736AB7),), // icon
                             // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox.fromSize(
                  size: Size(46, 46), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: new Color(0xFF333366), // button color
                      child: InkWell(
                        splashColor:  new Color(0xFF736AB7),  // splash color
                        onTap: () {}, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.share_rounded,color: new Color(0xFF736AB7),), // icon
                           // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Container(
                //   width: horizontal ? 8.0 : 32.0,
                // ),


      SizedBox.fromSize(
        size: Size(46, 46),// button width and height
        child: ClipOval(
          child: Material(
            color: new Color(0xFF333366), // button color
            child: InkWell(
              splashColor:  new Color(0xFF736AB7),  // splash color
              onTap: () {}, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.assignment_rounded,color: new Color(0xFF736AB7),), // icon
                  // text
                ],
              ),
            ),
          ),
        ),
      ),


              ],
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
                    planet.description, style: Style.commonTextStyle),
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
