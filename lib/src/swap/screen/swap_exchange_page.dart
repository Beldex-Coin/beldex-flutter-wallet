import 'dart:async';
import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/provider/get_exchange_amount_provider.dart';
import 'package:beldex_wallet/src/swap/provider/get_pairs_params_provider.dart';
import 'package:beldex_wallet/src/swap/model/get_currencies_full_model.dart';
import 'package:beldex_wallet/src/swap/util/circular_progress_bar.dart';
import 'package:beldex_wallet/src/swap/util/swap_page_change_notifier.dart';
import 'package:beldex_wallet/src/util/network_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import '../../../routes.dart';
import '../../util/constants.dart';
import '../provider/get_currencies_full_provider.dart';
import '../util/data_class.dart';
import '../../widgets/no_internet.dart';
import '../util/utils.dart';
import 'number_stepper.dart';

class SwapExchangePage extends BasePage {
  SwapExchangePage({required this.walletAddress});
  final String walletAddress;
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
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
  }

  @override
  Widget body(BuildContext context) {
    return SwapExchangeHome(walletAddress: walletAddress);
  }
}

class SwapExchangeHome extends StatefulWidget {
  SwapExchangeHome({required this.walletAddress});

  final String walletAddress;

  @override
  State<SwapExchangeHome> createState() => _SwapExchangeHomeState();
}

class _SwapExchangeHomeState extends State<SwapExchangeHome> {
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

  final _sendAmountController = TextEditingController(text: '0.1');
  final _getAmountController = TextEditingController(text: '0.0');
  var showPrefixIcon = false;
  var showMemo = false;
  var acceptTermsAndConditions = false;
  final _listKey = GlobalKey();

  TextEditingController searchYouGetCoinsController = TextEditingController();
  TextEditingController searchYouSendCoinsController = TextEditingController();
  StateSetter? _searchYouGetCoinsSetState;
  StateSetter? _searchYouSendCoinsSetState;
  String? youGetCoinsFilter;
  String? youSendCoinsFilter;
  late GetCurrenciesFullProvider getCurrenciesFullProvider;
  late GetPairsParamsProvider getPairsParamsProvider;
  late GetExchangeAmountProvider getExchangeAmountProvider;
  late NetworkProvider networkProvider;
  Timer? timer;
  late List<String> stored = [];
  bool _isInitialized = false;
  final _focusSendCoin = FocusNode();
  final _focusGetCoin = FocusNode();
  late KeyboardDetectionController keyboardDetectionController;
  String _walletAddress = "";

  @override
  void initState() {
    _walletAddress = widget.walletAddress;
    getTransactionIds(swapTransactionHistoryFileName, _walletAddress).then((List<String> ids) {
      stored = ids;
    });
    searchYouGetCoinsController.addListener(() {
      _searchYouGetCoinsSetState!(() {
        youGetCoinsFilter = searchYouGetCoinsController.text;
      });
    });
    searchYouSendCoinsController.addListener(() {
      _searchYouSendCoinsSetState!(() {
        youSendCoinsFilter = searchYouSendCoinsController.text;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<GetExchangeAmountProvider>(context, listen: false);
      if (!mounted) return;
      Provider.of<GetCurrenciesFullProvider>(context, listen: false).getCurrenciesFullData(context);
      Provider.of<GetPairsParamsProvider>(context, listen: false).getPairsParamsData(context,[{'from':'btc','to':'bdx'},{'from':'bdx','to':'btc'}]);
      provider.getExchangeAmountData({'from':'btc',"to":'bdx',"amountFrom":_sendAmountController.text.toString()});
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        if (!mounted && !networkProvider.isConnected) return;
        provider.getExchangeAmountData({"from": getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase(), "to": getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase(), "amountFrom": getPairsParamsProvider.getSendAmountValue().toString()});
      });
    });
    keyboardDetectionController = KeyboardDetectionController(
      onChanged: (value) {
        if(value == KeyboardState.hidden){
          _focusSendCoin.unfocus();
          _focusGetCoin.unfocus();
        }
      },
    );
    super.initState();
  }

