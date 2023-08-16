import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:flutter_svg/svg.dart';

class DangerzonePage extends BasePage {
  final String nextPage;
  final String pageTitle;
  DangerzonePage({this.nextPage,this.pageTitle});

  @override
  String get title => pageTitle;

  @override
Widget trailing(BuildContext context){
  return Icon(Icons.settings,color:Colors.transparent);
}


  @override
  Widget body(BuildContext context) {
    final _baseWidth = 411.43;
    final _screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = _screenWidth < _baseWidth ? 0.76 : 1.0;
    final appStore = Platform.isAndroid ? 'Play Store' : 'AppStore';
    final item = nextPage == Routes.dangerzoneSeed
        ? S.of(context).seed_title
        : S.of(context).keys_title;

    return Column(children: <Widget>[
      Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom:10),
                child:Container(
                  width: MediaQuery.of(context).size.width*0.90/3,
                  height:MediaQuery.of(context).size.height*0.50/3,
                 // color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset('assets/images/new-images/important.svg'),
                    ],
                  ))
                // child: Icon(Icons.warning_amber_sharp,
                //     size: 125, color: Colors.yellow),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  //S.of(context).dangerzone,
                  S.of(context).important,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryTextTheme.caption.color,
                  ),
                  textScaleFactor: textScaleFactor,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    S.of(context).never_give_your(item),
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Theme.of(context).primaryTextTheme.caption.color,
                    ),
                    textScaleFactor: textScaleFactor,
                    textAlign: TextAlign.center,
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    S.of(context).important_warning(
                          item, appStore
                        ),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).primaryTextTheme.caption.color,
                    ),
                    textScaleFactor: textScaleFactor,
                    textAlign: TextAlign.center,
                  ))
            ]),
      ),
      GestureDetector(
        onTap: (){
           Navigator.popAndPushNamed(context, nextPage);
        },
        child: Container(
          height: MediaQuery.of(context).size.height*0.23/3,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(  
            color:Color(0xff0BA70F),
            borderRadius: BorderRadius.circular(10)
          ),
          child:Center(child: Text(S.of(context).yes_im_sure,style: TextStyle(fontWeight:FontWeight.bold,
          fontSize:19,
          color: Colors.white
          ),),) 
          
          // PrimaryButton(
          //     onPressed: () {
          //       Navigator.popAndPushNamed(context, nextPage);
          //     },
          //     text: S.of(context).yes_im_sure,
          //     color: Theme.of(context).primaryTextTheme.button.backgroundColor,
              
          //     borderColor:
          //     Theme.of(context).primaryTextTheme.button.backgroundColor),
        ),
      )
    ]);
  }
}
