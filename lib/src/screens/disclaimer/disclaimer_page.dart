import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:flutter_html/flutter_html.dart';
class DisclaimerPage extends BasePage {
  DisclaimerPage({this.isReadOnly = false});

  final bool isReadOnly;

  @override
  bool get isModalBackButton => false;

  @override
  String get title => S.current.settings_terms_and_conditions;

  // @override
  // Widget leading(BuildContext context) {
  //   return Container(
  //       padding: const EdgeInsets.only(top: 12.0, left: 10),
  //       decoration: BoxDecoration(
  //         //borderRadius: BorderRadius.circular(10),
  //         //color: Colors.black,
  //       ),
  //       child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  // }



@override
Widget trailing(BuildContext context){
  return Icon(Icons.settings,color:Colors.transparent);
}



  @override
  Widget body(BuildContext context) => DisclaimerPageBody(isReadOnly: true);
}

class DisclaimerPageBody extends StatefulWidget {
  DisclaimerPageBody({this.isReadOnly = true});

  final bool isReadOnly;

  @override
  DisclaimerBodyState createState() => DisclaimerBodyState(false);
}

class DisclaimerBodyState extends State<DisclaimerPageBody> {
  DisclaimerBodyState(this._isAccepted);

  final bool _isAccepted;
  bool _checked = false;
  String _fileText = '';

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) await launch(url);
  }

  Future getFileLines() async {
   // _fileText = await rootBundle.loadString('assets/text/Terms_of_Use.txt');
    _fileText = await rootBundle.loadString('assets/text/terms_and_cond.txt');
    setState(() {});
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              S.of(context).settings_terms_and_conditions,
              textAlign: TextAlign.center,
            ),
            content: Text(
              S.of(context).byUsingThisAppYouAgreeToTheTermsOf,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).ok)),
            ],
          );
        });
  }

  void _afterLayout(Duration _) => _showAlertDialog(context);

  @override
  void initState() {
    super.initState();
    getFileLines();
    if (_isAccepted) WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0),
        Expanded(
            child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: Column(
                children: <Widget>[
                 /* !_isAccepted
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                S.of(context).settings_terms_and_conditions,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      : Offstage(),
                  !_isAccepted
                      ? SizedBox(
                          height: 20.0,
                        )
                      : Offstage(),*/
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Legal Disclaimer',
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
                    children: <Widget>[
                      Expanded(
                          child: Html(
                            data:_fileText
                          )
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 12.0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).backgroundColor.withOpacity(0.0),
                            Theme.of(context).backgroundColor,
                          ],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
        if (!widget.isReadOnly) ...[
          !_isAccepted
              ? Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 25.0, top: 10.0, right: 25.0, bottom: 10.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _checked = !_checked;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 25.0,
                                  width: 25.0,
                                  margin: EdgeInsets.only(
                                    right: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Palette.lightGrey, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      color: Theme.of(context).backgroundColor),
                                  child: _checked
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.blue,
                                          size: 20.0,
                                        )
                                      : null,
                                ),
                                Text(
                                  S.of(context).iAgreeToTermsOfUse,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                )
              : Offstage(),
          !_isAccepted
              ? Container(
                  padding:
                      EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                  child: PrimaryButton(
                    onPressed: _checked ? () {} : null,
                    text: S.of(context).accept,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .backgroundColor,
                    borderColor: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .decorationColor,
                  ),
                )
              : Offstage(),
          _isAccepted
              ? SizedBox(
                  height: 20.0,
                )
              : Offstage()
        ],
      ],
    );
  }
}