  void callGetExchangeAmountData(BuildContext context, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider, NetworkProvider networkProvider){
    if(getExchangeAmountProvider.loading==false){
      getExchangeAmountProvider.getExchangeAmountData({"from":getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase(),"to":getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase(),"amountFrom":getPairsParamsProvider.getSendAmountValue().toString()});
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        if (!mounted && !networkProvider.isConnected) return;
        getExchangeAmountProvider.getExchangeAmountData({"from":getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase(),"to":getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase(),"amountFrom":getPairsParamsProvider.getSendAmountValue().toString()});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    final swapExchangePageChangeNotifier = Provider.of<SwapExchangePageChangeNotifier>(context);
    return  KeyboardDetection(
      controller: keyboardDetectionController,
      child: GestureDetector(
        onTap: () {
          _focusSendCoin.unfocus();
          _focusGetCoin.unfocus();
        },
        child: Consumer<NetworkProvider>(builder: (context,networkProvider,child){
          return Consumer<GetCurrenciesFullProvider>(builder: (context,getCurrenciesFullProvider,child){
            if(getCurrenciesFullProvider.loading){
              return Center(
                  child: circularProgressBar(Color(0xff0BA70F), 4.0));
            }

            if(getCurrenciesFullProvider.error != null || !networkProvider.isConnected) {
              return noInternet(settingsStore, _screenWidth);
            }

            if(getCurrenciesFullProvider.data != null){
              return Consumer<GetPairsParamsProvider>(builder: (context,getPairsParamsProvider,child){
                if(getPairsParamsProvider.loading){
                  return defaultBody(_screenWidth, _screenHeight, settingsStore);
                }
                return Consumer<GetExchangeAmountProvider>(builder: (context,getExchangeAmountProvider,child){
                  if(getPairsParamsProvider.error != null || getExchangeAmountProvider.error != null || !networkProvider.isConnected) {
                    return noInternet(settingsStore, _screenWidth);
                  }

                  if(getPairsParamsProvider.data != null || getExchangeAmountProvider.data != null) {
                    this.networkProvider = networkProvider;
                    this.getCurrenciesFullProvider = getCurrenciesFullProvider;
                    this.getPairsParamsProvider = getPairsParamsProvider;
                    this.getExchangeAmountProvider = getExchangeAmountProvider;
                    _isInitialized = true;
                    return body(
                        _screenWidth,
                        _screenHeight,
                        settingsStore,
                        _scrollController,
                        swapExchangePageChangeNotifier,
                        getCurrenciesFullProvider.data,
                        getCurrenciesFullProvider,
                        getPairsParamsProvider,
                        getExchangeAmountProvider, networkProvider) ;
                  }

                  return SizedBox();
                });
              });
            }

            return SizedBox();
          });
        }
        ),
      ),
    );
  }

  @override
  void dispose() {
    if(_isInitialized) {
      getCurrenciesFullProvider.dispose();
      getPairsParamsProvider.dispose();
      getExchangeAmountProvider.dispose();
    }
    timer?.cancel();
    _focusSendCoin.dispose();
    _focusGetCoin.dispose();
    super.dispose();
  }

  Widget body(double _screenWidth, double _screenHeight, SettingsStore settingsStore, ScrollController _scrollController, SwapExchangePageChangeNotifier swapExchangePageChangeNotifier, GetCurrenciesFullModel? getCurrenciesFullData, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider, NetworkProvider networkProvider){
    //GetCurrenciesFull
    final List<GetCurrenciesResult> enableFrom = [];
    final List<GetCurrenciesResult> enableTo = [];
    for (int i = 0; i < getCurrenciesFullData!.result!.length; i++) {
      if (getCurrenciesFullData.result![i].enabledFrom == true) {
        enableFrom.add(getCurrenciesFullData.result![i]);
      }
      if (getCurrenciesFullData.result![i].enabledTo == true) {
        enableTo.add(getCurrenciesFullData.result![i]);
      }
      if (getCurrenciesFullData.result![i].name == "BDX") {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          getCurrenciesFullProvider.setBdxIsEnabled(getCurrenciesFullData.result![i].enabled);
        });
      }
      //Swap icon function
      if(getCurrenciesFullData.result![i].name == getCurrenciesFullProvider.getSelectedYouSendCoins().name && getCurrenciesFullData.result![i].enabledTo == true){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          getPairsParamsProvider.setSendCoinAvailableOnGetCoinStatus(true);
        });
      }

      if(getCurrenciesFullData.result![i].name == getCurrenciesFullProvider.getSelectedYouGetCoins().name && getCurrenciesFullData.result![i].enabledFrom == true){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          getPairsParamsProvider.setGetCoinAvailableOnSendCoinStatus(true);
        });
      }
    }

    //GetPairsParams
    if(getPairsParamsProvider.loading == false) {
      for (int i = 0; i < getPairsParamsProvider.data!.result!.length; i++) {
        if (getPairsParamsProvider.data!.result?[i].from == getCurrenciesFullProvider.getSelectedYouSendCoins().name?.toLowerCase() && getPairsParamsProvider.data!.result?[i].to == getCurrenciesFullProvider.getSelectedYouGetCoins().name?.toLowerCase()) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            getPairsParamsProvider
                .setSendValueMinimumAmountAndSendValueMaximumAmount(
                double.parse(
                    getPairsParamsProvider.data!.result![i].minAmountFloat!),
                double.parse(
                    getPairsParamsProvider.data!.result![i].maxAmountFloat!));
          });
        }
      }
    }

    //GetExchangeAmount
    if(getExchangeAmountProvider.loading == false){
      if(getExchangeAmountProvider.data!.result!.isNotEmpty) {
        _getAmountController.text = toStringAsFixed(getExchangeAmountProvider.data!.result![0].amountTo.toString());
      }
    }
    return getCurrenciesFullProvider.getBdxIsEnabled == null ? Container() : getCurrenciesFullProvider.getBdxIsEnabled == true ? Column(
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
                            //Exchange Screen
                            exchangeScreen(
                            _scrollController,
                            settingsStore,
                            swapExchangePageChangeNotifier,
                            enableFrom,enableTo,getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider, networkProvider),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          }),
        ),
      ],
    ): underMaintenance(settingsStore, _screenWidth);
  }

  Widget defaultBody(double _screenWidth, double _screenHeight, SettingsStore settingsStore){
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
            return Stack(
              children: [
                SingleChildScrollView(
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
                                //Exchange Screen
                                defaultExchangeScreen(settingsStore),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Card(
                          margin: EdgeInsets.only(
                              top: 15, left: 10, right: 10, bottom: 15),
                          elevation: 0,
                          color: settingsStore.isDarkTheme
                              ? Color(0xFF24242F).withOpacity(0.7)
                              : Color(0xfff3f3f3).withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: _screenWidth,
                            height: double.infinity,
                            child: SizedBox(
                              height: 70,
                              child: Center(
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: settingsStore.isDarkTheme ? Color(0xff30303F) : Color(0xfff3f3f3)
                                    ),
                                    child: circularProgressBar(Color(0xff0BA70F), 4.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget underMaintenance(SettingsStore settingsStore, double _screenWidth) {
    return Card(
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
        child: underMaintenanceScreen(_screenWidth, settingsStore),
      ),
    );
  }

  InkWell youGetCoinsDropDownListItem(
      SettingsStore settingsStore, GetCurrenciesResult enableTo, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider, NetworkProvider networkProvider) {
    return InkWell(
      onTap: networkProvider.isConnected ? () {
        searchYouGetCoinsController.text = '';
        final currentSelectedSendCoin = getCurrenciesFullProvider.getSelectedYouSendCoins();
        if (enableTo.fullName != null) {
          getCurrenciesFullProvider.setGetCoinsDropDownVisible(!getCurrenciesFullProvider.getGetCoinsDropDownVisible());
          if(currentSelectedSendCoin.name!.toLowerCase() == enableTo.name!.toLowerCase()) {
            getPairsParamsProvider.setSendAmountValue(0.0);
            if(currentSelectedSendCoin.name!.toLowerCase() == "bdx" && enableTo.name!.toLowerCase() == "bdx") {
              getCurrenciesFullProvider.setSelectedYouSendCoins(btcCoin);
            } else if (currentSelectedSendCoin.name!.toLowerCase() == "btc" && enableTo.name!.toLowerCase() == "btc") {
              getCurrenciesFullProvider.setSelectedYouSendCoins(bdxCoin);
            } else {
              getCurrenciesFullProvider.setSelectedYouSendCoins(btcCoin);
            }
            getCurrenciesFullProvider.setSelectedYouGetCoins(currentSelectedSendCoin);
          } else {
            getCurrenciesFullProvider.setSelectedYouGetCoins(Coins(enableTo.name, enableTo.fullName, enableTo.extraIdName, enableTo.blockchain, enableTo.protocol));
          }
          getPairsParamsProvider.getPairsParamsData(context,[{'from':getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase()},{'from':getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase()}]);
          //Get Exchange Amount API Call
          callGetExchangeAmountApi(getCurrenciesFullProvider, getPairsParamsProvider,getExchangeAmountProvider,networkProvider);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            getCurrenciesFullProvider.setGetCoinsDropDownVisible(
                !getCurrenciesFullProvider.getGetCoinsDropDownVisible());
          });
        }
      } : null,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: enableTo.image!,
                    placeholder: (context, url) => circularProgressBar(settingsStore.isDarkTheme
                        ? Color(0xff737373)
                        : Color(0xffA9A9CD), 1.0),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff737373)
                        : Color(0xffA9A9CD),
                    width: 15,
                    height: 15,
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    flex: 1,
                    child: RichText(
                      text: TextSpan(
                          text: enableTo.name,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 12,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffffffff)
                                  : Color(0xff222222),
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: ' - ${enableTo.fullName}',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    color: Color(0xff77778B),
                                    fontWeight: FontWeight.w400)),
                            WidgetSpan(
                              child: SizedBox(width: 3),
                            ),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.only(left:2, right: 2),
                                decoration: BoxDecoration(
                                  color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                    '${enableTo.protocol}',
                                    style: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        fontSize: 12,
                                        color: Color(0xff77778B),
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  InkWell youSendCoinsDropDownListItem(
      SettingsStore settingsStore, GetCurrenciesResult enableFrom, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider, NetworkProvider networkProvider) {
    if(getCurrenciesFullProvider.getGetCoinsDropDownVisible()) {
      getCurrenciesFullProvider.setGetCoinsDropDownVisible(false);
    }
    return InkWell(
      onTap: networkProvider.isConnected ? () {
        searchYouSendCoinsController.text = '';
        final currentSelectedGetCoin = getCurrenciesFullProvider.getSelectedYouGetCoins();
        if (enableFrom.name != null) {
          getCurrenciesFullProvider.setSendCoinsDropDownVisible(!getCurrenciesFullProvider.getSendCoinsDropDownVisible());
          if(currentSelectedGetCoin.name!.toLowerCase() == enableFrom.name!.toLowerCase()) {
              getPairsParamsProvider.setSendAmountValue(0.0);
              getCurrenciesFullProvider.setSelectedYouSendCoins(currentSelectedGetCoin);
              if(currentSelectedGetCoin.name!.toLowerCase() == "bdx" && enableFrom.name!.toLowerCase() == "bdx") {
                getCurrenciesFullProvider.setSelectedYouGetCoins(btcCoin);
              } else if (currentSelectedGetCoin.name!.toLowerCase() == "btc" && enableFrom.name!.toLowerCase() == "btc") {
                getCurrenciesFullProvider.setSelectedYouGetCoins(bdxCoin);
              } else {
                getCurrenciesFullProvider.setSelectedYouGetCoins(btcCoin);
              }
          } else {
            getCurrenciesFullProvider.setSelectedYouSendCoins(Coins(enableFrom.name, enableFrom.fullName, enableFrom.extraIdName, enableFrom.blockchain, enableFrom.protocol));
          }
          getPairsParamsProvider.getPairsParamsData(context, [{'from': getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase(), 'to': getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase()}, {'from': getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase(), 'to': getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase()}]);
          //Get Exchange Amount API Call
          callGetExchangeAmountApi(getCurrenciesFullProvider, getPairsParamsProvider, getExchangeAmountProvider,networkProvider);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            getCurrenciesFullProvider.setSendCoinsDropDownVisible(
                !getCurrenciesFullProvider.getSendCoinsDropDownVisible());
          });
        }
      } : null,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: enableFrom.image!,
                    placeholder: (context, url) => circularProgressBar(settingsStore.isDarkTheme
                        ? Color(0xff737373)
                        : Color(0xffA9A9CD), 1.0),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff737373)
                        : Color(0xffA9A9CD),
                    width: 15,
                    height: 15,
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    flex: 1,
                    child: RichText(
                      text: TextSpan(
                          text: enableFrom.name,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 12,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffffffff)
                                  : Color(0xff222222),
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: ' - ${enableFrom.fullName}',
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontSize: 12,
                                    color: Color(0xff77778B),
                                    fontWeight: FontWeight.w400)),
                            WidgetSpan(
                              child: SizedBox(width: 3),
                            ),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.only(left:2, right: 2),
                                decoration: BoxDecoration(
                                  color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                    '${enableFrom.protocol}',
                                    style: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        fontSize: 12,
                                        color: Color(0xff77778B),
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget underMaintenanceScreen(
      double _screenWidth, SettingsStore settingsStore) {
    return Container(
      width: _screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/swap/under_maintenance.svg',
            colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                ? Color(0xff65656E)
                : Color(0xffDADADA), BlendMode.srcIn),
            width: 112,
            height: 112,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'BDX',
                style: TextStyle(
                    backgroundColor: Colors.transparent,
                    color: Color(0xff20D030),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                      text: ' Swap is not available\nat the moment',
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)))
                ]),
          ),
          Text('Please try again after some times.',
              style: TextStyle(
                  backgroundColor: Colors.transparent,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff82828D)
                      : Color(0xff737373),
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget exchangeScreen(
      ScrollController _scrollController,
      SettingsStore settingsStore,
      SwapExchangePageChangeNotifier swapExchangePageChangeNotifier, List<GetCurrenciesResult> enableFrom,List<GetCurrenciesResult> enableTo, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider, NetworkProvider networkProvider) {
    final sendCoinAmount = getPairsParamsProvider.getSendAmountValue();
    if(getPairsParamsProvider.getSendFieldErrorState()){
      _getAmountController.text = toStringAsFixed(getPairsParamsProvider.getGetAmountValue().toString());
    }
    var floatingExchangeRate = '...';
    if(getExchangeAmountProvider.loading==false){
       if(getExchangeAmountProvider.data!.result != null && getExchangeAmountProvider.data!.result!.isNotEmpty) {
         floatingExchangeRate = '${getExchangeAmountProvider.data!.result![0].rate}';
       }else{
         floatingExchangeRate = '...';
       }
    }
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Exchange Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exchange',
                  style: TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff060606)),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pushNamed(Routes.swapTransactionList, arguments: SwapTransactionHistory(stored));
                  },
                  child: SvgPicture.asset(
                    'assets/images/swap/history.svg',
                    colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                        ? Color(0xffffffff)
                        : Color(0xff16161D), BlendMode.srcIn),
                    width: 25,
                    height: 25,
                  ),
                )
              ],
            ),
            //You send title
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, bottom: 10),
              child: Text(
                'You send',
                textAlign: TextAlign.start,
                style: TextStyle(
                    backgroundColor: Colors.transparent,
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
              padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: settingsStore.isDarkTheme
                    ? Color(0xff24242f)
                    : Color(0xfff3f3f3),
                border: Border.all(
                  color: getPairsParamsProvider.getSendFieldErrorState()?Colors.red:Color(0xff333343),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      focusNode: _focusSendCoin,
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color),
                      controller: _sendAmountController,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final regEx = RegExp(r'^\d*\.?\d*');
                          final newString =
                              regEx.stringMatch(newValue.text) ?? '';
                          return newString == newValue.text
                              ? newValue
                              : oldValue;
                        }),
                        FilteringTextInputFormatter.deny(RegExp('[-, ]'))
                      ],
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.6)),
                        hintText: tr(context).enterAmount,
                        errorStyle: TextStyle(color: BeldexPalette.red),
                      ),
                      onChanged: (value) {
                        if(value.isNotEmpty && networkProvider.isConnected){
                          final sendAmount = double.parse(value);
                          if(sendAmount > 0.0) {
                            WidgetsBinding.instance.addPostFrameCallback((
                                timeStamp) {
                              getPairsParamsProvider.setSendAmountValue(
                                  sendAmount);
                              //Get Exchange Amount API Call
                              Future.delayed(const Duration(seconds: 2), () {
                                callGetExchangeAmountApi(
                                    getCurrenciesFullProvider,
                                    getPairsParamsProvider,
                                    getExchangeAmountProvider, networkProvider);
                              });
                            });
                          }
                        }else{
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            getPairsParamsProvider.setSendAmountValue(0.0);
                          });
                        }
                      },
                      onFieldSubmitted: (value){
                        if(value.isNotEmpty && networkProvider.isConnected){
                          final sendAmount = double.parse(value);
                          if(sendAmount > 0.0) {
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              getPairsParamsProvider.setSendAmountValue(sendAmount);
                              //Get Exchange Amount API Call
                              callGetExchangeAmountApi(getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider,networkProvider);
                            });
                          }
                        }else{
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              getPairsParamsProvider.setSendAmountValue(0.0);
                            });
                        }
                      },
                      validator: (value){
                        if(value!.isNotEmpty){
                          if(validateMinimumAmount(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider) || validateMaximumAmount(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider)){
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                getPairsParamsProvider.setSendFieldErrorState(true);
                                getPairsParamsProvider.setGetAmountValue(0.0);
                              });
                            return;
                          }else{
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                getPairsParamsProvider.setSendFieldErrorState(false);
                              });
                            return null;
                          }
                        }else{
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                getPairsParamsProvider.setSendFieldErrorState(true);
                                getPairsParamsProvider.setGetAmountValue(0.0);
                              });
                          return;
                        }
                      },
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          getCurrenciesFullProvider.setSendCoinsDropDownVisible(!getCurrenciesFullProvider.getSendCoinsDropDownVisible());
                        });
                      },
                      child: Container(
                        width: 125.0,
                        margin: EdgeInsets.only(left: 3),
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                        decoration: BoxDecoration(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff333343)
                                : Color(0xffEBEBEB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: getCurrenciesFullProvider.getSelectedYouSendCoins().name,
                                    style: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                          text:
                                              ' - ${getCurrenciesFullProvider.getSelectedYouSendCoins().fullName}',
                                          style: TextStyle(
                                              backgroundColor:
                                                  Colors.transparent,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff77778B)))
                                    ]),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down,
                                size: 20,
                                color: settingsStore.isDarkTheme
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: validateMinimumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider) || validateMaximumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider),
                  child: Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xff00AD07).withAlpha(25),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: InkWell(
                        onTap: networkProvider.isConnected ? () {
                          if(validateMinimumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)){
                            _sendAmountController.text = minimumAmount(getPairsParamsProvider, getExchangeAmountProvider).toString();
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              getPairsParamsProvider.setSendAmountValue(minimumAmount(getPairsParamsProvider, getExchangeAmountProvider));
                              //Get Exchange Amount API Call
                              validateMinimumAndMaximumAmount(_sendAmountController.text,getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider,networkProvider);
                            });
                          }else if(validateMaximumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)){
                            _sendAmountController.text = maximumAmount(getPairsParamsProvider, getExchangeAmountProvider).toString();
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              getPairsParamsProvider.setSendAmountValue(maximumAmount(getPairsParamsProvider, getExchangeAmountProvider));
                              //Get Exchange Amount API Call
                              validateMinimumAndMaximumAmount(_sendAmountController.text,getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider,networkProvider);
                            });
                          }
                        } : null,
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: validateMinimumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)?'Minimum amount is ':validateMaximumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)?'Maximum amount is ':'',
                              style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff222222),
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                              children: [
                                TextSpan(
                                    text: validateMinimumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider) ?'${toStringAsFixed(minimumAmount(getPairsParamsProvider, getExchangeAmountProvider).toString())} ${getCurrenciesFullProvider.getSelectedYouSendCoins().name}':validateMaximumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)?'${toStringAsFixed(maximumAmount(getPairsParamsProvider, getExchangeAmountProvider).toString())} ${getCurrenciesFullProvider.getSelectedYouSendCoins().name}':'',
                                    style: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222)))
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Visibility(
                  visible: getPairsParamsProvider.getSendCoinAvailableOnGetCoinStatus() && getPairsParamsProvider.getGetCoinAvailableOnSendCoinStatus(),
                  child: InkWell(
                      onTap: networkProvider.isConnected ? () {
                        final currentSelectedSendCoin = getCurrenciesFullProvider.getSelectedYouSendCoins();
                        final currentSelectedGetCoin = getCurrenciesFullProvider.getSelectedYouGetCoins();
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          getPairsParamsProvider.setSendAmountValue(0.0);
                          getCurrenciesFullProvider.setSelectedYouSendCoins(
                              currentSelectedGetCoin);
                          getCurrenciesFullProvider.setSelectedYouGetCoins(
                              currentSelectedSendCoin);
                          getPairsParamsProvider.getPairsParamsData(context,[{'from':getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase()},{'from':getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase()}]);
                          //Get Exchange Amount API Call
                          callGetExchangeAmountApi(getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider,networkProvider);
                        });
                      } : null,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff333343)
                                : Color(0xffFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Transform.rotate(
                          angle: 90 * pi / 180,
                          child: SvgPicture.asset(
                            'assets/images/swap/swap.svg',
                            colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                                ? Color(0xffA9A9CD)
                                : Color(0xff222222), BlendMode.srcIn),
                            width: 20,
                            height: 20,
                          ),
                        ),
                      )),
                )
              ],
            ),
            //You get title
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: Text(
                'You get',
                textAlign: TextAlign.start,
                style: TextStyle(
                    backgroundColor: Colors.transparent,
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
              padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
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
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      focusNode: _focusGetCoin,
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color),
                      controller: _getAmountController,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final regEx = RegExp(r'^\d*\.?\d*');
                          final newString =
                              regEx.stringMatch(newValue.text) ?? '';
                          return newString == newValue.text
                              ? newValue
                              : oldValue;
                        }),
                        FilteringTextInputFormatter.deny(RegExp('[-, ]'))
                      ],
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.6)),
                        hintText: '...',
                        errorStyle: TextStyle(color: BeldexPalette.red),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          getCurrenciesFullProvider.setGetCoinsDropDownVisible(
                              !getCurrenciesFullProvider
                                  .getGetCoinsDropDownVisible());
                        });
                      },
                      child: Container(
                        width: 125.0,
                        margin: EdgeInsets.only(left: 3),
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                        decoration: BoxDecoration(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff333343)
                                : Color(0xffEBEBEB),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: getCurrenciesFullProvider.getSelectedYouGetCoins().name,
                                    style: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                          text:
                                              ' - ${getCurrenciesFullProvider.getSelectedYouGetCoins().fullName}',
                                          style: TextStyle(
                                              backgroundColor:
                                                  Colors.transparent,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff77778B)))
                                    ]),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down,
                                size: 20,
                                color: settingsStore.isDarkTheme
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                            ? Color(0xffA9A9CD)
                            : Color(0xff77778B), BlendMode.srcIn),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Floating Exchange Rate',
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff737373)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          floatingExchangeRate == "..." ? "1 ${getCurrenciesFullProvider.getSelectedYouSendCoins().name.toString().toUpperCase()} ~ $floatingExchangeRate" : "1 ${getCurrenciesFullProvider.getSelectedYouSendCoins().name.toString().toUpperCase()} ~ ${toStringAsFixed(floatingExchangeRate)} ${getCurrenciesFullProvider.getSelectedYouGetCoins().name.toString().toUpperCase()}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff060606)),
                        ),
                      ],
                    ),
                  ],
                )),
            //Fixed Exchange Rate Card
            /*Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                                ? Color(0xffA9A9CD)
                                : Color(0xff77778B), BlendMode.srcIn),
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
                )),*/
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
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
                  if(isNextButtonEnabled(floatingExchangeRate, !getPairsParamsProvider.getSendFieldErrorState(), sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)) {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pushNamed(Routes.swapWalletAddress,
                        arguments: ExchangeData(getCurrenciesFullProvider
                            .getSelectedYouSendCoins()
                            .name
                            ?.toLowerCase(), getCurrenciesFullProvider
                            .getSelectedYouGetCoins()
                            .name
                            ?.toLowerCase(),
                            _sendAmountController.text.toString(),
                            getCurrenciesFullProvider
                                .getSelectedYouGetCoins()
                                .extraIdName, getCurrenciesFullProvider
                                .getSelectedYouSendCoins()
                                .blockchain, getCurrenciesFullProvider
                                .getSelectedYouGetCoins()
                                .blockchain,getCurrenciesFullProvider
                                .getSelectedYouGetCoins().protocol));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isNextButtonEnabled(floatingExchangeRate, !getPairsParamsProvider.getSendFieldErrorState(), sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)
                      ? Color(0xff0BA70F)
                      : settingsStore.isDarkTheme
                          ? Color(0xff32324A)
                          : Color(0xffFFFFFF),
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Exchange',
                    style: TextStyle(
                        color: isNextButtonEnabled(floatingExchangeRate, !getPairsParamsProvider.getSendFieldErrorState(), sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)
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
          visible: getCurrenciesFullProvider.getGetCoinsDropDownVisible(),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            _searchYouGetCoinsSetState = setState;
            return Container(
              height: 200,
              margin: EdgeInsets.only(
                  top: 275, left: MediaQuery.of(context).size.width / 4),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff272733)
                      : Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(fontSize: 14),
                      controller: searchYouGetCoinsController,
                      decoration: InputDecoration(
                        fillColor: settingsStore.isDarkTheme
                            ? Color(0xff333343)
                            : Color(0xffF8F8F8),
                        hintText: 'Search Coins',
                        hintStyle: TextStyle(
                          color: Color(0xff77778B),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: youGetCoinsFilter == null ||
                                      youGetCoinsFilter!.isEmpty
                                  ? Colors.transparent
                                  : settingsStore.isDarkTheme
                                      ? Color(0xffffffff)
                                      : Color(0xff171720),
                            ),
                            onPressed: youGetCoinsFilter == null ||
                                    youGetCoinsFilter!.isEmpty
                                ? null
                                : () {
                                    searchYouGetCoinsController.clear();
                                  }),
                        contentPadding: EdgeInsets.only(
                            left: 10, top: 5, bottom: 5, right: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff484856)
                                    : Color(0xffDADADA))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff484856)
                                    : Color(0xffDADADA))),
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
                              thumbColor: settingsStore.isDarkTheme
                                  ? Color(0xff3A3A45)
                                  : Color(0xffC2C2C2),
                              radius: Radius.circular(10.0),
                              thumbVisibility: true,
                              child: ListView.builder(
                                  itemCount: enableTo.length,
                                  controller: _scrollController,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return youGetCoinsFilter == null ||
                                            youGetCoinsFilter == ''
                                        ? youGetCoinsDropDownListItem(
                                            settingsStore, enableTo[index],getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider,networkProvider)
                                        : '${enableTo[index].name}'.toLowerCase().contains(youGetCoinsFilter!.toLowerCase()) || '${enableTo[index].fullName}'.toLowerCase().contains(youGetCoinsFilter!.toLowerCase())
                                            ? youGetCoinsDropDownListItem(
                                                settingsStore, enableTo[index],getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider,networkProvider)
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
          visible: getCurrenciesFullProvider.getSendCoinsDropDownVisible(),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            _searchYouSendCoinsSetState = setState;
            return Container(
              height: 200,
              margin: EdgeInsets.only(
                  top: 130, left: MediaQuery.of(context).size.width / 4),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff272733)
                      : Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(fontSize: 14),
                      controller: searchYouSendCoinsController,
                      decoration: InputDecoration(
                        fillColor: settingsStore.isDarkTheme
                            ? Color(0xff333343)
                            : Color(0xffF8F8F8),
                        hintText: 'Search Coins',
                        hintStyle: TextStyle(
                          color: Color(0xff77778B),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: youSendCoinsFilter == null ||
                                      youSendCoinsFilter!.isEmpty
                                  ? Colors.transparent
                                  : settingsStore.isDarkTheme
                                      ? Color(0xffffffff)
                                      : Color(0xff171720),
                            ),
                            onPressed: youSendCoinsFilter == null ||
                                    youSendCoinsFilter!.isEmpty
                                ? null
                                : () {
                                    searchYouSendCoinsController.clear();
                                  }),
                        contentPadding: EdgeInsets.only(
                            left: 10, top: 5, bottom: 5, right: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff484856)
                                    : Color(0xffDADADA))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff484856)
                                    : Color(0xffDADADA))),
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
                              thumbColor: settingsStore.isDarkTheme
                                  ? Color(0xff3A3A45)
                                  : Color(0xffC2C2C2),
                              radius: Radius.circular(10.0),
                              thumbVisibility: true,
                              child: ListView.builder(
                                  itemCount: enableFrom.length,
                                  controller: _scrollController,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return youSendCoinsFilter == null ||
                                            youSendCoinsFilter == ''
                                        ? youSendCoinsDropDownListItem(
                                            settingsStore, enableFrom[index],getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider,networkProvider)
                                        : '${enableFrom[index].name}'.toLowerCase().contains(youSendCoinsFilter!.toLowerCase()) || '${enableFrom[index].fullName}'.toLowerCase().contains(youSendCoinsFilter!.toLowerCase())
                                            ? youSendCoinsDropDownListItem(
                                                settingsStore,
                                                enableFrom[index],getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider,networkProvider)
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

  Widget defaultExchangeScreen(SettingsStore settingsStore) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Exchange Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exchange',
                  style: TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff060606)),
                ),
                SvgPicture.asset(
                  'assets/images/swap/history.svg',
                  colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                      ? Color(0xffffffff)
                      : Color(0xff16161D), BlendMode.srcIn),
                  width: 25,
                  height: 25,
                )
              ],
            ),
            //You send title
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, bottom: 10),
              child: Text(
                'You send',
                textAlign: TextAlign.start,
                style: TextStyle(
                    backgroundColor: Colors.transparent,
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
              padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
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
                    flex: 1,
                    child: TextFormField(
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color),
                      controller: _sendAmountController,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final regEx = RegExp(r'^\d*\.?\d*');
                          final newString =
                              regEx.stringMatch(newValue.text) ?? '';
                          return newString == newValue.text
                              ? newValue
                              : oldValue;
                        }),
                        FilteringTextInputFormatter.deny(RegExp('[-, ]'))
                      ],
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.6)),
                        hintText: tr(context).enterAmount,
                        errorStyle: TextStyle(color: BeldexPalette.red),
                      ),
                      onChanged: (value){
                      },
                    ),
                  ),
                  Container(
                    width: 125.0,
                    height: 40,
                    margin: EdgeInsets.only(left: 3),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff333343)
                            : Color(0xffEBEBEB),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: getCurrenciesFullProvider.getSelectedYouSendCoins().name,
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff222222),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                      text:
                                      ' - ${getCurrenciesFullProvider.getSelectedYouSendCoins().fullName}',
                                      style: TextStyle(
                                          backgroundColor:
                                          Colors.transparent,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff77778B)))
                                ]),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            size: 20,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff060606))
                      ],
                    ),
                  )
                ],
              ),
            ),
            //Swap coin button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                SizedBox(width: 5,),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff333343)
                          : Color(0xffFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Transform.rotate(
                    angle: 90 * pi / 180,
                    child: SvgPicture.asset(
                      'assets/images/swap/swap.svg',
                      colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                          ? Color(0xffA9A9CD)
                          : Color(0xff222222), BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              ],
            ),
            //You get title
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: Text(
                'You get',
                textAlign: TextAlign.start,
                style: TextStyle(
                    backgroundColor: Colors.transparent,
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
              padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
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
                    flex: 1,
                    child: TextFormField(
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color),
                      controller: _getAmountController,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final regEx = RegExp(r'^\d*\.?\d*');
                          final newString =
                              regEx.stringMatch(newValue.text) ?? '';
                          return newString == newValue.text
                              ? newValue
                              : oldValue;
                        }),
                        FilteringTextInputFormatter.deny(RegExp('[-, ]'))
                      ],
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.6)),
                        hintText: '...',
                        errorStyle: TextStyle(color: BeldexPalette.red),
                      ),
                    ),
                  ),
                  Container(
                    width: 125.0,
                    height: 40,
                    margin: EdgeInsets.only(left: 3),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff333343)
                            : Color(0xffEBEBEB),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: getCurrenciesFullProvider.getSelectedYouGetCoins().name,
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff222222),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                      text:
                                      ' - ${getCurrenciesFullProvider.getSelectedYouGetCoins().fullName}',
                                      style: TextStyle(
                                          backgroundColor:
                                          Colors.transparent,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff77778B)))
                                ]),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            size: 20,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff060606))
                      ],
                    ),
                  )
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                            ? Color(0xffA9A9CD)
                            : Color(0xff77778B), BlendMode.srcIn),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Floating Exchange Rate',
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff737373)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "...",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff060606)),
                        ),
                      ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: settingsStore.isDarkTheme
                      ? Color(0xff32324A)
                      : Color(0xffFFFFFF),
                  padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Exchange',
                    style: TextStyle(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff77778B)
                            : Color(0xffB1B1D1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ],
    );
  }

 /* void callGetExchangeAmountApi(String value, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider){
    if(validateMinimumAmountLessThanEqual(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider) && validateMaximumAmountGreaterThanEqual(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider)){
      callGetExchangeAmountData(context,{"from":getCurrenciesFullProvider.getSelectedYouSendCoins().name!.toLowerCase(),"to":getCurrenciesFullProvider.getSelectedYouGetCoins().name!.toLowerCase(),"amountFrom":getPairsParamsProvider.getSendAmountValue().toString()},getExchangeAmountProvider);
    }
  }*/

  void callGetExchangeAmountApi(GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider, NetworkProvider networkProvider){
    callGetExchangeAmountData(context, getCurrenciesFullProvider, getPairsParamsProvider, getExchangeAmountProvider, networkProvider);
  }

  void validateMinimumAndMaximumAmount(String value, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider, NetworkProvider networkProvider){
    if(validateMinimumAmountLessThanEqual(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider) || validateMaximumAmountGreaterThanEqual(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider)){
      callGetExchangeAmountData(context, getCurrenciesFullProvider, getPairsParamsProvider, getExchangeAmountProvider, networkProvider);
    }
  }

   bool validateMinimumAmount(double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data?.error != null && getExchangeAmountProvider.data?.error!.data != null) {
      return sendCoinAmount < double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.min!.from!);
    } else {
      return sendCoinAmount < getPairsParamsProvider.minimumAmount;
    }
  }

  bool validateMinimumAmountLessThanEqual(double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data?.error != null && getExchangeAmountProvider.data?.error!.data != null) {
      return sendCoinAmount <= double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.min!.from!);
    } else {
      return sendCoinAmount <= getPairsParamsProvider.minimumAmount;
    }
  }

  bool validateMaximumAmount(double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data?.error != null && getExchangeAmountProvider.data?.error!.data != null) {
      return sendCoinAmount > double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.max!.from!);
    } else {
      return sendCoinAmount > getPairsParamsProvider.maximumAmount;
    }
  }

  bool validateMaximumAmountGreaterThanEqual(double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data?.error != null && getExchangeAmountProvider.data?.error!.data != null) {
      return sendCoinAmount >= double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.max!.from!);
    } else {
      return sendCoinAmount >= getPairsParamsProvider.maximumAmount;
    }
  }

  double minimumAmount(GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data?.error != null && getExchangeAmountProvider.data?.error!.data != null) {
      return double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.min!.from!);
    } else {
      return getPairsParamsProvider.minimumAmount;
    }
  }

  double maximumAmount(GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data?.error != null && getExchangeAmountProvider.data?.error!.data != null) {
      return double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.max!.from!);
    } else {
      return getPairsParamsProvider.maximumAmount;
    }
  }

  bool isNextButtonEnabled(String status, bool sendFieldErrorState, double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    return (!validateMinimumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider) || !validateMaximumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)) && status != "..." && sendFieldErrorState;
  }
}

