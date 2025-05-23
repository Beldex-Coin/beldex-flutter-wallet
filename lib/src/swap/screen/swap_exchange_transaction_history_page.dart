import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:beldex_wallet/src/swap/provider/get_transactions_provider.dart';
import 'package:beldex_wallet/src/swap/screen/swap_exchange_page.dart';
import 'package:beldex_wallet/src/util/generate_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../routes.dart';
import 'number_stepper.dart';

class SwapExchangeTransactionHistoryPage extends BasePage {
  SwapExchangeTransactionHistoryPage({required this.swapTransactionHistory});

  final SwapTransactionHistory swapTransactionHistory;
  @override
  bool get isModalBackButton => false;

  @override
  String getTitle(AppLocalizations t) => 'Swap';

  @override
  Color get textColor => Colors.white;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    return SwapExchangeTransactionHistoryHome(swapTransactionHistory: swapTransactionHistory,);
  }
}

class SwapExchangeTransactionHistoryHome extends StatefulWidget {
  SwapExchangeTransactionHistoryHome({required this.swapTransactionHistory});

  final SwapTransactionHistory swapTransactionHistory;
  @override
  State<SwapExchangeTransactionHistoryHome> createState() => _SwapExchangeTransactionHistoryHomeState();
}

class _SwapExchangeTransactionHistoryHomeState extends State<SwapExchangeTransactionHistoryHome> {
  int currentStep = 1;
  int stepLength = 4;
  bool complete = false;

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

  final _listKey = GlobalKey();

  late GetTransactionsProvider getTransactionsProvider;
  Timer? timer;
  late SwapTransactionHistory _swapTransactionHistory;

