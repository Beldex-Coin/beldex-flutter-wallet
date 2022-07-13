import 'package:flutter/material.dart';
import 'package:beldex_wallet/palette.dart';

class NavListHeader extends StatelessWidget {
  NavListHeader({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 28.0),
        Container(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 15.0, color: Theme.of(context).primaryTextTheme.caption.color),
              )
            ],
          ),
        ),
        SizedBox(height: 14.0),
      ],
    );
  }
}
