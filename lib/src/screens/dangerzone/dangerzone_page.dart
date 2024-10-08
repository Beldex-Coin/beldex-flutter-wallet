import 'dart:io';

import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:flutter_svg/svg.dart';

class DangerZonePage extends BasePage {
  DangerZonePage({required this.nextPage, required this.pageTitle});

  final String nextPage;
  final String pageTitle;

  @override
  String get title => pageTitle;

  @override
  Widget trailing(BuildContext context) {
    return Icon(Icons.settings, color: Colors.transparent);
  }

  @override
  Widget body(BuildContext context) {
    final _baseWidth = 411.43;
    final _screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = _screenWidth < _baseWidth ? 0.76 : 1.0;
    final appStore =
        Platform.isAndroid ? tr(context).playStore : tr(context).appstore;
    final item = nextPage == Routes.seed
        ? tr(context).seed_title
        : tr(context).keys_title;

    return Column(children: <Widget>[
      Expanded(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.90 / 3,
                height: MediaQuery.of(context).size.height * 0.50 / 3,
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset('assets/images/new-images/important.svg'),
                  ],
                )),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                tr(context).important,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryTextTheme.bodySmall?.color,
                ),
                textScaleFactor: textScaleFactor,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  tr(context).never_give_your(item),
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Theme.of(context).primaryTextTheme.bodySmall?.color,
                  ),
                  textScaleFactor: textScaleFactor,
                  textAlign: TextAlign.center,
                )),
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  tr(context).neverInputYourBeldexWalletItemIntoAnySoftwareOr(
                      item, appStore),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryTextTheme.bodySmall?.color,
                  ),
                  textScaleFactor: textScaleFactor,
                  textAlign: TextAlign.center,
                )),
            Container(
              child:Text('Are you Sure you want to access your $item?',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryTextTheme.bodySmall?.color,
                ),
              )
            )
          ]),
        ),
      ),
      Container(
        margin: EdgeInsets.all(15),
        child: PrimaryButton(
            onPressed: () => Navigator.popAndPushNamed(context, nextPage),
            text: tr(context).yes_im_sure,
            color: Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor,
            borderColor:
                Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor),
      ),
    ]);
  }
}
