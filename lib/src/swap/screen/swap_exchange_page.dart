import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/provider/get_exchange_amount_provider.dart';
import 'package:beldex_wallet/src/swap/provider/get_pairs_params_provider.dart';
import 'package:beldex_wallet/src/swap/model/get_currencies_full_model.dart';
import 'package:beldex_wallet/src/swap/util/swap_page_change_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import '../../../routes.dart';
import '../provider/get_currencies_full_provider.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import 'number_stepper.dart';

class SwapExchangePage extends BasePage {
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
    return SwapExchangeHome();
  }
}

class SwapExchangeHome extends StatefulWidget {
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
  final _getAmountController = TextEditingController(text: '0');
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
  Timer? timer;
  late FlutterSecureStorage secureStorage;
  late List<String> stored = [];

  @override
  void initState() {
    secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    getTransactionsIds(secureStorage, transactionIds: (ids) {
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
      Provider.of<GetCurrenciesFullProvider>(context, listen: false).getCurrenciesFullData(context);
      Provider.of<GetPairsParamsProvider>(context, listen: false).getPairsParamsData(context,[{'from':'btc','to':'bdx'},{'from':'bdx','to':'btc'}]);
      Provider.of<GetExchangeAmountProvider>(context,listen: false).getExchangeAmountData(context,{'from':'btc',"to":'bdx',"amountFrom":_sendAmountController.text.toString()});
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        Provider.of<GetExchangeAmountProvider>(context,listen: false).getExchangeAmountData(context,{"from":getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase(),"to":getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase(),"amountFrom":getPairsParamsProvider.getSendAmountValue().toString()});
      });
    });
    super.initState();
  }

  void callGetExchangeAmountData(BuildContext context, Map<String, String> params, GetExchangeAmountProvider getExchangeAmountProvider){
    if(getExchangeAmountProvider.loading==false){
      getExchangeAmountProvider.getExchangeAmountData(context, params);
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        getExchangeAmountProvider.getExchangeAmountData(context, params);
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<GetCurrenciesFullProvider>(builder: (context,getCurrenciesFullProvider,child){
        if(getCurrenciesFullProvider.loading){
          return Center(
          child: Container(
            child: const CircularProgressIndicator(valueColor:
              AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),
          )));
        }else {
          return Consumer<GetPairsParamsProvider>(builder: (context,getPairsParamsProvider,child){
            return Consumer<GetExchangeAmountProvider>(builder: (context,getExchangeAmountProvider,child){
              this.getCurrenciesFullProvider = getCurrenciesFullProvider;
              this.getPairsParamsProvider = getPairsParamsProvider;
              this.getExchangeAmountProvider = getExchangeAmountProvider;
              return body(_screenWidth,_screenHeight,settingsStore,_scrollController,swapExchangePageChangeNotifier,getCurrenciesFullProvider.data,getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider);
            });
          });
        }
      }),
    );
  }

  @override
  void dispose() {
    getCurrenciesFullProvider.dispose();
    getPairsParamsProvider.dispose();
    getExchangeAmountProvider.dispose();
    timer?.cancel();
    super.dispose();
  }

  Widget body(double _screenWidth, double _screenHeight, SettingsStore settingsStore, ScrollController _scrollController, SwapExchangePageChangeNotifier swapExchangePageChangeNotifier, GetCurrenciesFullModel? getCurrenciesFullData, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider){
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
      if (getCurrenciesFullData.result![i].name == "BDX" && getCurrenciesFullData.result![i].enabled == true) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          getCurrenciesFullProvider.setBdxIsEnabled(true);
        });
      }

      //Swap icon function
      if(getCurrenciesFullData.result![i].name == getCurrenciesFullProvider.getSelectedYouSendCoins().id && getCurrenciesFullData.result![i].enabledTo == true){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          getPairsParamsProvider.setSendCoinAvailableOnGetCoinStatus(true);
        });
      }

      if(getCurrenciesFullData.result![i].name == getCurrenciesFullProvider.getSelectedYouGetCoins().id && getCurrenciesFullData.result![i].enabledFrom == true){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          getPairsParamsProvider.setGetCoinAvailableOnSendCoinStatus(true);
        });
      }
    }

    //GetPairsParams
    if(getPairsParamsProvider.loading == false) {
      for (int i = 0; i < getPairsParamsProvider.data!.result!.length; i++) {
        if (getPairsParamsProvider.data!.result?[i].from == getCurrenciesFullProvider.getSelectedYouSendCoins().id?.toLowerCase() && getPairsParamsProvider.data!.result?[i].to == getCurrenciesFullProvider.getSelectedYouGetCoins().id?.toLowerCase()) {
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
        _getAmountController.text = getExchangeAmountProvider.data!.result![0].amountTo.toString();
      }
    }
    return getCurrenciesFullProvider.getBdxIsEnabled() ? Column(
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
                            enableFrom,enableTo,getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          }),
        ),
      ],
    ):Card(
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
      SettingsStore settingsStore, GetCurrenciesResult enableTo, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    return InkWell(
      onTap: () async {
        searchYouGetCoinsController.text = '';
        if (enableTo.fullName != null) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            getCurrenciesFullProvider.setSelectedYouGetCoins(
                Coins(enableTo.name, enableTo.fullName, enableTo.extraIdName, enableTo.blockchain, enableTo.protocol));
            getCurrenciesFullProvider.setGetCoinsDropDownVisible(
                !getCurrenciesFullProvider.getGetCoinsDropDownVisible());
            getPairsParamsProvider.getPairsParamsData(context,[{'from':getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase()},{'from':getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase()}]);
            //Get Exchange Amount API Call
            callGetExchangeAmountApi(_sendAmountController.text,getPairsParamsProvider,getExchangeAmountProvider);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            getCurrenciesFullProvider.setGetCoinsDropDownVisible(
                !getCurrenciesFullProvider.getGetCoinsDropDownVisible());
          });
        }
      },
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
                    placeholder: (context, url) => new CircularProgressIndicator(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff737373)
                          : Color(0xffA9A9CD),
                      strokeWidth: 1.0,
                    ),
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
      SettingsStore settingsStore, GetCurrenciesResult enableFrom, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    return InkWell(
      onTap: () async {
        searchYouSendCoinsController.text = '';
        if (enableFrom.name != null) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            getCurrenciesFullProvider.setSelectedYouSendCoins(
                Coins(enableFrom.name, enableFrom.fullName, enableFrom.extraIdName, enableFrom.blockchain, enableFrom.protocol));
            getCurrenciesFullProvider.setSendCoinsDropDownVisible(
                !getCurrenciesFullProvider.getSendCoinsDropDownVisible());
            getPairsParamsProvider.getPairsParamsData(context,[{'from':getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase()},{'from':getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase()}]);
            //Get Exchange Amount API Call
            callGetExchangeAmountApi(_sendAmountController.text,getPairsParamsProvider,getExchangeAmountProvider);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            getCurrenciesFullProvider.setSendCoinsDropDownVisible(
                !getCurrenciesFullProvider.getSendCoinsDropDownVisible());
          });
        }
      },
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
                    placeholder: (context, url) => new CircularProgressIndicator(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff737373)
                          : Color(0xffA9A9CD),
                      strokeWidth: 1.0,
                    ),
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
    Future.delayed(Duration(seconds: 2), () {
      return Expanded(
        child: Container(
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
                          text: ' Swap is temporarily\nunder maintenance.',
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
        ),
      );
    });
    return Container();
  }

  Widget exchangeScreen(
      ScrollController _scrollController,
      SettingsStore settingsStore,
      SwapExchangePageChangeNotifier swapExchangePageChangeNotifier, List<GetCurrenciesResult> enableFrom,List<GetCurrenciesResult> enableTo, GetCurrenciesFullProvider getCurrenciesFullProvider, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    final sendCoinAmount = getPairsParamsProvider.getSendAmountValue();
    if(getPairsParamsProvider.getSendFieldErrorState()){
      _getAmountController.text = getPairsParamsProvider.getGetAmountValue().toString();
    }
    var floatingExchangeRate = '...';
    if(getExchangeAmountProvider.loading==false){
       if(getExchangeAmountProvider.data!.result != null && getExchangeAmountProvider.data!.result!.isNotEmpty) {
         floatingExchangeRate = '~${getExchangeAmountProvider.data!.result![0].rate}';
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
                    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pushNamed(Routes.swapTransactionList, arguments: SwapTransactionHistory(stored, secureStorage));
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
                        if(value.isNotEmpty){
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                              getPairsParamsProvider.setSendAmountValue(double.parse(value));

                              //Get Exchange Amount API Call
                              callGetExchangeAmountApi(value,getPairsParamsProvider,getExchangeAmountProvider);
                            });
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
                                    text: getCurrenciesFullProvider.getSelectedYouSendCoins().id,
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
                                              ' - ${getCurrenciesFullProvider.getSelectedYouSendCoins().name}',
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
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xff00AD07).withAlpha(25),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: InkWell(
                      onTap: (){
                        if(validateMinimumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)){
                          _sendAmountController.text = minimumAmount(getPairsParamsProvider, getExchangeAmountProvider).toString();
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            getPairsParamsProvider.setSendAmountValue(minimumAmount(getPairsParamsProvider, getExchangeAmountProvider));
                            //Get Exchange Amount API Call
                            validateMinimumAndMaximumAmount(_sendAmountController.text,getPairsParamsProvider,getExchangeAmountProvider);
                          });
                        }else if(validateMaximumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)){
                          _sendAmountController.text = maximumAmount(getPairsParamsProvider, getExchangeAmountProvider).toString();
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            getPairsParamsProvider.setSendAmountValue(maximumAmount(getPairsParamsProvider, getExchangeAmountProvider));
                            //Get Exchange Amount API Call
                            validateMinimumAndMaximumAmount(_sendAmountController.text,getPairsParamsProvider,getExchangeAmountProvider);
                          });
                        }
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
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
                                  text: validateMinimumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)?'${minimumAmount(getPairsParamsProvider, getExchangeAmountProvider)} ${getCurrenciesFullProvider.getSelectedYouSendCoins().id}':validateMaximumAmount(sendCoinAmount, getPairsParamsProvider, getExchangeAmountProvider)?'${maximumAmount(getPairsParamsProvider, getExchangeAmountProvider)} ${getCurrenciesFullProvider.getSelectedYouSendCoins().id}':'',
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
                Visibility(
                  visible: getPairsParamsProvider.getSendCoinAvailableOnGetCoinStatus() && getPairsParamsProvider.getGetCoinAvailableOnSendCoinStatus(),
                  child: InkWell(
                      onTap: () {
                        final currentSelectedSendCoin = getCurrenciesFullProvider.getSelectedYouSendCoins();
                        final currentSelectedGetCoin = getCurrenciesFullProvider.getSelectedYouGetCoins();
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          getPairsParamsProvider.setSendAmountValue(0.0);
                          getCurrenciesFullProvider.setSelectedYouSendCoins(
                              currentSelectedGetCoin);
                          getCurrenciesFullProvider.setSelectedYouGetCoins(
                              currentSelectedSendCoin);
                          getPairsParamsProvider.getPairsParamsData(context,[{'from':getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase()},{'from':getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase(),'to':getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase()}]);
                          //Get Exchange Amount API Call
                          callGetExchangeAmountApi(_sendAmountController.text,getPairsParamsProvider,getExchangeAmountProvider);
                        });
                      },
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
                                    text: getCurrenciesFullProvider.getSelectedYouGetCoins().id,
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
                                              ' - ${getCurrenciesFullProvider.getSelectedYouGetCoins().name}',
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
                        Text(
                          'Floating Exchange Rate',
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
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
                        floatingExchangeRate,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            backgroundColor: Colors.transparent,
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
                  if(isNextButtonEnabled(floatingExchangeRate) && !getPairsParamsProvider.getSendFieldErrorState()) {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pushNamed(Routes.swapWalletAddress,
                        arguments: ExchangeData(getCurrenciesFullProvider
                            .getSelectedYouSendCoins()
                            .id
                            ?.toLowerCase(), getCurrenciesFullProvider
                            .getSelectedYouGetCoins()
                            .id
                            ?.toLowerCase(),
                            _sendAmountController.text.toString(),
                            getCurrenciesFullProvider
                                .getSelectedYouGetCoins()
                                .extraIdName, getCurrenciesFullProvider
                                .getSelectedYouSendCoins()
                                .bitcoin, getCurrenciesFullProvider
                                .getSelectedYouGetCoins()
                                .bitcoin,getCurrenciesFullProvider
                                .getSelectedYouGetCoins().protocol));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isNextButtonEnabled(floatingExchangeRate) && !getPairsParamsProvider.getSendFieldErrorState()
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
                        color: isNextButtonEnabled(floatingExchangeRate) && !getPairsParamsProvider.getSendFieldErrorState()
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
                                            settingsStore, enableTo[index],getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider)
                                        : '${enableTo[index].fullName}'
                                                .toLowerCase()
                                                .contains(youGetCoinsFilter!
                                                    .toLowerCase()) || '${enableTo[index].name}'
                                        .toLowerCase()
                                        .contains(youGetCoinsFilter!
                                        .toLowerCase())
                                            ? youGetCoinsDropDownListItem(
                                                settingsStore, enableTo[index],getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider)
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
                                            settingsStore, enableFrom[index],getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider)
                                        : '${enableFrom[index].fullName}'
                                                .toLowerCase()
                                                .contains(youSendCoinsFilter!
                                                    .toLowerCase()) || '${enableFrom[index].name}'
                                        .toLowerCase()
                                        .contains(youSendCoinsFilter!
                                        .toLowerCase())
                                            ? youSendCoinsDropDownListItem(
                                                settingsStore,
                                                enableFrom[index],getCurrenciesFullProvider,getPairsParamsProvider,getExchangeAmountProvider)
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

  void callGetExchangeAmountApi(String value, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider){
    if(validateMinimumAmountLessThanEqual(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider) && validateMaximumAmountGreaterThanEqual(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider)){
      callGetExchangeAmountData(context,{"from":getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase(),"to":getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase(),"amountFrom":getPairsParamsProvider.getSendAmountValue().toString()},getExchangeAmountProvider);
    }
  }

  void validateMinimumAndMaximumAmount(String value, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider){
    if(validateMinimumAmountLessThanEqual(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider) || validateMaximumAmountGreaterThanEqual(double.parse(value), getPairsParamsProvider, getExchangeAmountProvider)){
      callGetExchangeAmountData(context,{"from":getCurrenciesFullProvider.getSelectedYouSendCoins().id!.toLowerCase(),"to":getCurrenciesFullProvider.getSelectedYouGetCoins().id!.toLowerCase(),"amountFrom":getPairsParamsProvider.getSendAmountValue().toString()},getExchangeAmountProvider);
    }
  }

   bool validateMinimumAmount(double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data!.error != null) {
      return sendCoinAmount < double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.min!.from!);
    } else {
      return sendCoinAmount < getPairsParamsProvider.minimumAmount;
    }
  }

  bool validateMinimumAmountLessThanEqual(double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data!.error != null) {
      return sendCoinAmount <= double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.min!.from!);
    } else {
      return sendCoinAmount <= getPairsParamsProvider.minimumAmount;
    }
  }

  bool validateMaximumAmount(double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data!.error != null) {
      return sendCoinAmount > double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.max!.from!);
    } else {
      return sendCoinAmount > getPairsParamsProvider.maximumAmount;
    }
  }

  bool validateMaximumAmountGreaterThanEqual(double sendCoinAmount, GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data!.error != null) {
      return sendCoinAmount >= double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.max!.from!);
    } else {
      return sendCoinAmount >= getPairsParamsProvider.maximumAmount;
    }
  }

  double minimumAmount(GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data!.error != null) {
      return double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.min!.from!);
    } else {
      return getPairsParamsProvider.minimumAmount;
    }
  }

  double maximumAmount(GetPairsParamsProvider getPairsParamsProvider, GetExchangeAmountProvider getExchangeAmountProvider) {
    if(getExchangeAmountProvider.data!.error != null) {
      return double.parse(getExchangeAmountProvider.data!.error!.data!.limits!.max!.from!);
    } else {
      return getPairsParamsProvider.maximumAmount;
    }
  }

  bool isNextButtonEnabled(String status) {
    return status != "...";
  }
}

