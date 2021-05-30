import 'package:flutter/material.dart';

class ch_delete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Are you sure you want to delete this challenge?'),
      actions: <Widget> [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes')
        ),

        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No')
        )

      ],
    );
  }
}
