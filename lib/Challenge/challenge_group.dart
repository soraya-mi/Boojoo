import 'package:boojoo/ui/home/home_page2.dart';
import 'package:boojoo/ui/home/home_page_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Challenge_List.dart';

class TabBarchallengeGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "زندگی",
                ),
                Tab(
                  text: "سلامتی",
                ),
                Tab(
                  text: "ورزش",
                ),
              ],
            ),
            title: Text(
              "چالش ها",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            actions: <Widget>[
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.arrow_back),
              // ),
            ],
          ),
          body: TabBarView(
            children: [
              HomePage2(),
              HomePage2(),
              HomePage2(),
            ],
          ),
        ),

    );
  }
}
