import 'package:flutter/material.dart';
import 'package:beldex_wallet/palette.dart';

class StandartListRow extends StatelessWidget {
  StandartListRow({this.title, this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryTextTheme.caption.color),
                textAlign: TextAlign.left),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(value,
                  style: TextStyle(fontSize: 14, color: Theme.of(context).primaryTextTheme.caption.color)),
            )
          ]),
    );
  }
}
