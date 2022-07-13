import 'package:flutter/material.dart';
import 'package:beldex_wallet/src/util/constants.dart' as constants;

class NewNavListTrailing extends StatelessWidget {
  NewNavListTrailing({this.text, this.leading, this.onTap, this.trailing,this.size,this.balanceVisibility,this.decimalVisibility,this.currencyVisibility,this.feePriorityVisibility});

  final String text;
  final Widget leading;
  final Widget trailing;
  final GestureTapCallback onTap;
  final double size;
  final bool balanceVisibility;
  final bool decimalVisibility;
  final bool currencyVisibility;
  final bool feePriorityVisibility;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: constants.leftPx,right: constants.rightPx,top: 20),
      elevation: 2,
      color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        /*margin: EdgeInsets.only(left: 40,right: 40,top: 20),
        elevation: 2,
        shadowColor: Colors.white,
        color: Color.fromARGB(255, 40, 42, 51),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),*/
       /* margin: EdgeInsets.only(left: 40,right: 40,top: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 40, 42, 51),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 42, 44, 53),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
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
            leading: leading,
            title: Text(text,
                style: TextStyle(
                    fontSize: size==15?15.0:16.0,
                    color: Theme.of(context).primaryTextTheme.headline6.color)),
            trailing: trailing,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}