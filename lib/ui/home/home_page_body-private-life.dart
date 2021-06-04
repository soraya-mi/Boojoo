import 'package:boojoo/ui/common/plannet_summary3.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/model/planets.dart';
import 'package:boojoo/ui/common/plannet_summary.dart';

class HomePageBodyLifePrivate extends StatefulWidget {
  @override
  _HomePageBodyLifePrivateState createState() => _HomePageBodyLifePrivateState();
}

class _HomePageBodyLifePrivateState extends State<HomePageBodyLifePrivate> {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        color: new Color(0xFF736AB7),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new PlanetSummary(planets[index]),
                  childCount: planets.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
