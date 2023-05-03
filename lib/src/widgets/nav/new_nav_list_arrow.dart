import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final settingsStore = Provider.of<SettingsStore>(context);
    return NewNavListTrailing(
      balanceVisibility: balanceVisibility,
      decimalVisibility: decimalVisibility,
        currencyVisibility: currencyVisibility,
        feePriorityVisibility: feePriorityVisibility,
        leading: Container(
           height:43.0,width:43.0,
            padding: EdgeInsets.all(11.0),
             decoration: BoxDecoration(
                    color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(6.0)
                  ),
           child: leading),
        text: text,
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            color: settingsStore.isDarkTheme ? Color(0xff3F3F4D): Color(0xff3F3F4D), // Theme.of(context).primaryTextTheme.headline6.color,
            size: 20),
        onTap: onTap,
    size: size,);
  }
}