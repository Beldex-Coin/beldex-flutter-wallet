import 'dart:ui';

import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';

Future showSimpleConfirmDialog(
    BuildContext context, String title, String body, String fee, String address,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => ConfirmSending(title, body, fee, address,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}

Future showDialogTransactionSuccessfully(BuildContext context,String title,
    {void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => SendTransactionSuccessfully(title: title,
          onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}

Future showBnsConfirmationDialogBox(
    BuildContext context,
    String bnsName,
    String mappingYearsId,
    String mappingYears,
    String owner,
    String backUpOwner,
    String walletAddress,
    String bchatId,
    String belnetId,
    WalletStore walletStore,
    {void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => BnsConfirmationDialogBox(bnsName, mappingYearsId,
          mappingYears, owner, backUpOwner, walletAddress, bchatId, belnetId, walletStore,
          onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}

Future showDetailsAfterSendSuccessfully(
    BuildContext context, String title, String body, String fee, String address,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => SendDetailsAfterTransaction(title, body, fee, address,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}

class SendDetailsAfterTransaction extends StatelessWidget {
  const SendDetailsAfterTransaction(
    this.title,
    this.body,
    this.fee,
    this.address, {
    this.buttonText,
    this.onPressed,
    this.onDismiss,
  });

  final String title;
  final String body;
  final String fee;
  final String address;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Colors.white, //Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1.4 / 3,
                    padding: EdgeInsets.only(top: 15.0, left: 20, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff383848)
                                    : Color(0xffEDEDED)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                    child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'body',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                                Container(
                                  width: 70,
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B116),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          'assets/images/new-images/beldex.svg')),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10),
                            height:
                                MediaQuery.of(context).size.height * 0.60 / 3,
                            decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff383848)
                                    : Color(0xffEDEDED),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Address'),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff47475E)
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(address)),
                                Text('Fee: fee'),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height *
                                  0.10 /
                                  3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 45,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff383848)
                                        : Color(0xffEDEDED),
                                    borderRadius: BorderRadius.circular(8)),
                                child: GestureDetector(
                                    onTap: () {
                                      if (onDismiss != null) {
                                        onDismiss(context);
                                      }
                                    },
                                    child: Center(
                                        child: Text(S.of(context).cancel,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)))),
                              ),
                              SizedBox(width: 20),
                              Container(
                                height: 45,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xff0BA70F),
                                    borderRadius: BorderRadius.circular(8)),
                                child: GestureDetector(
                                    onTap: () {
                                      if (onPressed != null) {
                                        onPressed(context);
                                      }
                                    },
                                    child: Center(
                                        child: Text(
                                      S.of(context).ok,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionSendDetails extends StatelessWidget {
  const TransactionSendDetails(
    this.title,
    this.body,
    this.fee,
    this.address, {
    this.buttonText,
    this.onPressed,
    this.onDismiss,
  });

  final String title;
  final String body;
  final String fee;
  final String address;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Colors.white, //Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1.4 / 3,
                    padding: EdgeInsets.only(top: 15.0, left: 20, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                            height: 50,
                            //padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff383848)
                                    : Color(0xffEDEDED)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    S.of(context).amount,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                    child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    body,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                                Container(
                                  width: 70,
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B116),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          'assets/images/new-images/beldex.svg')),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10),
                            height:
                                MediaQuery.of(context).size.height * 0.60 / 3,
                            decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff383848)
                                    : Color(0xffEDEDED),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(S.of(context).widgets_address),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff47475E)
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(address)),
                                Text('Fee: $fee'),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height *
                                  0.10 /
                                  3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 45,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff383848)
                                        : Color(0xffEDEDED),
                                    borderRadius: BorderRadius.circular(8)),
                                child: GestureDetector(
                                    onTap: () {
                                      if (onDismiss != null) {
                                        onDismiss(context);
                                      }
                                    },
                                    child: Center(
                                        child: Text(S.of(context).cancel,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)))),
                              ),
                              SizedBox(width: 20),
                              Container(
                                height: 45,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xff0BA70F),
                                    borderRadius: BorderRadius.circular(8)),
                                child: GestureDetector(
                                    onTap: () {
                                      if (onPressed != null) {
                                        onPressed(context);
                                      }
                                    },
                                    child: Center(
                                        child: Text(
                                      S.of(context).ok,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class SendTransactionSuccessfully extends StatefulWidget {
  const SendTransactionSuccessfully({
    this.title,
    this.onPressed,
    this.onDismiss,
  });

  final String title;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  _SendTransactionSuccessfullyState createState() =>
      _SendTransactionSuccessfullyState();
}

class _SendTransactionSuccessfullyState
    extends State<SendTransactionSuccessfully> {
  @override
  void initState() {
    callFuture();
    super.initState();
  }

  void callFuture() async {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context)..pop()..pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Colors.white, //Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.80 / 3,
                    padding: EdgeInsets.only(
                        //top: 15.0,
                        left: 10,
                        right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     if (widget.onDismiss != null) {
                            //       widget.onDismiss(context);
                            //     }
                            //   },
                            //   child:
                            Container(
                              child: Icon(Icons.close,
                                  size: 20, color: Colors.transparent),
                            ),
                            // )
                          ],
                        ),
                        Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/new-images/send_1.gif',
                              errorBuilder: (context, obj, stackTrace) {
                                return Image.asset(
                                    'assets/images/new-images/Sent.png');
                              },
                            )),
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('MMM d, yyyy, hh:mm:ss a');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}

class ConfirmSending extends StatelessWidget {
  const ConfirmSending(
    this.title,
    this.body,
    this.fee,
    this.address, {
    this.buttonText,
    this.onPressed,
    this.onDismiss,
  });

  final String title;
  final String body;
  final String fee;
  final String address;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Colors.white, //Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 1.4 / 3,
                    padding: EdgeInsets.only(
                        top: 15.0, left: 20, right: 20, bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800)),
                        ),
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff383848)
                                    : Color(0xffEDEDED)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    S.of(context).transaction_details_amount,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                    child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    body,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                                Container(
                                  width: 70,
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Color(0xff00B116),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          'assets/images/new-images/beldex.svg')),
                                )
                              ],
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff383848)
                                    : Color(0xffEDEDED),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('${S.of(context).restore_address}:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff47475E)
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(address)),
                                Text(
                                  'Fee: $fee',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height *
                                  0.10 /
                                  3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (onDismiss != null) {
                                        onDismiss(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: settingsStore.isDarkTheme
                                          ? Color(0xff383848)
                                          : Color(0xffEDEDED),
                                      padding: EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(S.of(context).cancel,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: settingsStore.isDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (onPressed != null) {
                                        onPressed(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff0BA70F),
                                      padding: EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      S.of(context).ok,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ),
                              // Container(
                              //   height: 45,
                              //   width: 120,
                              //   decoration: BoxDecoration(
                              //       color: settingsStore.isDarkTheme
                              //           ? Color(0xff383848)
                              //           : Color(0xffEDEDED),
                              //       borderRadius: BorderRadius.circular(8)),
                              //   child: GestureDetector(
                              //       onTap: () {
                              //         if (onDismiss != null) {
                              //           onDismiss(context);
                              //         }
                              //       },
                              //       child: Center(
                              //           child: Text(S.of(context).cancel,
                              //               style: TextStyle(
                              //                   fontSize: 15,
                              //                   fontWeight:
                              //                       FontWeight.bold)))),
                              // ),
                              // SizedBox(width: 20),
                              // Container(
                              //   height: 45,
                              //   width: 120,
                              //   decoration: BoxDecoration(
                              //       color: Color(0xff0BA70F),
                              //       borderRadius: BorderRadius.circular(8)),
                              //   child: GestureDetector(
                              //       onTap: () {
                              //         if (onPressed != null) {
                              //           onPressed(context);
                              //         }
                              //       },
                              //       child: Center(
                              //           child: Text(
                              //         S.of(context).ok,
                              //         style: TextStyle(
                              //             fontSize: 15,
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.white),
                              //       ))),
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class BnsConfirmationDialogBox extends StatelessWidget {
  const BnsConfirmationDialogBox(
    this.bnsName,
    this.mappingYearsId,
    this.mappingYears,
    this.owner,
    this.backUpOwner,
    this.walletAddress,
    this.bchatId,
    this.belnetId,
    this.walletStore, {
    this.onPressed,
    this.onDismiss,
  });

  final String bnsName;
  final String mappingYearsId;
  final String mappingYears;
  final String owner;
  final String backUpOwner;
  final String walletAddress;
  final String bchatId;
  final String belnetId;
  final WalletStore walletStore;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      top: 15.0, left: 20, right: 20, bottom: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text('Confirm Purchase',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff383848)
                                  : Color(0xffEDEDED)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name ',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Flexible(
                                    child: Text(
                                      bnsName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff0ba70f),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff444463)
                                    : Color(0xffc9c9c9),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Year',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    mappingYears,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff222222),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff444463)
                                    : Color(0xffc9c9c9),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Owner',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    owner.isNotEmpty ? owner : walletStore.subaddress.address,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff7D7D9c),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff444463)
                                    : Color(0xffc9c9c9),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Backup Owner',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    backUpOwner.isNotEmpty
                                        ? backUpOwner
                                        : 'None',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff7D7D9c),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff383848)
                                  : Color(0xffEDEDED)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    walletAddress.isNotEmpty
                                        ? walletAddress
                                        : 'None',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff7D7D9c),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff444463)
                                    : Color(0xffc9c9c9),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BChat ID',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    bchatId.isNotEmpty ? bchatId : 'None',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff7D7D9c),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff444463)
                                    : Color(0xffc9c9c9),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Belnet ID',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    belnetId.isNotEmpty ? belnetId : 'None',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff7D7D9c),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.10 / 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (onDismiss != null) {
                                      onDismiss(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: settingsStore.isDarkTheme
                                        ? Color(0xff383848)
                                        : Color(0xffEDEDED),
                                    padding: EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(S.of(context).cancel,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: settingsStore.isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (onPressed != null) {
                                      onPressed(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff0BA70F),
                                    padding: EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    S.of(context).ok,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
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
