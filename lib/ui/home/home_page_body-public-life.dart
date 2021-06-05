import 'package:boojoo/ui/common/plannet_summary3.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/model/planets.dart';
import 'package:boojoo/ui/common/plannet_summary.dart';
import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:boojoo/Challenge/API_Response.dart';
// import 'package:boojoo/Challenge/Challenge_for_list.dart';
import 'package:get_it/get_it.dart';

class HomePageBodyLifePublic extends StatefulWidget {
  @override
  _HomePageBodyLifePublicState createState() => _HomePageBodyLifePublicState();
}

class _HomePageBodyLifePublicState extends State<HomePageBodyLifePublic> {

  challengeservice get service => GetIt.I<challengeservice>();
  APIresponse<List<challenge_for_list>> _apiResponse;
  bool _isLoading = false;


  @override
  void initState(){
    _fetchchallenge();
    super.initState();
  }

  _fetchchallenge() async{
    setState(() {
      _isLoading = true;
    });

    _apiResponse = (await service.getchallenge_pu_life()) as APIresponse<List<challenge_for_list>>;

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_apiResponse?.error) {
              return Center(child: Text(_apiResponse.errormassege));
            }
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
                              (context, index) => new challenge_for_listSummary(_apiResponse.data[index]),
                          childCount: _apiResponse.data.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }

}
