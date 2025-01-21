import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_info.dart';
import 'package:flutter/material.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_direction.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class TransactionRow extends StatelessWidget {
  TransactionRow({
    required this.direction,
    required this.formattedDate,
    required this.formattedAmount,
    required this.formattedFiatAmount,
    required this.isPending,
    required this.onTap,
    required this.transaction,
    required this.isBns,
    //this.isStake
    required this.paymentId
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
  final bool isBns;
  final String paymentId;

  static const methodChannelPlatform = MethodChannel("io.beldex.wallet/beldex_wallet_channel");

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    ToastContext().init(context);
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
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: settingsStore.isDarkTheme ? Colors.white : Colors.black, // Your accent color
                ),
                dividerColor: Colors.transparent,
                textSelectionTheme:
                    TextSelectionThemeData(selectionColor: Colors.green)),
            child: ExpansionTile(
                iconColor: settingsStore.isDarkTheme ? Colors.white : Colors.black,
                collapsedIconColor: settingsStore.isDarkTheme ? Colors.white : Colors.black,
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
                                : isBns==true ? SvgPicture.asset(
                              'assets/images/new-images/ic_bns_dark.svg',
                              color: Color(0xffAFAFBE),
                              //fit:BoxFit.cover
                            ) : Padding(
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
                                                ? tr(context).received
                                                : tr(context).sent) +
                                            (isPending
                                                ? tr(context).pending
                                                : // isStake ? tr(context).stake :
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
                                        tr(context)
                                            .transaction_details_transaction_id,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            final url = 'https://explorer.beldex.io/tx/${transaction.id}'; //testnet.beldex.dev/tx/  //explorer.beldex.io
                                            await methodChannelPlatform.invokeMethod("action_view",<String, dynamic>{
                                              'url': url,
                                            });
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
                                        Toast.show(
                                          tr(context).copied,
                                          duration: Toast
                                              .lengthShort, // Toast duration (short or long)
                                          gravity: Toast
                                          .bottom, // Toast gravity (top, center, or bottom)
                                          textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white), // Text color
                                backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,// Background color
                                        );
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
                        Visibility(
                          visible: paymentId != '0000000000000000',
                          child: Container(
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
                                      Text('Payment ID',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            paymentId,
                                            style: TextStyle(
                                              color: Color(0xffACACAC),
                                            ),
                                          )),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                              text: paymentId));
                                          Toast.show(
                                            tr(context).copied,
                                            duration: Toast
                                                .lengthShort, // Toast duration (short or long)
                                            gravity: Toast
                                                .bottom, // Toast gravity (top, center, or bottom)
                                            textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white), // Text color
                                            backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,// Background color
                                          );
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 20.0,
                                                right: 10,
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
                        ),
                        Visibility(
                          visible: paymentId != '0000000000000000',
                          child: SizedBox(height: 10)
                        ),
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
                                          child: Text(
                                              tr(context)
                                                  .transaction_details_recipient_address,
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
                                            transaction.recipientAddress!,
                                            style: TextStyle(
                                              color: Color(0xffACACAC),
                                            ),
                                          )),
                                          InkWell(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: transaction
                                                      .recipientAddress!));
                                              Toast.show(
                                                tr(context).copied,
                                                duration: Toast
                                                    .lengthShort,
                                                gravity: Toast
                                                    .bottom,
                                                textStyle: TextStyle(color: Colors.white),
                                                backgroundColor: Color(
                                                    0xff0BA70F), 
                                              );
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
