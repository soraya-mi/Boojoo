import 'package:boojoo/Challenge/Challenge_Detail.dart';
import 'package:boojoo/ui/detail/detail_page_mychallenge.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/ui/common/separator.dart';
import 'package:boojoo/ui/detail/detail_page.dart';

import '../../model/planets.dart';
import '../text_style.dart';

class challenge_for_listSummary2 extends StatefulWidget {

  final challengedetail planet;
  final bool horizontal;

  challenge_for_listSummary2(this.planet, {this.horizontal = true});

  challenge_for_listSummary2.vertical(this.planet): horizontal = false;

  @override
  _challenge_for_listSummary2State createState() => _challenge_for_listSummary2State();
}

class _challenge_for_listSummary2State extends State<challenge_for_listSummary2> {
  @override
  Widget build(BuildContext context) {

    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: widget.horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "planet-hero-${widget.planet.id}",
        child: new Image(
          image: new AssetImage('assets/img/mars.png'),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );



    Widget _planetValue({String value,String image}) {
      return new Container(
        child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(image, height: 12.0),
              new Container(width: 8.0),
              new Text(value, style: Style.smallTextStyle),
            ]
        ),
      );
    }


    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(widget.horizontal ? 76.0 : 16.0, widget.horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: widget.horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(widget.planet.title, style: Style.titleTextStyle),
          new Container(height: 10.0),
          new Text(widget.planet.owner.toString(), style: Style.commonTextStyle),
          new Separator(),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(

                    child: _planetValue(
                        value: widget.planet.startdate.toString(),
                        image: 'assets/img/ic_distance.png')

                ),
                Container(
                  width: widget.horizontal ? 8.0 : 32.0,
                ),
                Expanded(

                    child: _planetValue(
                        value: widget.planet.enddate.toString(),
                        image: 'assets/img/end.png')
                )
              ],
            ),
          ),
          // Container(
          //   height: horizontal ? 32.0 : 4.0,
          // ),
          new Expanded(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(

                    child: _planetValue(
                        value: widget.planet.days.toString(),
                        image: 'assets/img/day.png')

                ),
                Container(
                  width: widget.horizontal ? 8.0 : 32.0,
                ),
                Expanded(

                    child: _planetValue(
                        value: widget.planet.users.length.toString(),
                        image: 'assets/img/num.png')
                )
              ],
            ),
          ),
        ],
      ),
    );














    final planetCard = new Container(
      child: planetCardContent,
      height: widget.horizontal ? 200.0 : 220.0,
      margin: widget.horizontal
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
    // final planetCard2 = new Container(
    //   child: planetCardContent,
    //   height: horizontal ? 200.0 : 220.0,
    //   margin: horizontal
    //       ? new EdgeInsets.only(left: 46.0)
    //       : new EdgeInsets.only(top: 72.0),
    //   decoration: new BoxDecoration(
    //     color: new Color(0xFF333366),
    //     shape: BoxShape.rectangle,
    //     borderRadius: new BorderRadius.circular(8.0),
    //     boxShadow: <BoxShadow>[
    //       new BoxShadow(
    //         color: Colors.black12,
    //         blurRadius: 10.0,
    //         offset: new Offset(0.0, 10.0),
    //       ),
    //     ],
    //   ),
    // );


    return new GestureDetector(
        onTap: widget.horizontal
            ? () => Navigator.of(context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new DetailPage2(widget.planet),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
          ) ,
        )
            : null,
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              planetCard,
              // planetCard2,
              planetThumbnail,

            ],
          ),
        )
    );
  }
}
