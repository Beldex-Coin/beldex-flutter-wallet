import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
void displaySnackBar(BuildContext context, String text){
  final settingsStore = Provider.of<SettingsStore>(context);
//final _height = MediaQuery.of(context).size.height*0.30/3;
//  Scaffold.of(context).showSnackBar(SnackBar(
//                           content: Text(
//                            text,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           backgroundColor: Color(0xff0BA70F),
//                           duration: Duration(seconds: 1),
//                         ));

Toast.show(
      text,
      context,
      duration: Toast.LENGTH_SHORT, // Toast duration (short or long)
      gravity: Toast.BOTTOM,       // Toast gravity (top, center, or bottom)
      textColor:settingsStore.isDarkTheme ? Colors.black : Colors.white, // Text color
                                backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900, // Background color
    );



}