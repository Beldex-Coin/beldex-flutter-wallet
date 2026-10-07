import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import '../../../l10n.dart';
import 'package:flutter_html/flutter_html.dart';

class DisclaimerPage extends BasePage {
  @override
  bool get isModalBackButton => false;

  @override
  String getTitle(AppLocalizations t) => t.settings_terms_and_conditions;

  @override
  Widget trailing(BuildContext context) {
    return Icon(Icons.settings, color: Colors.transparent);
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
  }

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15,top: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  tr(context).legalDisclaimer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          FutureBuilder(
              future: rootBundle.loadString(getTernsAndConditionsPath(context)),
              builder: (context, asyncSnapshot) {
                if(!asyncSnapshot.hasData){
                  return SizedBox.shrink();
                }
                return Row(
                  children: <Widget>[Expanded(child: Html(data: asyncSnapshot.data.toString()))],
                );
              }
          ),
          SizedBox(
            height: 16.0,
          )
        ],
      ),
    );
  }

  String getTernsAndConditionsPath(BuildContext context) {
    switch (tr(context).localeName) {
      case 'ar':
        return 'assets/text/terms_and_cond_ar.txt';
      case 'de':
        return 'assets/text/terms_and_cond_de.txt';
      case 'en':
        return 'assets/text/terms_and_cond_en.txt';
      case 'es':
        return 'assets/text/terms_and_cond_es.txt';
      case 'fr':
        return 'assets/text/terms_and_cond_fr.txt';
      case 'jp':
        return 'assets/text/terms_and_cond_jp.txt';
      case 'ko':
        return 'assets/text/terms_and_cond_ko.txt';
      case 'pt':
        return 'assets/text/terms_and_cond_pt.txt';
      case 'tr':
        return 'assets/text/terms_and_cond_tr.txt';
      case 'vi':
        return 'assets/text/terms_and_cond_vi.txt';
      case 'zh':
        return 'assets/text/terms_and_cond_zh.txt';
      default:
        return 'assets/text/terms_and_cond_en.txt';
    }
  }
}
