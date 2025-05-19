import 'package:flutter/material.dart';

class SettingsTextListRow extends StatelessWidget {
  SettingsTextListRow({required this.onTaped, this.title, this.widget});

  final VoidCallback? onTaped;
  final String? title;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.grey,
        highlightColor:  Colors.grey,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
        trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,color: Color(0xff3F3F4D),),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                title!,
                style: TextStyle(
                    fontSize:MediaQuery.of(context).size.height*0.06/3, // 14.0,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryTextTheme.titleLarge?.color),
              ),
            ),
            Flexible(child: widget!)
          ],
        ),
        onTap: onTaped,
      ),
    );
  }
}
