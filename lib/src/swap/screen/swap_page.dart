import 'dart:math';

import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/util/swap_page_change_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import 'number_stepper.dart';
import 'package:beldex_wallet/generated/l10n.dart';

class SwapPage extends BasePage {
  @override
  bool get isModalBackButton => false;

  @override
  String get title => 'Swap';

  @override
  Color get textColor => Colors.white;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    return SwapHome();
  }
}

class SwapHome extends StatefulWidget {
  @override
  State<SwapHome> createState() => _SwapHomeState();
}

class _SwapHomeState extends State<SwapHome> {
  int currentStep = 1;
  int stepLength = 4;
  bool complete;

  void next() {
    if (currentStep <= stepLength) {
      goTo(currentStep + 1);
    }
  }

  void back() {
    if (currentStep > 1) {
      goTo(currentStep - 1);
    }
  }

  void goTo(int step) {
    setState(() => currentStep = step);
    if (currentStep > stepLength) {
      setState(() => complete = true);
    }
  }

  final _sendAmountController = TextEditingController();
  final _getAmountController = TextEditingController();
  final _senderAmountController = TextEditingController();
  var showPrefixIcon = false;
  var showMemo = false;
  var acceptTermsAndConditions = false;
  final _listKey = GlobalKey();

  TextEditingController searchYouGetCoinsController = TextEditingController();
  TextEditingController searchYouSendCoinsController = TextEditingController();
  StateSetter _searchYouGetCoinsSetState;
  StateSetter _searchYouSendCoinsSetState;
  String youGetCoinsFilter;
  String youSendCoinsFilter;
  final List<Coins> youGetCoinsList = [
    Coins('BTC','Bitcoin'),
    Coins('ETH','Ethereum'),
    Coins('BDX','Beldex'),
    Coins('XRP','XRP'),
    Coins('XMR','Monero'),
    Coins('SOL','Solana'),
  ];
  Coins selectedYouGetCoins = Coins('BTC','Bitcoin');
  final List<Coins> youSendCoinsList = [
    Coins('BDX','Beldex'),
    Coins('BTC','Bitcoin'),
    Coins('ETH','Ethereum'),
    Coins('XRP','XRP'),
    Coins('XMR','Monero'),
    Coins('SOL','Solana'),
  ];
  Coins selectedYouSendCoins = Coins('BDX','Beldex');
  bool youSendCoinsDropDownVisible = false;
  bool youGetCoinsDropDownVisible = false;
  @override
  void initState() {
    searchYouGetCoinsController.addListener(() {
      _searchYouGetCoinsSetState(() {
        youGetCoinsFilter = searchYouGetCoinsController.text;
      });
    });
    searchYouSendCoinsController.addListener(() {
      _searchYouSendCoinsSetState(() {
        youSendCoinsFilter = searchYouSendCoinsController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    final swapPageChangeNotifier = Provider.of<SwapPageChangeNotifier>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: NumberStepper(
            totalSteps: stepLength,
            width: MediaQuery.of(context).size.width,
            curStep: currentStep,
            stepCompleteColor: Colors.blue,
            currentStepColor: Color(0xff20D030),
            inactiveColor: Color(0xffbababa),
            lineWidth: 2,
          ),
        ),
        Expanded(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Card(
                  margin:
                      EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
                  elevation: 0,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff24242f)
                      : Color(0xfff3f3f3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    width: _screenWidth,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Exchange Screen
                        Visibility(
                          visible: currentStep == 1,
                          child: Column(
                            children: [
                              Visibility(
                                visible:!swapPageChangeNotifier.transactionHistoryScreenVisible,
                                child: exchangeScreen(_scrollController,settingsStore,swapPageChangeNotifier)),
                              //Transaction History Screen
                              Visibility(
                                visible: swapPageChangeNotifier.transactionHistoryScreenVisible,
                                child: transactionHistoryScreen(_screenWidth,_screenHeight,settingsStore,swapPageChangeNotifier),
                              ),
                            ],
                          ),
                        ),
                        //Under maintenance Screen
                        Visibility(visible:false,child: underMaintenanceScreen(_screenWidth,settingsStore)),
                        //Wallet Address Screen
                        Visibility(
                          visible: currentStep == 2,
                          child: walletAddressScreen(settingsStore),
                        ),
                        //Payment->Checkout Screen
                        Visibility(
                          visible: currentStep == 3,
                          child: paymentCheckoutScreen(settingsStore),
                        ),
                        //Payment->Send funds to the address below Screen
                        Visibility(
                          visible: false,
                          child: paymentSendFundsToTheAddressBelowScreen(settingsStore),
                        ),
                        //Exchange->Completed Screen
                        Visibility(
                          visible: false,
                          child: exchangeCompletedScreen(settingsStore),
                        ),
                        //Exchange->Not Paid Screen
                        Visibility(
                          visible: false,
                          child: exchangeNotPaidScreen(settingsStore),
                        ),
                        //Exchange->Exchanging Screen
                        Visibility(
                          visible: currentStep == 4,
                          child: exchangingScreen(settingsStore),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }),
        ),
      ],
    );
  }

  Widget transactionRow(SettingsStore settingsStore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
              accentColor:
                  settingsStore.isDarkTheme ? Colors.white : Colors.black,
              dividerColor: Colors.transparent,
              textSelectionTheme:
                  TextSelectionThemeData(selectionColor: Colors.green)),
          child: Container(
            margin: EdgeInsets.only(top:10,bottom:10),
            width: MediaQuery.of(context).size.width,
            child: ExpansionTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SvgPicture.asset(
                        //'assets/images/swap/swap_waiting.svg',
                        'assets/images/swap/swap_completed.svg',
                        width: 18,
                        height: 18,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: false?Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('Exchange Amount',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffAFAFBE)
                                          : Color(0xff737373))),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text('774 BDX',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff222222))),
                            ),
                          ],
                        ):Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('900 BDX',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xffFFFFFF)
                                              : Color(0xff222222))),
                                  Text('28 Apr 2023',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xffD1D1D3)
                                              : Color(0xff737373))),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: 'Received ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffAFAFBE)
                                                  : Color(0xff737373)),
                                          children: [
                                            TextSpan(
                                                text: '- 0.00063271 BTC',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: true
                                                        ? Color(0xff00AD07)
                                                        : Color(0xff77778B)))
                                          ]),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(true ? 'Completed' : 'Waiting',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: true
                                                ? Color(0xff20D030)
                                                : settingsStore.isDarkTheme
                                                    ? Color(0xffAFAFBE)
                                                    : Color(0xff737373))),
                                  )
                                ]),
                          ],
                        ),
                      )),
                    ]),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('Exchange Rate',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffAFAFBE)
                                          : Color(0xff737373))),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text('1 BDX = 0.00000116BTC',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffD1D1D3)
                                          : Color(0xff737373))),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('Receiver',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffAFAFBE)
                                          : Color(0xff737373))),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text('142...hzy',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffD1D1D3)
                                          : Color(0xff737373))),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('Amount Received',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffAFAFBE)
                                          : Color(0xff737373))),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(true ? '0.00063271 BTC' : '---',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: true
                                          ? Color(0xff20D030)
                                          : settingsStore.isDarkTheme
                                              ? Color(0xffD1D1D3)
                                              : Color(0xff737373))),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('Date',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffAFAFBE)
                                          : Color(0xff737373))),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text('28 Apr 2023 20:14:15',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffD1D1D3)
                                          : Color(0xff737373))),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('Status',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffAFAFBE)
                                          : Color(0xff737373))),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(true ? 'Completed' : 'Waiting',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: true
                                          ? Color(0xff20D030)
                                          : settingsStore.isDarkTheme
                                              ? Color(0xffD1D1D3)
                                              : Color(0xff737373))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        Divider(
          height: 2,
        )
      ],
    );
  }

  InkWell youGetCoinsDropDownListItem(SettingsStore settingsStore, int index) {
    return InkWell(
      onTap: () async {
        searchYouGetCoinsController.text = '';
        if (youGetCoinsList[index].name != null) {
          setState((){
            selectedYouGetCoins = Coins(youGetCoinsList[index].id,youGetCoinsList[index].name);
            youGetCoinsDropDownVisible = !youGetCoinsDropDownVisible;
          });
        }else{
          setState((){
            youGetCoinsDropDownVisible = !youGetCoinsDropDownVisible;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Observer(
              builder: (_) =>  RichText(
                text: TextSpan(
                    text: youGetCoinsList[index].id,
                      style: TextStyle(
                          fontSize: 12,
                          color: settingsStore.isDarkTheme?Color(0xffffffff):Color(0xff222222),
                          fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: ' - ${youGetCoinsList[index].name}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff77778B),
                              fontWeight: FontWeight.w400))
                    ]),
              ),
            )),
      ),
    );
  }

  InkWell youSendCoinsDropDownListItem(SettingsStore settingsStore, int index) {
    return InkWell(
      onTap: () async {
        searchYouSendCoinsController.text = '';
        if (youSendCoinsList[index].name != null) {
          setState((){
            selectedYouSendCoins = Coins(youSendCoinsList[index].id,youSendCoinsList[index].name);
            youSendCoinsDropDownVisible = !youSendCoinsDropDownVisible;
          });
        }else{
          setState((){
            youSendCoinsDropDownVisible = !youSendCoinsDropDownVisible;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Observer(
              builder: (_) =>  RichText(
                text: TextSpan(
                    text: youSendCoinsList[index].id,
                    style: TextStyle(
                        fontSize: 12,
                        color: settingsStore.isDarkTheme?Color(0xffffffff):Color(0xff222222),
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: ' - ${youSendCoinsList[index].name}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff77778B),
                              fontWeight: FontWeight.w400))
                    ]),
              ),
            )),
      ),
    );
  }

  Widget underMaintenanceScreen(double _screenWidth, SettingsStore settingsStore){
    return Expanded(
      child: Container(
        width: _screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/swap/under_maintenance.svg',
              color: settingsStore.isDarkTheme
                  ? Color(0xff65656E)
                  : Color(0xffDADADA),
              width: 112,
              height: 112,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'BDX',
                  style: TextStyle(
                      color: Color(0xff20D030),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                        text:
                        ' Swap is temporarily\nunder maintenance.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)))
                  ]),
            ),
            Text('Please try again after some times.',
                style: TextStyle(
                    color: settingsStore.isDarkTheme
                        ? Color(0xff82828D)
                        : Color(0xff737373),
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  Widget exchangeScreen(ScrollController _scrollController, SettingsStore settingsStore, SwapPageChangeNotifier swapPageChangeNotifier){
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Exchange Title
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exchange',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff060606)),
                ),
                InkWell(
                  onTap: (){
                    swapPageChangeNotifier.setTransactionHistoryScreenVisibleStatus(true);
                  },
                  child: SvgPicture.asset(
                    'assets/images/swap/history.svg',
                    color: settingsStore.isDarkTheme
                        ? Color(0xffffffff)
                        : Color(0xff16161D),
                    width: 25,
                    height: 25,
                  ),
                )
              ],
            ),
            //You send title
            Container(
              margin: EdgeInsets.only(
                  top: 20, left: 10, bottom: 10),
              child: Text(
                'You send',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: settingsStore.isDarkTheme
                        ? Color(0xffFFFFFF)
                        : Color(0xff060606)),
              ),
            ),
            //You send TextFormField
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(
                  left: 10, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: settingsStore.isDarkTheme
                    ? Color(0xff24242f)
                    : Color(0xfff3f3f3),
                border: Border.all(
                  color: Color(0xff333343),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex:1,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .caption
                              .color),
                      controller: _sendAmountController,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final regEx = RegExp(r'^\d*\.?\d*');
                              final newString =
                                  regEx.stringMatch(newValue.text) ??
                                      '';
                              return newString == newValue.text
                                  ? newValue
                                  : oldValue;
                            }),
                        FilteringTextInputFormatter.deny(
                            RegExp('[-, ]'))
                      ],
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.6)),
                        hintText: S.of(context).enterAmount,
                        errorStyle:
                        TextStyle(color: BeldexPalette.red),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState((){
                          youSendCoinsDropDownVisible = !youSendCoinsDropDownVisible;
                        });
                      },
                      child: Container(
                        width: 125.0,
                        height:40,
                        margin: EdgeInsets.only(
                            left: 3),
                        padding: EdgeInsets.only(
                            left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff333343)
                                : Color(0xffEBEBEB),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: selectedYouSendCoins.id,
                                    style: TextStyle(
                                        color: settingsStore
                                            .isDarkTheme
                                            ? Color(
                                            0xffFFFFFF)
                                            : Color(
                                            0xff222222),
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w500),
                                    children: [
                                      TextSpan(
                                          text: ' - ${selectedYouSendCoins.name}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight
                                                  .normal,
                                              color: Color(
                                                  0xff77778B)))
                                    ]),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down,
                                size: 20,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff060606))
                          ],
                        ),
                      ))
                ],
              ),
            ),
            //Swap coin button
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: true,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color:
                        Color(0xff00AD07).withAlpha(25),
                        borderRadius: BorderRadius.all(
                            Radius.circular(8))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Minimum amount is ',
                          style: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff222222),
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                                text: '762 BTC',
                                style: TextStyle(
                                    decoration: TextDecoration
                                        .underline,
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w500,
                                    color: settingsStore
                                        .isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff222222)))
                          ]),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff333343)
                              : Color(0xffFFFFFF),
                          borderRadius: BorderRadius.all(
                              Radius.circular(8))),
                      child: Transform.rotate(
                        angle: 90 * pi / 180,
                        child: SvgPicture.asset(
                          'assets/images/swap/swap.svg',
                          color: settingsStore.isDarkTheme
                              ? Color(0xffA9A9CD)
                              : Color(0xff222222),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ))
              ],
            ),
            //You get title
            Container(
              margin: EdgeInsets.only(
                  top: 10, left: 10, bottom: 10),
              child: Text(
                'You get',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: settingsStore.isDarkTheme
                        ? Color(0xffFFFFFF)
                        : Color(0xff060606)),
              ),
            ),
            //You get TextFormField
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(
                  left: 10, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: settingsStore.isDarkTheme
                    ? Color(0xff24242f)
                    : Color(0xfff3f3f3),
                border: Border.all(
                  color: Color(0xff333343),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex:1,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .caption
                              .color),
                      controller: _getAmountController,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final regEx = RegExp(r'^\d*\.?\d*');
                              final newString =
                                  regEx.stringMatch(newValue.text) ??
                                      '';
                              return newString == newValue.text
                                  ? newValue
                                  : oldValue;
                            }),
                        FilteringTextInputFormatter.deny(
                            RegExp('[-, ]'))
                      ],
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.6)),
                        hintText: '...',
                        errorStyle:
                        TextStyle(color: BeldexPalette.red),),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState((){
                          youGetCoinsDropDownVisible = !youGetCoinsDropDownVisible;
                        });
                      },
                      child: Container(
                        width: 125.0,
                        height:40,
                        margin: EdgeInsets.only(
                            left: 3),
                        padding: EdgeInsets.only(
                            left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff333343)
                                : Color(0xffEBEBEB),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: selectedYouGetCoins.id,
                                    style: TextStyle(
                                        color: settingsStore
                                            .isDarkTheme
                                            ? Color(
                                            0xffFFFFFF)
                                            : Color(
                                            0xff222222),
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w500),
                                    children: [
                                      TextSpan(
                                          text: ' - ${selectedYouGetCoins.name}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight
                                                  .normal,
                                              color: Color(
                                                  0xff77778B)))
                                    ]),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down,
                                size: 20,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff060606))
                          ],
                        ),
                      ))
                ],
              ),
            ),
            //Floating Exchange Rate Card
            Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: settingsStore.isDarkTheme
                      ? Color(0xff32324A)
                      : Color(0xffFFFFFF),
                  border: Border.all(
                    color: Color(0xff00Ad07),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff40405E)
                                  : Color(0xffF3F3F3)),
                          child: SvgPicture.asset(
                            'assets/images/swap/floating_exchange_rate.svg',
                            color: settingsStore.isDarkTheme
                                ? Color(0xffA9A9CD)
                                : Color(0xff77778B),
                            width: 20,
                            height: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Floating Exchange Rate',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff737373)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        '~25148.398',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff060606)),
                      ),
                    ),
                  ],
                )),
            //Fixed Exchange Rate Card
            Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: settingsStore.isDarkTheme
                      ? Color(0xff32324A)
                      : Color(0xffFFFFFF),
                  border: Border.all(
                    color: Color(0xff32324A),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff40405E)
                                  : Color(0xffF3F3F3)),
                          child: SvgPicture.asset(
                            'assets/images/swap/fixed_exchange_rate.svg',
                            color: settingsStore.isDarkTheme
                                ? Color(0xffA9A9CD)
                                : Color(0xff77778B),
                            width: 20,
                            height: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Fixed Exchange Rate',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff737373)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        '25148.398',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff060606)),
                      ),
                    ),
                  ],
                )),
            //Floating and Fixed Exchange Rate Info
            Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                  border: Border.all(
                    color: settingsStore.isDarkTheme
                        ? Color(0xff41415B)
                        : Color(0xFFDADADA),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 3.0),
                      child: Icon(Icons.info_outline,
                          size: 15,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffD1D1DB)
                              : Color(0xff77778B)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        'The floating rate can change at any point due to market conditions, so you might receive more or less crypto than expected.',
                        //'With the fixed rate, you will receive the exact amount of crypto you see on this screen',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff77778B)),
                      ),
                    ),
                  ],
                )),
            //Exchange Button
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  next();
                },
                style: ElevatedButton.styleFrom(
                  primary: true
                      ? Color(0xff0BA70F)
                      : settingsStore.isDarkTheme
                      ? Color(0xff32324A)
                      : Color(0xffFFFFFF),
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 50,
                      right: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Exchange',
                    style: TextStyle(
                        color: true
                            ? Color(0xffffffff)
                            : settingsStore.isDarkTheme
                            ? Color(0xff77778B)
                            : Color(0xffB1B1D1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
        //You get dropdown box
        Visibility(
          visible: youGetCoinsDropDownVisible,
          child: StatefulBuilder(builder:(BuildContext context,StateSetter setState){
            _searchYouGetCoinsSetState = setState;
            return Container(
              height: 200,
              margin:EdgeInsets.only(top:275,left:MediaQuery.of(context).size.width/4),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff272733)
                      : Color(0xffFFFFFF),
                  borderRadius:
                  BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      style:TextStyle(fontSize: 14),
                      controller: searchYouGetCoinsController,
                      decoration: InputDecoration(
                        fillColor:settingsStore.isDarkTheme?Color(0xff333343):Color(0xffF8F8F8),
                        hintText: 'Search Coins',
                        hintStyle:TextStyle(
                          color:Color(0xff77778B),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: youGetCoinsFilter == null || youGetCoinsFilter.isEmpty ? Colors.transparent : settingsStore
                                  .isDarkTheme
                                  ? Color(
                                  0xffffffff)
                                  : Color(
                                  0xff171720),
                            ),
                            onPressed: youGetCoinsFilter == null || youGetCoinsFilter.isEmpty ? null : () {
                              searchYouGetCoinsController
                                  .clear();
                            }),
                        contentPadding: EdgeInsets.only(left:10,top:5,bottom:5,right:10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: settingsStore.isDarkTheme?Color(0xff484856):Color(0xffDADADA))
                        ),
                        focusedBorder:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: settingsStore.isDarkTheme?Color(0xff484856):Color(0xffDADADA))
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Observer(
                          builder: (_) {
                            return RawScrollbar(
                              controller: _scrollController,
                              thickness: 8,
                              thumbColor: settingsStore
                                  .isDarkTheme
                                  ? Color(
                                  0xff3A3A45)
                                  : Color(
                                  0xffC2C2C2),
                              radius: Radius
                                  .circular(
                                  10.0),
                              isAlwaysShown:
                              true,
                              child: ListView
                                  .builder(
                                  itemCount: youGetCoinsList.length,
                                  controller:
                                  _scrollController,
                                  itemBuilder:
                                      (BuildContext context,
                                      int index) {
                                    return youGetCoinsFilter == null ||
                                        youGetCoinsFilter == ''
                                        ? youGetCoinsDropDownListItem(settingsStore, index)
                                        : '${youGetCoinsList[index].name}'.toLowerCase().contains(youGetCoinsFilter.toLowerCase())
                                        ? youGetCoinsDropDownListItem(settingsStore, index)
                                        : Container();
                                  }),
                            );
                          },
                        )),
                  ),
                ],
              ),
            );
          }),
        ),
        //You send dropdown box
        Visibility(
          visible: youSendCoinsDropDownVisible,
          child: StatefulBuilder(builder:(BuildContext context,StateSetter setState){
            _searchYouSendCoinsSetState = setState;
            return Container(
              height: 200,
              margin:EdgeInsets.only(top:130,left:MediaQuery.of(context).size.width/4),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff272733)
                      : Color(0xffFFFFFF),
                  borderRadius:
                  BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      style:TextStyle(fontSize: 14),
                      controller: searchYouSendCoinsController,
                      decoration: InputDecoration(
                        fillColor:settingsStore.isDarkTheme?Color(0xff333343):Color(0xffF8F8F8),
                        hintText: 'Search Coins',
                        hintStyle:TextStyle(
                          color:Color(0xff77778B),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: youSendCoinsFilter == null || youSendCoinsFilter.isEmpty ? Colors.transparent : settingsStore
                                  .isDarkTheme
                                  ? Color(
                                  0xffffffff)
                                  : Color(
                                  0xff171720),
                            ),
                            onPressed: youSendCoinsFilter == null || youSendCoinsFilter.isEmpty ? null : () {
                              searchYouSendCoinsController
                                  .clear();
                            }),
                        contentPadding: EdgeInsets.only(left:10,top:5,bottom:5,right:10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: settingsStore.isDarkTheme?Color(0xff484856):Color(0xffDADADA))
                        ),
                        focusedBorder:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: settingsStore.isDarkTheme?Color(0xff484856):Color(0xffDADADA))
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Observer(
                          builder: (_) {
                            return RawScrollbar(
                              controller: _scrollController,
                              thickness: 8,
                              thumbColor: settingsStore
                                  .isDarkTheme
                                  ? Color(
                                  0xff3A3A45)
                                  : Color(
                                  0xffC2C2C2),
                              radius: Radius
                                  .circular(
                                  10.0),
                              isAlwaysShown:
                              true,
                              child: ListView
                                  .builder(
                                  itemCount: youSendCoinsList.length,
                                  controller:
                                  _scrollController,
                                  itemBuilder:
                                      (BuildContext context,
                                      int index) {
                                    return youSendCoinsFilter == null ||
                                        youSendCoinsFilter == ''
                                        ? youSendCoinsDropDownListItem(settingsStore, index)
                                        : '${youSendCoinsList[index].name}'.toLowerCase().contains(youSendCoinsFilter.toLowerCase())
                                        ? youSendCoinsDropDownListItem(settingsStore, index)
                                        : Container();
                                  }),
                            );
                          },
                        )),
                  ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }

  Widget walletAddressScreen(SettingsStore settingsStore){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Wallet Address Title
        Text(
          'Wallet Address',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: settingsStore.isDarkTheme
                  ? Color(0xffFFFFFF)
                  : Color(0xff060606)),
        ),
        //Recipient Address Title / Destination wallet Address Title
        Container(
          margin: EdgeInsets.only(
              top: 20, left: 10, bottom: 10),
          child: Text(
            'Recipient Address',
            //'Destination wallet Address',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        //Recipient Address TextFormField / Destination wallet Address TextFormField
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(
              left: 10, right: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: settingsStore.isDarkTheme
                ? Color(0xff24242f)
                : Color(0xfff3f3f3),
            border: Border.all(
              color: Color(0xff333343),
            ),
          ),
          child: TextFormField(
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Theme.of(context)
                    .primaryTextTheme
                    .caption
                    .color),
            controller: _senderAmountController,
            keyboardType: TextInputType.numberWithOptions(
                signed: false, decimal: true),
            inputFormatters: [
              TextInputFormatter.withFunction(
                      (oldValue, newValue) {
                    final regEx = RegExp(r'^\d*\.?\d*');
                    final newString =
                        regEx.stringMatch(newValue.text) ??
                            '';
                    return newString == newValue.text
                        ? newValue
                        : oldValue;
                  }),
              FilteringTextInputFormatter.deny(
                  RegExp('[-, ]'))
            ],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.withOpacity(0.6)),
                hintText:
                'Enter your BTC recipient address',
                errorStyle:
                TextStyle(color: BeldexPalette.red),
                prefixIcon: showPrefixIcon
                    ? Container(
                    margin: EdgeInsets.only(
                        right: 3, top: 3, bottom: 3),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color:
                        settingsStore.isDarkTheme
                            ? Color(0xff333343)
                            : Color(0xffEBEBEB),
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(8))),
                    child: Text(
                      'BEP2',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                          FontWeight.normal,
                          color: settingsStore
                              .isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff060606)),
                    ))
                    : null,
                suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 20.0,
                      margin: EdgeInsets.only(
                          left: 3, top: 3, bottom: 3),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff333343)
                              : Color(0xffEBEBEB),
                          borderRadius: BorderRadius.all(
                              Radius.circular(8))),
                      child: SvgPicture.asset(
                        'assets/images/swap/scan_qr.svg',
                        color: settingsStore.isDarkTheme
                            ? Color(0xffA9A9CD)
                            : Color(0xff222222),
                        width: 20,
                        height: 20,
                      ),
                    ))),
          ),
        ),
        //Refund wallet Address Title
        Container(
          margin: EdgeInsets.only(
              top: 10, left: 10, bottom: 10),
          child: Text(
            'Refund wallet Address',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        //Refund wallet Address TextFormField
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(
              left: 10, right: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: settingsStore.isDarkTheme
                ? Color(0xff24242f)
                : Color(0xfff3f3f3),
            border: Border.all(
              color: Color(0xff333343),
            ),
          ),
          child: TextFormField(
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Theme.of(context)
                    .primaryTextTheme
                    .caption
                    .color),
            controller: _senderAmountController,
            keyboardType: TextInputType.numberWithOptions(
                signed: false, decimal: true),
            inputFormatters: [
              TextInputFormatter.withFunction(
                      (oldValue, newValue) {
                    final regEx = RegExp(r'^\d*\.?\d*');
                    final newString =
                        regEx.stringMatch(newValue.text) ??
                            '';
                    return newString == newValue.text
                        ? newValue
                        : oldValue;
                  }),
              FilteringTextInputFormatter.deny(
                  RegExp('[-, ]'))
            ],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.withOpacity(0.6)),
                hintText: 'Enter your BDX refund address',
                errorStyle:
                TextStyle(color: BeldexPalette.red),
                suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 20.0,
                      margin: EdgeInsets.only(
                          left: 3, top: 3, bottom: 3),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff333343)
                              : Color(0xffEBEBEB),
                          borderRadius: BorderRadius.all(
                              Radius.circular(8))),
                      child: SvgPicture.asset(
                        'assets/images/swap/scan_qr.svg',
                        color: settingsStore.isDarkTheme
                            ? Color(0xffA9A9CD)
                            : Color(0xff222222),
                        width: 20,
                        height: 20,
                      ),
                    ))),
          ),
        ),
        //Destination Tag Info
        Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff41415B)
                    : Color(0xFFDADADA),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 3.0),
                      child: Icon(Icons.info_outline,
                          size: 15,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffD1D1DB)
                              : Color(0xff77778B)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        'Please specify the Destination Tag for your BDX receiving address if your wallet provides it. Your transaction will not go through if you omit it. If your wallet doesn’t require a Destination Tag, remove the tick.',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff77778B)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          showMemo = !showMemo;
                        });
                      },
                      child: Icon(
                          showMemo
                              ? Icons.check_box_outlined
                              : Icons
                              .check_box_outline_blank,
                          size: 15,
                          color: showMemo
                              ? Color(0xff20D030)
                              : settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        'My wallet requires Destination Tag',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        //Destination Tag TextFormField
        Visibility(
          visible: showMemo,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(
                left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: settingsStore.isDarkTheme
                  ? Color(0xff24242f)
                  : Color(0xfff3f3f3),
              border: Border.all(
                color: Color(0xff333343),
              ),
            ),
            child: TextFormField(
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context)
                      .primaryTextTheme
                      .caption
                      .color),
              controller: _senderAmountController,
              keyboardType:
              TextInputType.numberWithOptions(
                  signed: false, decimal: true),
              inputFormatters: [
                TextInputFormatter.withFunction(
                        (oldValue, newValue) {
                      final regEx = RegExp(r'^\d*\.?\d*');
                      final newString =
                          regEx.stringMatch(newValue.text) ??
                              '';
                      return newString == newValue.text
                          ? newValue
                          : oldValue;
                    }),
                FilteringTextInputFormatter.deny(
                    RegExp('[-, ]'))
              ],
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.withOpacity(0.6)),
                hintText: 'Enter Destination Tag',
                errorStyle:
                TextStyle(color: BeldexPalette.red),
              ),
            ),
          ),
        ),
        //Transaction Preview
        Container(
          margin: EdgeInsets.only(
              left: 10.0, bottom: 10.0, top: 5.0),
          child: Text(
            'Transaction Preview',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        Table(
          border: TableBorder(
            top: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            left: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            right: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            verticalInside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
          ),
          children: [
            //Floating Exchange Rate
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0),
                child: Text(
                  'You send',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  '10 ETH',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0),
                child: Text(
                  'Exchange rate',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  '1 ETH ~ 2,518.97904761 XRP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0),
                child: Text(
                  'Service fee 0.25%',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  '62.99676191 XRP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0),
                child: Text(
                  'Network fee',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '0.154938 XRP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),

            //Fixed Exchange Rate
            if (false)
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0),
                  child: Text(
                    'Fixed rate',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      Text('1 ETH ~ 2,518.97904761 XRP',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff222222))),
                      Text(
                          'The fixed rate is updated every 30 Seconds',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight:
                              FontWeight.normal,
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffAfAFBE)
                                  : Color(0xff737373)))
                    ],
                  ),
                )
              ]),
            if (false)
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0),
                  child: Text(
                    'Network fee',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'All fees included in the rate',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffEBEBEB)
                            : Color(0xff222222)),
                  ),
                )
              ]),
          ],
        ),
        Table(
          border: TableBorder.symmetric(
            outside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            inside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
          ),
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, bottom: 10.0),
                child: Text(
                  'You Get',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '~ 25135.553062 XRP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),
          ],
        ),

        Container(
          margin: EdgeInsets.only(
              top: 10.0,
              left: 5.0,
              right: 5.0,
              bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    acceptTermsAndConditions =
                    !acceptTermsAndConditions;
                  });
                },
                child: Icon(
                    acceptTermsAndConditions
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank,
                    size: 15,
                    color: acceptTermsAndConditions
                        ? Color(0xff20D030)
                        : settingsStore.isDarkTheme
                        ? Color(0xffFFFFFF)
                        : Color(0xff222222)),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text:
                        'I agree with Terms of Use, ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                decoration:
                                TextDecoration.underline,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color:
                                settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color:
                                settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                          TextSpan(
                            text: 'AML/KYC',
                            style: TextStyle(
                                decoration:
                                TextDecoration.underline,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color:
                                settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          )
                        ])),
              ),
            ],
          ),
        ),
        //Exchange Button
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              if(acceptTermsAndConditions){
                next();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: acceptTermsAndConditions
                  ? Color(0xff0BA70F)
                  : settingsStore.isDarkTheme
                  ? Color(0xff32324A)
                  : Color(0xffFFFFFF),
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 50,
                  right: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Next',
                style: TextStyle(
                    color: acceptTermsAndConditions
                        ? Color(0xffffffff)
                        : settingsStore.isDarkTheme
                        ? Color(0xff77778B)
                        : Color(0xffB1B1D1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Widget paymentCheckoutScreen(SettingsStore settingsStore){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Checkout Title
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/swap/swap_back.svg',
              color: settingsStore.isDarkTheme
                  ? Color(0xffffffff)
                  : Color(0xff16161D),
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Checkout',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff060606)),
            ),
          ],
        ),
        //You Send Details
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
              ),
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You send',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                      ),
                      Text(
                        '10 BDX',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff20D030)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 3, top: 3, bottom: 3),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff4F4F70)
                              : Color(0xffDADADA),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(8))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Blockchain:',
                          style: TextStyle(
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373),
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w500),
                          children: [
                            TextSpan(
                                text: 'Beldex',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.normal,
                                    color: settingsStore
                                        .isDarkTheme
                                        ? Color(
                                        0xffFFFFFF)
                                        : Color(
                                        0xff222222)))
                          ]),
                    ),
                  ),
                ),
              ],
            )),
        //You Get Details
        Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
              ),
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You get',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                      ),
                      Text(
                        '0.00063271 BTC',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff20D030)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 3, top: 3, bottom: 3),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff4F4F70)
                              : Color(0xffDADADA),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(8))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Blockchain:',
                          style: TextStyle(
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373),
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w500),
                          children: [
                            TextSpan(
                                text: 'Bitcoin',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.normal,
                                    color: settingsStore
                                        .isDarkTheme
                                        ? Color(
                                        0xffFFFFFF)
                                        : Color(
                                        0xff222222)))
                          ]),
                    ),
                  ),
                ),
              ],
            )),
        //Exchange Fee 0.25 % Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Exchange Fee 0.25%',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '0.00000225 BTC',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Network Fee Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Network Fee',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '0.000265 BTC',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Recipient Address Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Recipient Address',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '79bf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Exchange Rate Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Exchange Rate',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '1 BDX ~ 0.00000116 BTC',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Estimated Time
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 30),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff4F4F70)
                    : Color(0xffDADADA),
              ),
              borderRadius:
              BorderRadius.all(Radius.circular(8))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer_outlined,
                size: 12,
                color: settingsStore.isDarkTheme
                    ? Color(0xffAFAFBE)
                    : Color(0xff737373),
              ),
              SizedBox(
                width: 5,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Estimated Time ',
                    style: TextStyle(
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: '5-30 mins',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff222222)))
                    ]),
              ),
            ],
          ),
        ),
        //Confirm and Make Payment Button
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              next();
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xff0BA70F),
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 25,
                  right: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Confirm & Make Payment',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Widget paymentSendFundsToTheAddressBelowScreen(SettingsStore settingsStore){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Send funds to the address below Title
        Text(
          'Send funds to the address below',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: settingsStore.isDarkTheme
                  ? Color(0xffFFFFFF)
                  : Color(0xff060606)),
        ),
        //Amount Details
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              border: Border(
                  left: BorderSide(
                    width: 1.0,
                    color: settingsStore.isDarkTheme
                        ? Color(0xff303041)
                        : Color(0xffDADADA),
                  )),
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff222222)),
                      ),
                      Text(
                        '10 BDX',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff20D030)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                        left: 10.0,
                        right: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff20D030),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(8))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        settingsStore.isDarkTheme
                            ? SvgPicture.asset(
                          'assets/images/swap/swap_wallet_dark.svg',
                          width: 25,
                          height: 25,
                        )
                            : SvgPicture.asset(
                          'assets/images/swap/swap_wallet_light.svg',
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Wallet',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.normal,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)))
                      ],
                    ),
                  ),
                ),
              ],
            )),
        //Transaction ID with Time Details
        Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)),
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
              ),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Transaction ID',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'bcbf9e4b0703d65',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.copy,
                      color: Color(0xff20D030),
                      size: 14,
                    )
                  ],
                )
              ],
            )),
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
              ),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Time left to send 0.1 BTC',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373),
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '02:59:00',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                )
              ],
            )),
        //Recipient Address Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Recipient Address',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffAFAFBE)
                      : Color(0xff737373)),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    'bcbf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffFFFFFF)
                            : Color(0xff222222)),
                  ),
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Container(
                          width: 30.0,
                          margin: EdgeInsets.only(
                              left: 5, right: 5),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color(0xff00AD07),
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      5))),
                          child: Icon(
                            Icons.copy,
                            color: Color(0xffFFFFFF),
                            size: 20,
                          ),
                        )),
                    InkWell(
                        onTap: () {},
                        child: Container(
                          width: 30.0,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xff32324A)
                                  : Color(0xffFFFFFF),
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(
                                      5))),
                          child: SvgPicture.asset(
                            'assets/images/swap/scan_qr.svg',
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222),
                            width: 20,
                            height: 20,
                          ),
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text('blockchain : bitcoin',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff00AD07))),
          ],
        ),
        //Time Remaining Details
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 20, bottom: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xff00AD07).withAlpha(25),
              borderRadius:
              BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 15,
                    color: settingsStore.isDarkTheme
                        ? Color(0xffAFAFBE)
                        : Color(0xff737373),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Time Remaining : 2:59:00',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'You Have 3 Hours to send funds otherwise the transaction will be cancelled automatically.\n\nThe exchange will be initiated once the funds are received.',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff222222)))
            ],
          ),
        ),
        //Transaction Preview
        Container(
          margin:
          EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Text(
            'Transaction Preview',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        Table(
          border: TableBorder(
            top: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            left: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            right: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            verticalInside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
          ),
          children: [
            //Floating Exchange Rate
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0),
                child: Text(
                  'You send',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  '10 ETH',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0),
                child: Text(
                  'Exchange rate',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  '1 ETH ~ 2,518.97904761 XRP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0),
                child: Text(
                  'Service fee 0.25%',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  '62.99676191 XRP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0),
                child: Text(
                  'Network fee',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '0.154938 XRP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),

            //Fixed Exchange Rate
            if (false)
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0),
                  child: Text(
                    'Fixed rate',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      Text('1 ETH ~ 2,518.97904761 XRP',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff222222))),
                      Text(
                          'The fixed rate is updated every 30 Seconds',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight:
                              FontWeight.normal,
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffAfAFBE)
                                  : Color(0xff737373)))
                    ],
                  ),
                )
              ]),
            if (false)
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0),
                  child: Text(
                    'Network fee',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'All fees included in the rate',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffEBEBEB)
                            : Color(0xff222222)),
                  ),
                )
              ]),
          ],
        ),
        Table(
          border: TableBorder.symmetric(
            outside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            inside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
          ),
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, bottom: 10.0),
                child: Text(
                  'You Get',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '~ 25135.553062 XRP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffEBEBEB)
                          : Color(0xff222222)),
                ),
              )
            ]),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget exchangeCompletedScreen(SettingsStore settingsStore){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Completed Back Title
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/swap/swap_back.svg',
              color: settingsStore.isDarkTheme
                  ? Color(0xffffffff)
                  : Color(0xff16161D),
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Back',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff060606)),
            ),
          ],
        ),
        //Completed Details
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 6, right: 6, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Completed Title
              Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/swap/swap_completed.svg',
                    color: Color(0xff159B24),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Completed',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff159B24)),
                  ),
                ],
              ),
              //Transaction ID Details
              Container(
                  width:
                  MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: settingsStore.isDarkTheme
                        ? Colors.transparent
                        : Color(0xffFFFFFF),
                    borderRadius:
                    BorderRadius.circular(8),
                    border: Border.all(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff484856)
                          : Color(0xffDADADA),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          'Transaction ID',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'bcbf9e4b0703d65',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w400,
                                    color: settingsStore
                                        .isDarkTheme
                                        ? Color(
                                        0xffEBEBEB)
                                        : Color(
                                        0xff222222)),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.copy,
                              color: Color(0xff20D030),
                              size: 14,
                            )
                          ],
                        ),
                      )
                    ],
                  )),

              Table(
                children: [
                  //Amount from and Amount To Details
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount from',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w400,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '0.1 BTC',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount to',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w400,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '1.6112626 ETH',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    )
                  ]),
                  //Received Time and Amount Sent Details
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Received Time',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w400,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '22 Jul 2023, 18:45:47',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount Sent',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w400,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '22 Jul 2023, 18:45:47',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    )
                  ]),
                  //Exchange Rate and Network fee Details
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exchange Rate',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w400,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '1 BDX ~ 0.00016151 BNB',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Network fee',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w400,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '0.00068934 BNB',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    )
                  ]),
                ],
              ),
              //Recipient Address Details
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipient Address',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '79bf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
              //Memo Details
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Memo',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '400016891',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        //Confirm and Make Payment Button
        Table(
          children: [
            //Input Hash and Output Hash
            TableRow(children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: settingsStore.isDarkTheme
                        ? Color(0xff242433)
                        : Color(0xffDADADA),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        side: BorderSide(
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xff41415B)
                                : Color(0xffF3F3F3))),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/images/swap/swap_input_hash.svg',
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373),
                          width: 18,
                          height: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 2,
                        child: Text('Input Hash',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffffffff)
                                    : Color(0xff222222),
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: settingsStore.isDarkTheme
                        ? Color(0xff242433)
                        : Color(0xffDADADA),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                        side: BorderSide(
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xff41415B)
                                : Color(0xffF3F3F3))),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/images/swap/swap_output_hash.svg',
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373),
                          width: 18,
                          height: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 2,
                        child: Text('Output Hash',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffffffff)
                                    : Color(0xff222222),
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            //Open History and New Transaction
            TableRow(children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: settingsStore.isDarkTheme
                        ? Color(0xff32324A)
                        : Color(0xffFFFFFF),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Open History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: settingsStore.isDarkTheme
                              ? Color(0xffffffff)
                              : Color(0xff222222),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff0BA70F),
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/images/swap/swap_restart.svg',
                          color: Color(0xffffffff),
                          width: 12,
                          height: 12,
                        ),
                      ),
                      SizedBox(width: 3),
                      Flexible(
                        flex: 3,
                        child: Text('New Transaction',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
              ),
            ])
          ],
        )
      ],
    );
  }

  Widget exchangeNotPaidScreen(SettingsStore settingsStore){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Completed Back Title
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/swap/swap_back.svg',
              color: settingsStore.isDarkTheme
                  ? Color(0xffffffff)
                  : Color(0xff16161D),
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Back',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff060606)),
            ),
          ],
        ),
        //Completed Details
        Container(
          width: MediaQuery.of(context).size.width,
          margin:
          EdgeInsets.only(left: 5, right: 5, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Completed Title
              Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/swap/swap_waiting.svg',
                    color: settingsStore.isDarkTheme
                        ? Color(0xffAFAFBE)
                        : Color(0xff737373),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Not Paid',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373)),
                  ),
                ],
              ),
              //Transaction ID Details
              Container(
                  width:
                  MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: settingsStore.isDarkTheme
                        ? Colors.transparent
                        : Color(0xffFFFFFF),
                    borderRadius:
                    BorderRadius.circular(8),
                    border: Border.all(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff484856)
                          : Color(0xffDADADA),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          'Transaction ID',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'bcbf9e4b0703d65',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.w400,
                                    color: settingsStore
                                        .isDarkTheme
                                        ? Color(
                                        0xffEBEBEB)
                                        : Color(
                                        0xff222222)),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.copy,
                              color: Color(0xff20D030),
                              size: 14,
                            )
                          ],
                        ),
                      )
                    ],
                  )),

              Table(
                children: [
                  //Amount from and Amount To Details
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount from',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w400,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '0.1 BTC',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount to',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w400,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '1.6112626 ETH',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                color: settingsStore
                                    .isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    )
                  ]),
                ],
              ),
              //Recipient Address Details
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipient Address',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '79bf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //Not Paid Warning Info
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xff00AD07).withAlpha(25),
              border: Border.all(
                color: Color(0xff00AD07).withAlpha(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 3.0),
                  child: Icon(Icons.info_outline,
                      size: 15,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffD1D1DB)
                          : Color(0xff77778B)),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'The floating rate can change at any point due to market conditions, so you might receive more or less crypto than expected.',
                    //'With the fixed rate, you will receive the exact amount of crypto you see on this screen',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff77778B)),
                  ),
                ),
              ],
            )),
        //Confirm and Make Payment Button
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Color(0xff0BA70F),
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 50,
                  right: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/swap/swap_restart.svg',
                  color: Color(0xffffffff),
                  width: 12,
                  height: 12,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Start Over',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget exchangingScreen(SettingsStore settingsStore){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Exchanging Title
        Text(
          'Exchanging',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: settingsStore.isDarkTheme
                  ? Color(0xffFFFFFF)
                  : Color(0xff060606)),
        ),
        //Progress bar
        Container(
          height: 3,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: LinearProgressIndicator(
            backgroundColor: settingsStore.isDarkTheme
                ? Color(0xff32324A)
                : Color(0xffFFFFFF),
            valueColor: AlwaysStoppedAnimation<Color>(
                BeldexPalette.belgreen),
            value: 0.5,
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                //Confirming in progress Details
                Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0),
                        child: SvgPicture.asset(
                          'assets/images/swap/swap_loading.svg',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirming in progress',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.w500,
                                  color: settingsStore
                                      .isDarkTheme
                                      ? Color(0xffEBEBEB)
                                      : Color(
                                      0xff222222)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Once BDX is confirmed in the blockchain, we’ll start exchanging it to BNB',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.w400,
                                  color: settingsStore
                                      .isDarkTheme
                                      ? Color(0xffAFAFBE)
                                      : Color(
                                      0xff737373)),
                            ),
                            SizedBox(height: 5),
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                mainAxisSize:
                                MainAxisSize.min,
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .center,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      'See input hash in explorer',
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration
                                              .underline,
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight
                                              .w500,
                                          color: settingsStore
                                              .isDarkTheme
                                              ? Color(
                                              0xffEBEBEB)
                                              : Color(
                                              0xff222222)),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Flexible(
                                    flex: 1,
                                    child: Icon(
                                        Icons
                                            .info_outline,
                                        size: 12,
                                        color: settingsStore
                                            .isDarkTheme
                                            ? Color(
                                            0xffD1D1DB)
                                            : Color(
                                            0xff77778B)),
                                  ),
                                ]),
                          ],
                        ),
                      )
                    ]),
                Container(
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0),
                  height: 1,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff8787A8)
                      : Color(0xffDADADA),
                ),
                //Exchanging BDX to BNB
                Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0),
                        child: Transform.rotate(
                          angle: 90 * pi / 180,
                          child: SvgPicture.asset(
                            'assets/images/swap/swap.svg',
                            color:
                            settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff737373),
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exchanging BDX to BNB',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.w500,
                                  color: settingsStore
                                      .isDarkTheme
                                      ? Color(0xffEBEBEB)
                                      : Color(
                                      0xff222222)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'The process will take a few minutes. please wait.',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.w400,
                                  color: settingsStore
                                      .isDarkTheme
                                      ? Color(0xffAFAFBE)
                                      : Color(
                                      0xff737373)),
                            ),
                          ],
                        ),
                      )
                    ]),
                Container(
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0),
                  height: 1,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff8787A8)
                      : Color(0xffDADADA),
                ),
                //Sending funds to your wallet
                Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0),
                        child: SvgPicture.asset(
                          'assets/images/swap/swap_wallet.svg',
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373),
                          width: 15,
                          height: 15,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sending funds to your wallet',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.w500,
                                  color: settingsStore
                                      .isDarkTheme
                                      ? Color(0xffEBEBEB)
                                      : Color(
                                      0xff222222)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'The process will take a few minutes. please wait.',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.w400,
                                  color: settingsStore
                                      .isDarkTheme
                                      ? Color(0xffAFAFBE)
                                      : Color(
                                      0xff737373)),
                            ),
                          ],
                        ),
                      )
                    ]),
              ],
            )),
        //History Option Details
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 25, bottom: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Color(0xff32324A)
                  : Color(0xffFFFFFF),
              borderRadius:
              BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('You don’t have to wait here',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff222222))),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text:
                    'You can initiate a new transaction.You can always check the status of this transaction in transaction ',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373)),
                    children: [
                      TextSpan(
                          text: 'history',
                          style: TextStyle(
                              decoration: TextDecoration
                                  .underline,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: settingsStore
                                  .isDarkTheme
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff222222))),
                    ]),
              ),
            ],
          ),
        ),
        //Transaction Preview
        Container(
          margin: EdgeInsets.only(
              left: 10.0, bottom: 10.0, top: 5.0),
          child: Text(
            'Transaction Preview',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        Table(
          border: TableBorder(
            top: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            left: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            right: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            verticalInside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
          ),
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction ID',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    Text(
                      'bcbf9e4b0703d65',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You sent',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    Text(
                      '179 BDX',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exchange Rate',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    Text(
                      '1 BDX ~ 0.02812216 BNB',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Changelly address (BDX)',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    Text(
                      '79bf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a179bf9e4b0703d65223af71f3318711d1bc5462588c901c',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipient address (BNB)',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    Text(
                      'bnbf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Memo',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    Text(
                      '400016891',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
        Table(
          border: TableBorder.symmetric(
            outside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
            inside: BorderSide(
                width: 1,
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
                style: BorderStyle.solid),
          ),
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    Text(
                      'You Get',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '~ 0.02812216 BNB',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget transactionHistoryScreen(double _screenWidth,double _screenHeight,SettingsStore settingsStore, SwapPageChangeNotifier swapPageChangeNotifier){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Transaction History Back Title
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    swapPageChangeNotifier.setTransactionHistoryScreenVisibleStatus(false);
                  },
                  child: SvgPicture.asset(
                    'assets/images/swap/swap_back.svg',
                    color: settingsStore.isDarkTheme
                        ? Color(0xffffffff)
                        : Color(0xff16161D),
                    width: 20,
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Back',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff060606)),
                ),
              ],
            ),
            SvgPicture.asset(
              'assets/images/swap/swap_download.svg',
              color: settingsStore.isDarkTheme
                  ? Color(0xffffffff)
                  : Color(0xff16161D),
              width: 25,
              height: 25,
            )
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: _screenWidth,
          height:_screenHeight,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              key: _listKey,
              padding: EdgeInsets.only(bottom: 15),
              itemCount: 4,
              itemBuilder: (context, index) {
                return transactionRow(settingsStore);
              }),
        ),
      ],
    );
  }

}
class Coins {
  Coins(this.id, this.name);

  String id;
  String name;
}
/*
 Container(
                      child: currentStep <= stepLength
                          ? Text(
                        "Step $currentStep",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                        ),
                      )
                          : Text(
                        "Completed!",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RaisedButton(
                            disabledColor: Colors.grey[50],
                            onPressed: currentStep == 1
                                ? null
                                : () {
                              back();
                            },
                            child: Text('Back'),
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              next();
                            },
                            child: Text(
                              currentStep == stepLength ? 'Finish' : 'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
 */
