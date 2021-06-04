import 'package:boojoo/Challenge/Challenge_Create.dart';
import 'package:boojoo/Challenge/challenge_group.dart';
import 'package:boojoo/ui/home/home_page_body2.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/ui/text_style.dart';

import '../text_style.dart';
import 'home_page_body.dart';

class HomePage2 extends StatelessWidget {
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
              .push(MaterialPageRoute(builder: (_) => challenge_create()));
        },
      ),
      body: new Column(
        children: <Widget>[
          new HomePageBody(),
        ],
      ),

    );
  }
}

