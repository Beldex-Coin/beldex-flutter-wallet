import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_info.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_direction.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionRow extends StatelessWidget {
  TransactionRow({
    this.direction,
    this.formattedDate,
    this.formattedAmount,
    this.formattedFiatAmount,
    this.isPending,
    @required this.onTap,
    this.transaction,
    //this.isStake
  });

  final VoidCallback onTap;
  final TransactionDirection direction;
  final String formattedDate;
  final String formattedAmount;
  final String formattedFiatAmount;
  final bool isPending;
  final bool flag = false;

  final TransactionInfo transaction;
  // final bool isStake;

  void _launchUrl(String url) async {
    if (await canLaunch(url)) await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return InkWell(
        // onTap: onTap,
        child: Container(
      margin: EdgeInsets.only(left: 18, right: 18),
      decoration: BoxDecoration(
        //color: Color(0xff24242F),
        color:
            settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED),
      ),
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
                accentColor:
                    settingsStore.isDarkTheme ? Colors.white : Colors.black,
                dividerColor: Colors.transparent,
                textSelectionTheme:
                    TextSelectionThemeData(selectionColor: Colors.green)),
            child: ExpansionTile(
                // initiallyExpanded: true,
                title: Container(
                  child: Column(
                    children: [
                      Row(children: <Widget>[
                        Container(
                            height: 27,
                            width: 27,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: direction == TransactionDirection.incoming
                                ? SvgPicture.asset(
                                    'assets/images/new-images/incoming.svg',
                                    color: direction ==
                                            TransactionDirection.incoming
                                        ? Colors.green
                                        : Colors.red,
                                    //fit:BoxFit.cover
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                      'assets/images/new-images/outgoing_red.svg',
                                    ),
                                  )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(formattedAmount,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffACACAC)
                                                : Color(0xff626262))),
                                    Text(
                                        (direction ==
                                                    TransactionDirection
                                                        .incoming
                                                ? S.of(context).received
                                                : S.of(context).sent) +
                                            (isPending
                                                ? S.of(context).pending
                                                : // isStake ? S.of(context).stake :
                                                ''),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffACACAC)
                                                : Color(0xff626262))),
                                  ]),
                              SizedBox(height: 6),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(formattedDate,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffACACAC)
                                                : Color(0xff626262))),
                                    // Text(formattedFiatAmount,
                                    //     style: const TextStyle(
                                    //         fontSize: 14, color: Palette.blueGrey))
                                  ]),
                            ],
                          ),
                        )),
                        //Icon(Icons.keyboard_arrow_down)
                      ]),
                    ],
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // color: Colors.yellow,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff454555)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        S.of(context).transaction_details_transaction_id,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () {
                                        final url =
                                            'https://explorer.beldex.io/tx/${transaction.id}'; //testnet.beldex.dev/tx/  //explorer.beldex.io
                                        _launchUrl(url);
                                      },
                                      child: Text(
                                        transaction.id,
                                        style: TextStyle(
                                            color: Color(0xffACACAC),
                                        ),
                                      ),
                                    )),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: transaction.id));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.30 /
                                                  3,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.30 /
                                                  3,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.30 /
                                                  3),
                                          elevation: 0, //5,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          content: Text(
                                            S.of(context).copied,
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                          backgroundColor: Color(0xff0BA70F),
                                          duration:
                                              Duration(milliseconds: 1500),
                                        ));
                                      },
                                      child: Container(
                                          //height:20,width:40,
                                          padding: EdgeInsets.only(
                                              left: 20.0,
                                              right: 10,
                                              top: 10,
                                              bottom: 10),
                                          child: Icon(
                                            Icons.copy,
                                            size: 20,
                                            color: Color(0xff0BA70F),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff454555)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900)),
                                Container(
                                    child: Text(
                                        '$formattedDate' //'${transaction.date}'
                                        )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff454555)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Height',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900)),
                                Column(
                                  //crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: Text('${transaction.height}')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff454555)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Amount',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900)),
                                Container(
                                    child: Text(
                                  '$formattedAmount',
                                  style: TextStyle(color: Color(0xff0BA70F)),
                                ))
                              ],
                            ),
                          ),
                        ),
                        settingsStore.shouldSaveRecipientAddress &&
                                transaction.recipientAddress != null
                            ? Container(
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff454555)
                                          : Color(0xffDADADA)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 10),
                                          child: Text('Recipient Address',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900)),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            transaction.recipientAddress,
                                            style: TextStyle(
                                                color: Color(0xffACACAC),
                                            ),
                                          )),
                                          InkWell(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: transaction
                                                      .recipientAddress));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.30 /
                                                            3,
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.30 /
                                                        3,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.30 /
                                                            3),
                                                elevation: 0, //5,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                content: Text(
                                                  S.of(context).copied,
                                                  style: TextStyle(
                                                      color: Color(0xffffffff),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.center,
                                                ),
                                                backgroundColor:
                                                    Color(0xff0BA70F),
                                                duration: Duration(
                                                    milliseconds: 1500),
                                              ));
                                            },
                                            child: Container(
                                                //height:20,width:40,
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 10,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Icon(
                                                  Icons.copy,
                                                  size: 20,
                                                  color: Color(0xff0BA70F),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Divider(
              height: 2,
            ),
          )
        ],
      ),
    ));
  }
}
