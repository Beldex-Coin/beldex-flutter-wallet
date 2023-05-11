

import 'dart:ui';

import 'package:flutter/material.dart';

Future showBiometricDialog(BuildContext context,
  String title, 
//String body,
//     {String buttonText,
//     void Function(BuildContext context) onPressed,
//     void Function(BuildContext context) onDismiss}
    ) {
  return showDialog<void>(
      builder: (_) => BiometricDialog(title:title),
      context: context);
}


class BiometricDialog extends StatelessWidget {
   BiometricDialog({ Key key, this.title }) : super(key: key);

final String title;


  @override
  Widget build(BuildContext context) {
    return BeldexBioDialog(
       title: title,
    );
  }
}

class BeldexBioDialog extends StatelessWidget {
  BeldexBioDialog({this.body, this.onDismiss, this.title,});

  final void Function(BuildContext context) onDismiss;
  final String body;
  final String title;
  void _onDismiss(BuildContext context) {
    if (onDismiss == null) {
      Navigator.of(context).pop();
    } else {
      onDismiss(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height:MediaQuery.of(context).size.height*1/3,
                      margin:EdgeInsets.only(left:10,right:10,bottom:10,top:10),
                      decoration: BoxDecoration(
                        color:Color(0xff272733),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Column(
                        children: [
                          Text(title )
                        ],
                      )
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
