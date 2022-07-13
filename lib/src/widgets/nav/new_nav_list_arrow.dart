import 'package:flutter/material.dart';

import 'new_nav_list_trailing.dart';

class NewNavListArrow extends StatelessWidget {
  NewNavListArrow({this.text, this.leading, this.onTap,this.size,this.balanceVisibility,this.decimalVisibility,this.currencyVisibility,this.feePriorityVisibility});

  final String text;
  final Widget leading;
  final GestureTapCallback onTap;
  final double size;
  final bool balanceVisibility;
  final bool decimalVisibility;
  final bool currencyVisibility;
  final bool feePriorityVisibility;
  @override
  Widget build(BuildContext context) {
    return NewNavListTrailing(
      balanceVisibility: balanceVisibility,
      decimalVisibility: decimalVisibility,
        currencyVisibility: currencyVisibility,
        feePriorityVisibility: feePriorityVisibility,
        leading: leading,
        text: text,
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).primaryTextTheme.headline6.color,
            size: 20),
        onTap: onTap,
    size: size,);
  }
}