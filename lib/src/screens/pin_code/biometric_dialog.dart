import 'dart:ui';

import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../l10n.dart';

Future showBiometricDialog(
    BuildContext context,
    String title,) {
  return showDialog<void>(
      builder: (_) => BiometricDialog(title: title, context: context
      ),
      context: context);
}

class BiometricDialog extends StatelessWidget {
  BiometricDialog({Key? key, required this.title, required this.context
  }) : super(key: key);

  final String title;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return BeldexBioDialog(
      title: title,onDismiss: (context){},
    );
  }
}

class BeldexBioDialog extends StatefulWidget {
  BeldexBioDialog({
    this.body,
    required this.onDismiss,
    this.title,
    this.context
  });

  final void Function(BuildContext context) onDismiss;
  final String? body;
  final String? title;
  final BuildContext? context;
  @override
  BeldexBioDialogState createState() => BeldexBioDialogState();
}

class BeldexBioDialogState extends State<BeldexBioDialog> {
  void _onDismiss(BuildContext context) {
    if (widget.onDismiss == null) {
      Navigator.of(context).pop();
    } else {
      widget.onDismiss(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return GestureDetector(
      onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            // margin: EdgeInsets.all(10),
            // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors
                          .transparent, //Theme.of(context).backgroundColor,
                      //borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                        height:
                        MediaQuery.of(context).size.height * 1 / 3,
                        margin: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        decoration: BoxDecoration(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff272733)
                              : Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                        EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, bottom: 8.0),
                                  child: Text(
                                    tr(context).unlockBeldexWallet,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.07 /
                                            3,
                                        fontWeight: FontWeight.w600,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffEBEBEB)
                                            : Color(0xff16161D)),
                                  ),
                                ),
                              ],
                            ),
                            Container(

                              // color: Colors.yellow,
                                child: Text(
                                  tr(context)
                                      .confirmYourScreenLockPinpatternAndPassword,
                                  style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.05 /
                                          3,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff909090)
                                          : Color(0xff303030)),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.10 /
                                        3),
                                child: SvgPicture.asset(
                                  'assets/images/new-images/fingerprint.svg',
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffffffff)
                                      : Color(0xff16161D),
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.25 /
                                      3,
                                )),
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  tr(context).touchTheFingerprintSensor,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff909090)),
                                )),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5,
                                        bottom: 8.0,
                                        top: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.09 /
                                            3),
                                    child: Text(
                                      tr(context).usePattern,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0BA70F)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        ),
      ),
    );

  }
}