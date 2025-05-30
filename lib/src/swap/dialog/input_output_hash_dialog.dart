import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../l10n.dart';
import '../../stores/settings/settings_store.dart';
import '../../widgets/primary_button.dart';

Future showInputOutputDialog(BuildContext context, String inputHash, String outputHash,
    {void Function(BuildContext context)? onDismiss}) {
  return showDialog<void>(
      builder: (_) => InputOutputDialog(inputHash, outputHash,
          onDismiss: onDismiss!,),
      context: context);
}

class InputOutputDialog extends StatelessWidget {
  InputOutputDialog(this.inputHash, this.outputHash,
      {this.onDismiss});

  final String inputHash;
  final String outputHash;
  final void Function(BuildContext context)? onDismiss;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration:
          BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top:15, bottom: 15, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: settingsStore.isDarkTheme ? Color(0xFF272733) : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text("Input/Output Hash",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                              color: settingsStore.isDarkTheme ? Color(0xFFEBEBEB) : Color(0xFF222222))),
                      Container(
                        decoration: BoxDecoration(
                            color: settingsStore.isDarkTheme ? Color(0xFF383848) : Color(0xFFEDEDED),
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 15),
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Input Hash",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  backgroundColor: Colors.transparent,
                                                  fontSize: 15,
                                                  decoration: TextDecoration.none,
                                                  color: settingsStore.isDarkTheme ? Color(0xFFAFAFBE) : Color(0xFF77778B))),
                                          SvgPicture.asset(
                                            'assets/images/swap/copy.svg',
                                            color: Colors.green,
                                            width: 13,
                                            height: 13,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8, bottom: 15, left: 10, right: 10),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: settingsStore.isDarkTheme ? Color(0xFF47475E) : Colors.white,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Text(inputHash,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 15,
                                              decoration: TextDecoration.none,
                                              color: settingsStore.isDarkTheme ? Color(0xFFFFFFFF) : Color(0xFF222222))),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 15),
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Output Hash",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  backgroundColor: Colors.transparent,
                                                  fontSize: 15,
                                                  decoration: TextDecoration.none,
                                                  color: settingsStore.isDarkTheme ? Color(0xFFAFAFBE) : Color(0xFF77778B))),
                                          SvgPicture.asset(
                                            'assets/images/swap/copy.svg',
                                            color: Colors.green,
                                            width: 13,
                                            height: 13,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8, left: 10, right: 10),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: settingsStore.isDarkTheme ? Color(0xFF47475E) : Colors.white,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Text(outputHash,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 15,
                                              decoration: TextDecoration.none,
                                              color: settingsStore.isDarkTheme ? Color(0xFFFFFFFF) : Color(0xFF222222))),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: PrimaryButton(
                            text: tr(context).ok,
                            color: Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor,
                            borderColor: Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor,
                            onPressed: () {
                              if (onDismiss != null) {
                                onDismiss!(context);
                              }
                            }),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}