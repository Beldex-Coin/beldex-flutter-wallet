import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/src/util/constants.dart' as constants;
import 'package:provider/provider.dart';

class NewNavListTrailing extends StatelessWidget {
  NewNavListTrailing({this.text, this.leading, this.onTap, this.trailing,this.size,required this.isDisable});

  final String? text;
  final Widget? leading;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final double? size;
  final bool isDisable;
  @override
  Widget build(BuildContext context) {
     final settingsStore = Provider.of<SettingsStore>(context);
    return Card(
      margin: EdgeInsets.only(left: constants.leftPx,right: constants.rightPx,top: 20),
      elevation:0,
      color: settingsStore.isDarkTheme ? Color(0xff171720): Color(0xffffffff),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        child: Theme(
          data: ThemeData(
            splashColor:Colors.transparent,
            highlightColor:Colors.transparent,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
            leading: leading,
            title: Text(text!,
                style: TextStyle(
                    fontSize: size==15?15.0:16.0,
                    color: isDisable?Colors.grey:Theme.of(context).primaryTextTheme.headline6?.color)),
            trailing: trailing,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}