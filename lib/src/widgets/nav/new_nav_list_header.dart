import 'package:flutter/material.dart';

import '../../../palette.dart';

class NewNavListHeader extends StatelessWidget {
  NewNavListHeader({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.only(left: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18.0, color: Theme.of(context).primaryTextTheme.caption.color,fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}