import 'package:boojoo/ui/common/plannet_summary3.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/ui/common/plannet_summary.dart';
import 'package:boojoo/Challenge/Challenge_Service.dart';
import 'package:boojoo/Challenge/API_Response.dart';
import 'package:boojoo/Challenge/Challenge_for_list.dart';
import 'package:get_it/get_it.dart';

class HomePageBodyHealthPublic extends StatefulWidget {
  @override
  _HomePageBodyHealthPublicState createState() => _HomePageBodyHealthPublicState();
}

class _HomePageBodyHealthPublicState extends State<HomePageBodyHealthPublic> {


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

    _apiResponse = (await service.getchallenge_pu_health()) ;

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return new Expanded(
      child: Scaffold(
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
      ),
=======
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
>>>>>>> 9fdef8eedc2657b35673a5668abd7e9ece27cfae
    );
  }

}
