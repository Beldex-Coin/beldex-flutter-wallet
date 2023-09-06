import 'package:flutter/material.dart';
import 'package:beldex_wallet/palette.dart';

class SettingsLinktListRow extends StatelessWidget {
  SettingsLinktListRow(
      {@required this.onTaped, this.title, this.link, this.image,this.balanceVisibility,this.decimalVisibility,this.currencyVisibility,this.feePriorityVisibility});

  final VoidCallback onTaped;
  final String title;
  final String link;
  final Image image;
  final bool balanceVisibility;
  final bool decimalVisibility;
  final bool currencyVisibility;
  final bool feePriorityVisibility;
  @override
  Widget build(BuildContext context) {
    return Container(
     /* margin: EdgeInsets.only(left: 40,right: 40,top: 20),
      elevation: 2,
      color: Color.fromARGB(255, 40, 42, 51),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),*/
      //color: Theme.of(context).accentTextTheme.headline5.backgroundColor,
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
              //image ?? Offstage(),
              Container(
                //padding: image != null ? EdgeInsets.only(left: 10) : null,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryTextTheme.headline6.color),
                ),
              )
            ],
          ),
          /*trailing: Text(
            link,
            style: TextStyle(fontSize: 14.0, color: BeldexPalette.teal),
          ),*/
          onTap: onTaped,
        ),
      ),
    );
  }
}
