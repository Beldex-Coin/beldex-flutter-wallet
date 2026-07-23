import 'package:beldex_wallet/src/util/screen_sizer.dart';
import 'package:flutter/material.dart';

import '../../../palette.dart';

class NewNavListHeader extends StatelessWidget {
  NewNavListHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(backgroundColor: Colors.transparent,fontSize: 20.0,
                color:Color(0xff737385),
                fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ],
    );
  }
}