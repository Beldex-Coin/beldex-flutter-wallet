import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
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
  Widget body(BuildContext context) => DisclaimerPageBody();
}

class DisclaimerPageBody extends StatefulWidget {
  @override
  DisclaimerBodyState createState() => DisclaimerBodyState();
}

class DisclaimerBodyState extends State<DisclaimerPageBody> {
  String _fileText = '';

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) await launch(url);
  }

  Future getFileLines() async {
    _fileText = await rootBundle.loadString('assets/text/terms_and_cond.txt');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFileLines();
  }

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: <Widget>[Expanded(child: Html(data: _fileText))],
          ),
          SizedBox(
            height: 16.0,
          )
        ],
      ),
    );
  }
}
