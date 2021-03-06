
import 'package:boojoo/Challenge/Challenge_Create_private.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boojoo/Challenge/Challenge_for_list.dart';
import 'package:boojoo/Challenge/Challenge_Modify.dart';
import 'package:boojoo/Challenge/Challenge_Delete.dart';
import 'package:boojoo/Challenge/Challenge_List.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'Challenge_group_private.dart';
import 'challenge_group_public.dart';
/////////////////////////////////////////////////////////useless!!!!!!!!!!!!!!!////////////////////////////////////////////////

class MyChallenges extends StatelessWidget {
  final List<challenge_for_list> recommend = [
    challenge_for_list(
        id: 0,
        title: 'نوشیدن آب',
        likenumber: 2023,
        startdate: DateTime.parse('1390-08-02'),
        enddate: null,
        icon: 'assets/1.jpg',
        private_pub: 'pu'),
    challenge_for_list(
        id: 1,
        title: 'یوگا',
        likenumber: 1022,
        startdate: DateTime.parse('1395-11-21'),
        enddate: null,
        icon: 'assets/2.jpg',
        private_pub: 'pu')
  ];

  String FormatDateTime(DateTime time) {
    return '${time.year}/${time.month}/${time.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("چالش های من"),
          titleTextStyle: TextStyle(fontFamily: 'calibri'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => challenge_create_private()));
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: Colors.black45,
                ),
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: ValueKey(recommend[index].id),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {},
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context, builder: (_) => ch_delete());
                      return result;
                    },
                    background: Container(
                      color: Colors.redAccent,
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        child: Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(recommend[index].icon),
                          ),
                          title: Text(
                            recommend[index].title,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          ),
                          subtitle: Text(
                              ' زمان آغاز : ${FormatDateTime(recommend[index].startdate)}'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => challengemodify(
                                      challengeid: recommend[index].title,
                                    )));
                          },
                        ),
                      ],
                    ),
                  );
                },
                itemCount: recommend.length,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 200,
                bottom: 19,
              ),
              child: RaisedButton(
                // color: Colors.amber,
                // disabledColor: Colors.amber,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => TabBarchallengePrivateGroup()));
                },
                child: new Text('مشاهده چالش ها'),
              ),
            )
          ],
        ));
  }
}
