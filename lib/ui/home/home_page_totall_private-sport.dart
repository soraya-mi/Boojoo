
import 'package:boojoo/Challenge/Challenge_Create_private.dart';
import 'package:boojoo/Challenge/challenge_group_public.dart';
import 'package:boojoo/ui/home/home_page_body-private-sport.dart';
import 'package:boojoo/ui/home/home_page_body_mychallenges.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/ui/text_style.dart';

import '../text_style.dart';
import 'home_page_body-public-sport.dart';


class HomePagePrivateSport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add,color:Colors.white,),
        label: new Text('چالش خودتو بساز!',
            style: Style.titleTextStyle
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => challenge_create_private()));
        },
      ),
      body: new Column(
        children: <Widget>[
          new HomePageBodySportPrivate(),
        ],
      ),

    );
  }
}

