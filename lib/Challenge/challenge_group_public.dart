import 'package:boojoo/ui/home/home_page_totall_public-health.dart';
import 'package:boojoo/ui/home/home_page_totall_public-life.dart';
import 'package:boojoo/ui/home/home_page_totall_public-sport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Challenge_List.dart';

class TabBarchallengePublicGroup extends StatelessWidget {
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
              HomePagePublicLife(),
              HomePagePublicHealth(),
              HomePagePublicSport(),
            ],
          ),
        ),

    );
  }
}