  @override
  void initState() {
    _swapTransactionHistory = widget.swapTransactionHistory;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetTransactionsProvider>(context,listen: false).getTransactionsListData(context,{"id":_swapTransactionHistory.transactionIdList});
      timer?.cancel();
      /*timer = Timer.periodic(Duration(seconds: 30), (timer) {
        Provider.of<GetTransactionsProvider>(context,listen: false).getTransactionsListData(context,{"id":_swapTransactionHistory.transactionIdList});
      });*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<GetTransactionsProvider>(builder: (context,getTransactionsProvider,child){
        if(getTransactionsProvider.loading){
          return Center(
              child: Container(
                  child: const CircularProgressIndicator(valueColor:
                  AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),
                  )));
        }else {
          this.getTransactionsProvider = getTransactionsProvider;
          return body(_screenWidth,_screenHeight,settingsStore,_scrollController, getTransactionsProvider.data!);
        }
      }),
    );
  }

  @override
  void dispose() {
    getTransactionsProvider.dispose();
    timer?.cancel();
    super.dispose();
  }

  Widget body(double _screenWidth, double _screenHeight, SettingsStore settingsStore, ScrollController _scrollController, GetTransactionsModel getTransactionsModel){
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
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Card(
                      margin: EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 15),
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
                            //Transaction History Screen
                            transactionHistoryScreen(
                                _screenWidth,
                                _screenHeight,
                                settingsStore,
                                getTransactionsModel),
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

  Widget transactionRow(SettingsStore settingsStore, GetTransactionsModel getTransactionsModel, int index) {
    final result = getTransactionsModel.result![index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: settingsStore.isDarkTheme
                    ? Colors.white
                    : Colors.black, // Your accent color
              ),
              dividerColor: Colors.transparent,
              textSelectionTheme:
              TextSelectionThemeData(selectionColor: Colors.green)),
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: ExpansionTile(
                tilePadding: EdgeInsets.only(left: 0, right: 0),
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Visibility(
                        visible: result.status == "waiting",
                        child:showImage('assets/images/swap/swap_waiting.svg'),
                      ),
                      Visibility(
                        visible: result.status == "confirming",
                        child:showImage('assets/images/swap/swap_pending.svg'),
                      ),
                      Visibility(
                        visible: result.status == "finished",
                        child:showImage('assets/images/swap/swap_completed.svg'),
                      ),
                      Visibility(
                        visible: result.status == "refunded",
                        child:showImage('assets/images/swap/swap_refund.svg'),
                      ),
                      Visibility(
                        visible: result.status == "overdue",
                        child:showImage('assets/images/swap/swap_waiting.svg'),
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: false
                                ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Text('Exchange Amount',
                                      style: TextStyle(
                                          backgroundColor: Colors.transparent,
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
                                          backgroundColor: Colors.transparent,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xffFFFFFF)
                                              : Color(0xff222222))),
                                ),
                              ],
                            )
                                : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('${toStringAsFixed(result.amountExpectedTo)} ${result.currencyTo!.toUpperCase()}',
                                          style: TextStyle(
                                              backgroundColor:
                                              Colors.transparent,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 14,
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffFFFFFF)
                                                  : Color(0xff222222))),
                                      Text(getDate(1747897806),
                                          style: TextStyle(
                                              backgroundColor:
                                              Colors.transparent,
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
                                      RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: 'Received ',
                                            style: TextStyle(
                                                backgroundColor:
                                                Colors.transparent,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: settingsStore
                                                    .isDarkTheme
                                                    ? Color(0xffAFAFBE)
                                                    : Color(0xff737373)),
                                            children: [
                                              TextSpan(
                                                  text: '~ ${toStringAsFixed(result.amountExpectedTo)} ${result.currencyFrom!.toUpperCase()}',
                                                  style: TextStyle(
                                                      backgroundColor:
                                                      Colors
                                                          .transparent,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: result.status == "finished"
                                                          ? Color(
                                                          0xff00AD07)
                                                          : Color(
                                                          0xff77778B)))
                                            ]),
                                      ),
                                      Text(
                                          result.status!.capitalized(),
                                          style: TextStyle(
                                              backgroundColor:
                                              Colors.transparent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: result.status == "finished"
                                                  ? Color(0xff20D030)
                                                  : settingsStore
                                                  .isDarkTheme
                                                  ? Color(0xffAFAFBE)
                                                  : Color(0xff737373)))
                                    ]),
                              ],
                            ),
                          )),
                    ]),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Exchange Rate',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373))),
                            Text('1 ${result.currencyFrom!.toUpperCase()} = ${toStringAsFixed(result.rate)}${result.currencyTo!.toUpperCase()}',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffD1D1D3)
                                        : Color(0xff737373))),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Receiver',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373))),
                            Text(truncateMiddle(result.payinAddress!),
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffD1D1D3)
                                        : Color(0xff737373))),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amount Received',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373))),
                            Text(result.status == "finished" ? '${result.amountExpectedTo} ${result.currencyTo!.toUpperCase()}' : '---',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: true
                                        ? Color(0xff20D030)
                                        : settingsStore.isDarkTheme
                                        ? Color(0xffD1D1D3)
                                        : Color(0xff737373))),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Date',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373))),
                            Text(getDateAndTime(1747897806),
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffD1D1D3)
                                        : Color(0xff737373))),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373))),
                            Text(result.status!.capitalized(),
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: result.status == "finished"
                                        ? Color(0xff20D030)
                                        : settingsStore.isDarkTheme
                                        ? Color(0xffD1D1D3)
                                        : Color(0xff737373))),
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

  Widget transactionHistoryScreen(
      double _screenWidth,
      double _screenHeight,
      SettingsStore settingsStore,
      GetTransactionsModel getTransactionsModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Transaction History Back Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context, rootNavigator: true).pushNamed(Routes.swapExchange);
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
          height: _screenHeight,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              key: _listKey,
              padding: EdgeInsets.only(bottom: 15),
              itemCount: getTransactionsModel.result!.length,
              itemBuilder: (context, index) {
                return transactionRow(settingsStore, getTransactionsModel, index);
              }),
        ),
      ],
    );
  }

  String getDate(int timeStamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('dd MMM yyyy').format(date);
  }

  String getDateAndTime(int timeStamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('dd MMM yyyy, HH:mm:ss').format(date);
  }

  String truncateMiddle(String input, {int start = 3, int end = 3}) {
    if (input.length <= start + end) return input;
    return '${input.substring(0, start)}...${input.substring(input.length - end)}';
  }

  Widget showImage(String imageUrl) {
    return SvgPicture.asset(
      imageUrl,
      width: 18,
      height: 18,
    );
  }

  String toStringAsFixed(String? amountExpectedTo) {
    final double d = double.parse(amountExpectedTo!);
    final String inString = d.toStringAsFixed(2);
    return inString;
  }

}

