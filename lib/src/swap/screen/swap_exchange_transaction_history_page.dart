import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:beldex_wallet/src/swap/provider/get_transactions_provider.dart';
import 'package:beldex_wallet/src/swap/provider/swap_transaction_expansion_status_change_notifier.dart';
import 'package:beldex_wallet/src/swap/util/circular_progress_bar.dart';
import 'package:beldex_wallet/src/widgets/no_internet.dart';
import 'package:beldex_wallet/src/util/generate_name.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';
import '../../../routes.dart';
import '../../util/network_provider.dart';
import '../../widgets/no_transactions_yet.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

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
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
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
  bool _isInitialized = false;
  late NetworkProvider networkProvider;

  @override
  void initState() {
    _swapTransactionHistory = widget.swapTransactionHistory;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<GetTransactionsProvider>(context,listen: false);
      provider.getTransactionsListData(context,{"id":_swapTransactionHistory.transactionIdList});
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        if (!mounted && !networkProvider.isConnected) return;
        provider.getTransactionsListData(context,{"id":_swapTransactionHistory.transactionIdList});
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
    ToastContext().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<NetworkProvider>(
          builder: (context, networkProvider, child) {
            this.networkProvider = networkProvider;
          return Consumer<GetTransactionsProvider>(builder: (context,getTransactionsProvider,child){
            if(getTransactionsProvider.loading){
              return Center(child: circularProgressBar(Color(0xff0BA70F), 4.0));
            }

            if(getTransactionsProvider.error != null) {
              return noInternet(settingsStore, _screenWidth);
            }

            if(getTransactionsProvider.data != null) {
              this.getTransactionsProvider = getTransactionsProvider;
              _isInitialized = true;
              return body(_screenWidth,_screenHeight,settingsStore,_scrollController, getTransactionsProvider.data!);
            }

            return SizedBox();
          });
        }
      ),
    );
  }

  @override
  void dispose() {
    if(_isInitialized) {
      getTransactionsProvider.dispose();
    }
    timer?.cancel();
    super.dispose();
  }

  Widget body(double _screenWidth, double _screenHeight, SettingsStore settingsStore, ScrollController _scrollController, GetTransactionsModel getTransactionsModel){
    return  _swapTransactionHistory.transactionIdList.isNotEmpty ? LayoutBuilder(builder:
        (BuildContext context, BoxConstraints constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
            child: transactionHistoryScreen(
                _screenWidth,
                _screenHeight,
                settingsStore,
                getTransactionsModel),
          ),
        ),
      );
    }) : noTransactionsYet(settingsStore, _screenWidth);
  }

  List<List<dynamic>> rows = [];

  var addHeader = false;

  // Test CSV created just for demo.
  String get csv => const ListToCsvConverter().convert(rows);

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        final androidVersion = int.tryParse(androidInfo.version.release ?? '11') ?? 11;
        if (androidVersion >= 11) {
          status = await Permission.manageExternalStorage.request();
        } else {
          status = await Permission.storage.request();
        }
      } else {
        status = await Permission.manageExternalStorage.request();
      }

      if (status.isGranted && csv.isNotEmpty) {
        await downloadCSV(csv);
      } else if (status.isDenied) {
        Toast.show(
          'Storage permission denied',
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          textStyle:TextStyle(color: Colors.white),
          backgroundColor: Color(0xff0ba70f),
        );
      } else if (status.isPermanentlyDenied) {
        await openAppSettings(); // Takes user to settings to enable manually
      }
    } else {
      if(csv.isNotEmpty) {
        await downloadCSV(csv);
      }
    }
  }

  // Download and save CSV to your Device
  Future<void> downloadCSV(String csv) async {
    final Uint8List bytes = Uint8List.fromList(utf8.encode(csv));
    final directory = await getExternalStorageDirectories(type: StorageDirectory.downloads); // Internal storage
    final path = '${directory?.first.path}/Transaction_report.csv';
    // Convert your CSV string to a Uint8List for downloading.
    final file = File(path);
    //await file.writeAsBytes(bytes);
    await file.writeAsBytes(bytes).whenComplete(() {
      print("path $path");
      final file = File(path);
      Share.shareXFiles([XFile(file.path)]);
      Toast.show(
        'Downloaded Successfully',
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        textStyle:TextStyle(color: Colors.white),
        backgroundColor: Color(0xff0ba70f),
      );
    });
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
          child:  Consumer<SwapTransactionExpansionStatusChangeNotifier>(
              builder: (context, swapTransactionExpansionStatusChangeNotifier, child) {
                final isExpanded = swapTransactionExpansionStatusChangeNotifier.isExpanded(index);
                return Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: ExpansionTile(
                      initiallyExpanded: isExpanded,
                      onExpansionChanged: (test) {
                        swapTransactionExpansionStatusChangeNotifier.toggle(index, test);
                      },
                      trailing: swapTransactionExpansionStatusChangeNotifier.getStatus(index) != null ?
                      swapTransactionExpansionStatusChangeNotifier.getStatus(index)! ? trailingIcon(90, settingsStore) : trailingIcon(270, settingsStore) : trailingIcon(270, settingsStore),
                      childrenPadding: EdgeInsets.zero,
                      tilePadding: EdgeInsets.only(left: 0, right: 0),
                      collapsedIconColor: settingsStore.isDarkTheme ? Colors.white : Color(0xFF222222),
                      iconColor: settingsStore.isDarkTheme ? Colors.white : Color(0xFF222222),
                      title: swapTransactionExpansionStatusChangeNotifier.getStatus(index) != null ?
                      swapTransactionExpansionStatusChangeNotifier.getStatus(index)! ? Row(
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
                            Visibility(
                              visible: result.status == "expired",
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
                                      : Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text('Exchange Amount',
                                                style: TextStyle(
                                                    backgroundColor: Colors.transparent,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: settingsStore.isDarkTheme
                                                        ? Color(0xffAFAFBE)
                                                        : Color(0xff737373))),
                                            Text('${toStringAsFixed(result.amountExpectedFrom)} ${result.currencyFrom!.toUpperCase()}',
                                                style: TextStyle(
                                                    backgroundColor:
                                                    Colors.transparent,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14,
                                                    color: settingsStore.isDarkTheme
                                                        ? Color(0xffFFFFFF)
                                                        : Color(0xff222222))),
                                          ]),
                                )),
                          ]) :
                       expansionTile(result, settingsStore) : expansionTile(result, settingsStore),
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
                                  Text(truncateMiddle(result.payoutAddress!),
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(getTransactionDate(result.createdAt!),
                                          style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffFFFFFF)
                                                  : Color(0xff737373))),
                                      Text(getTransactionTime(result.createdAt!),
                                          style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffFFFFFF)
                                                  : Color(0xff737373))),
                                    ],
                                  ),
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
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Expand Details',
                                      style: TextStyle(
                                          backgroundColor: Colors.transparent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xffAFAFBE)
                                              : Color(0xff737373))),
                                  InkWell(
                                    onTap: () {
                                      switch (result.status) {
                                        case "waiting" :
                                          {
                                            Navigator.of(context).pop(true);
                                            Navigator.of(context).pushNamed(Routes.swapTransactionPaymentDetails, arguments: result);
                                            break;
                                          }
                                        case "confirming" :
                                        case "exchanging" :
                                        case "sending" :
                                          {
                                            Navigator.of(context).pop(true);
                                            Navigator.of(context).pushNamed(Routes.swapTransactionExchanging,arguments: result);
                                            break;
                                          }
                                        case "finished" :
                                          {
                                            //Completed Screen
                                            Navigator.of(context).pop(true);
                                            Navigator.of(context).pushNamed(Routes.swapTransactionCompleted,
                                                arguments: GetTransactionStatus(result, result.status));
                                            break;
                                          }
                                        case "refunded" :
                                          {
                                            break;
                                          }
                                        case "failed" :
                                        case "overdue" :
                                        case "expired" :
                                          {
                                            Navigator.of(context).pop(true);
                                            Navigator.of(context).pushNamed(Routes.swapTransactionUnPaid,
                                                arguments: GetTransactionStatus(result, result.status));
                                            break;
                                          }
                                        default: {
                                          break;
                                        }
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("View",
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                backgroundColor: Colors.transparent,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: result.status == "finished"
                                                    ? Color(0xff20D030)
                                                    : settingsStore.isDarkTheme
                                                    ? Color(0xffD1D1D3)
                                                    : Color(0xff737373))),
                                        SizedBox(width: 5,),
                                        SvgPicture.asset(
                                          'assets/images/swap/swap_view.svg',
                                          colorFilter: ColorFilter.mode(Colors.green, BlendMode.srcIn),
                                          width: 13,
                                          height: 13,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                );
              }),
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
    rows.clear();
    addHeader = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Transaction History Back Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff060606)),
            ),
            InkWell(
              onTap: () async {
                await requestStoragePermission();
              },
              child: SvgPicture.asset(
                'assets/images/swap/swap_download.svg',
                colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                    ? Color(0xffffffff)
                    : Color(0xff16161D), BlendMode.srcIn),
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              key: _listKey,
              padding: EdgeInsets.only(bottom: 15),
              itemCount: getTransactionsModel.result!.length,
              itemBuilder: (context, index) {
                if(rows.length-1 != getTransactionsModel.result!.length) {
                  if(addHeader){
                    addHeader = false;
                    rows.add(["Status", "Date", "Exchange_Amount_From", "Exchange_Rate", "Receiver", "Amount_Received"]);
                  }
                  final result = getTransactionsModel.result![index];
                  rows.add([result.status, getDate(result.createdAt!), toStringAsFixed(result.amountExpectedFrom), toStringAsFixed(result.rate), result.payinAddress, toStringAsFixed(result.amountExpectedTo)]);
                }
                return transactionRow(settingsStore, getTransactionsModel, index);
              }),
        ),
      ],
    );
  }

  Widget showImage(String imageUrl) {
    return SvgPicture.asset(
      imageUrl,
      width: 18,
      height: 18,
    );
  }

  Widget expansionTile(GetTransactionResult result, SettingsStore settingsStore) {
    return Row(
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
          Visibility(
            visible: result.status == "expired",
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
                          Text('${toStringAsFixed(result.amountExpectedFrom)} ${result.currencyFrom!.toUpperCase()}',
                              style: TextStyle(
                                  backgroundColor:
                                  Colors.transparent,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff222222))),
                          Text(getDate(result.createdAt!),
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
                                      text: '~ ${toStringAsFixed(result.amountExpectedTo)} ${result.currencyTo!.toUpperCase()}',
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
        ]);
  }

  Widget trailingIcon(int degree, SettingsStore settingsStore) {
    return Transform.rotate(
      angle: degree * pi / 180,
      child: Icon(
          Icons.arrow_back_ios_new,color:settingsStore.isDarkTheme ? Color(0xffFFFFFF) : Color(0xff222222),
        size: 15,
      ),
    );
  }

}

