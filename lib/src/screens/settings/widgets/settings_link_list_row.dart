import 'package:flutter/material.dart';

class SettingsLinkListRow extends StatelessWidget {
  SettingsLinkListRow(
      {this.onTaped, required this.title, this.link, this.image,this.balanceVisibility,this.decimalVisibility,this.currencyVisibility,this.feePriorityVisibility});

  final VoidCallback? onTaped;
  final String title;
  final String? link;
  final Image? image;
  final bool? balanceVisibility;
  final bool? decimalVisibility;
  final bool? currencyVisibility;
  final bool? feePriorityVisibility;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: ThemeData(
          splashColor: balanceVisibility == false &&
              decimalVisibility == false &&
              currencyVisibility == false &&
              feePriorityVisibility == false ?Colors.grey:Colors.transparent,
          highlightColor:  balanceVisibility == false &&
              decimalVisibility == false &&
              currencyVisibility == false &&
              feePriorityVisibility == false ?Colors.grey:Colors.transparent,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryTextTheme.titleLarge?.color),
                ),
              )
            ],
          ),
          onTap: onTaped,
        ),
      ),
    );
  }
}
