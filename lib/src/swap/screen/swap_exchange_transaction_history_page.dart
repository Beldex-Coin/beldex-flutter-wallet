import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/database/swap_txn_history.dart';
import 'package:beldex_wallet/src/swap/provider/swap_transaction_expansion_status_change_notifier.dart';
import 'package:beldex_wallet/src/swap/util/circular_progress_bar.dart';
import 'package:beldex_wallet/src/util/generate_name.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../routes.dart';
import '../../stores/wallet/wallet_store.dart';
import '../../widgets/no_transactions_yet.dart';
import '../database/swap_transaction_history_model.dart';
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

  late SwapTransactionHistory _swapTransactionHistory;
  List<SwapTransactionHistoryModel> _transactions = [];
  bool _isLoading = true;

  Future<void> _loadTransactions() async {
    final walletStore = Provider.of<WalletStore>(context, listen: false);
    var walletAddress = _swapTransactionHistory.walletAddress ?? '';
    if (walletAddress.isEmpty) {
      walletAddress = walletStore.subaddress.address;
    }
    // Loads the wallet's swap history from SQLite (offline, no API call).
    final resultList = await SwapTxnHistory.instance.getOrderHistoryModels(walletAddress);
    if (!mounted) return;
    setState(() {
      _transactions = resultList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _swapTransactionHistory = widget.swapTransactionHistory;
    _loadTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.sizeOf(context).width;
    final _screenHeight = MediaQuery.sizeOf(context).height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    final walletStore = Provider.of<WalletStore>(context);
    if (_isLoading) {
      return Center(child: circularProgressBar(Color(0xff0BA70F), 4.0));
    }
    return body(_screenWidth, _screenHeight, settingsStore, _scrollController, walletStore);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget body(double _screenWidth, double _screenHeight, SettingsStore settingsStore, ScrollController _scrollController, WalletStore walletStore){
    return _transactions.isNotEmpty ? LayoutBuilder(builder:
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
                _transactions, walletStore),
          ),
        ),
      );
    }) : noTransactionsYet(settingsStore, _screenWidth);
  }

  List<List<dynamic>> rows = [];

  var addHeader = false;

  // Test CSV created just for demo.
  String get csv => const ListToCsvConverter().convert(rows);

  void requestStoragePermission() async {
    if(Platform.isAndroid) {
      final plugin = DeviceInfoPlugin();
      final android = await plugin.androidInfo;

      final storageStatus = android.version.sdkInt < 33
          ? await Permission.storage.request()
          : PermissionStatus.granted;

      switch (storageStatus) {
        case PermissionStatus.granted when csv.isNotEmpty:
          print("Permission granted");
          await downloadCSV(csv);
          break;

        case PermissionStatus.denied:
          print("Permission denied");
          break;

        case PermissionStatus.permanentlyDenied:
          await openAppSettings();
          break;

        default:
          break;
      }
    } else {
      if (csv.isNotEmpty) {
        await downloadCSV(csv);
      }
    }
  }

  // Download and save CSV to your Device
  Future<void> downloadCSV(String csv) async {
    final Uint8List bytes = Uint8List.fromList(utf8.encode(csv));
    if(Platform.isAndroid) {
      final directory = await getExternalStorageDirectories(
          type: StorageDirectory.downloads); // Internal storage
      final path = '${directory?.first.path}/Beldex_wallet_swap_transaction_report.csv';
      // Convert your CSV string to a Uint8List for downloading.
      final file = File(path);
      await file.writeAsBytes(bytes).whenComplete(() {
        final file = File(path);
        Share.shareXFiles([XFile(file.path)]);
      });
    }
    if(Platform.isIOS) {
      // Use application documents directory for cross-platform compatibility
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/Beldex_wallet_swap_transaction_report.csv';

      final file = File(path);
      await file.writeAsBytes(bytes);

      // Share the file
      await Share.shareXFiles([XFile(file.path)], text: 'Transaction Report');
    }
  }

  Widget transactionRow(SettingsStore settingsStore, List<SwapTransactionHistoryModel> transactions, int index, WalletStore walletStore) {
    final result = transactions[index];
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
              dividerColor: Colors.transparent),
          child:  Consumer<SwapTransactionExpansionStatusChangeNotifier>(
              builder: (context, swapTransactionExpansionStatusChangeNotifier, child) {
                final isExpanded = swapTransactionExpansionStatusChangeNotifier.isExpanded(index);
                return Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: MediaQuery.sizeOf(context).width,
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
                              visible: result.txnStatus == "waiting",
                              child:showImage('assets/images/swap/swap_waiting.svg'),
                            ),
                            Visibility(
                              visible: result.txnStatus == "confirming",
                              child:showImage('assets/images/swap/swap_pending.svg'),
                            ),
                            Visibility(
                              visible: result.txnStatus == "finished",
                              child:showImage('assets/images/swap/swap_completed.svg'),
                            ),
                            Visibility(
                              visible: result.txnStatus == "refunded",
                              child:showImage('assets/images/swap/swap_refund.svg'),
                            ),
                            Visibility(
                              visible: result.txnStatus == "overdue",
                              child:showImage('assets/images/swap/swap_waiting.svg'),
                            ),
                            Visibility(
                              visible: result.txnStatus == "expired",
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
                                            Text('${toStringAsFixed(result.amountFrom)} ${result.currencyFrom.toUpperCase()}',
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
                                  Text('1 ${result.currencyFrom.toUpperCase()} = ${toStringAsFixed(result.rate)}${result.currencyTo.toUpperCase()}',
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
                                  Text(result.txnStatus == "finished" ? '${toStringAsFixed(result.amountTo)} ${result.currencyTo.toUpperCase()}' : '---',
                                      style: TextStyle(
                                          backgroundColor: Colors.transparent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: result.txnStatus == "finished"
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
                                      Text(getTransactionDate(result.createdAt),
                                          style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffFFFFFF)
                                                  : Color(0xff737373))),
                                      Text(getTransactionTime(result.createdAt),
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
                                  Text(result.txnStatus.capitalized(),
                                      style: TextStyle(
                                          backgroundColor: Colors.transparent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: result.txnStatus == "finished"
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
                                      switch (result.txnStatus) {
                                        case "waiting" :
                                        case "new" :
                                          {
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                Routes.swapTransactionPaymentDetails, (route) => route.isFirst,
                                                arguments: GetTransactionStatusWithWalletAddress(result, walletStore.subaddress.address, exchangeName: result.exchange));
                                            break;
                                          }
                                        case "confirming" :
                                        case "exchanging" :
                                        case "sending" :
                                          {
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                Routes.swapTransactionExchanging, (route) => route.isFirst,
                                                arguments: GetTransactionStatusWithWalletAddress(result, walletStore.subaddress.address, exchangeName: result.exchange));
                                            break;
                                          }
                                        case "finished" :
                                          {
                                            //Completed Screen
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                    Routes.swapTransactionCompleted, (route) => route.isFirst,
                                                    arguments: GetTransactionStatus(result, result.txnStatus, walletStore.subaddress.address, exchangeName: result.exchange));
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
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                    Routes.swapTransactionUnPaid, (route) => route.isFirst,
                                                    arguments: GetTransactionStatus(result, result.txnStatus, walletStore.subaddress.address, exchangeName: result.exchange));
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
                                                color: result.txnStatus == "finished"
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
      List<SwapTransactionHistoryModel> transactions, WalletStore walletStore) {
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
                requestStoragePermission();
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
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                if(rows.length-1 != transactions.length) {
                  if(addHeader){
                    addHeader = false;
                    rows.add(["Date", "Status", "Exchange_Currency", "Exchange_Amount_From", "Exchange_Rate", "Received_Amount", "Swap_Type", "Receiver_Address"]);
                  }
                  final result = transactions[index];
                  rows.add([getDate(result.createdAt), result.txnStatus, "${result.currencyFrom.toUpperCase()} -> ${result.currencyTo.toUpperCase()}", toStringAsFixed(result.amountFrom), toStringAsFixed(result.rate), toStringAsFixed(result.amountTo), result.swapType.isNotEmpty ? result.swapType[0].toUpperCase() + result.swapType.substring(1) : result.swapType,result.payoutAddress]);
                }
                return transactionRow(settingsStore, transactions, index, walletStore);
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

  Widget expansionTile(SwapTransactionHistoryModel result, SettingsStore settingsStore) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Visibility(
            visible: result.txnStatus == "waiting",
            child:showImage('assets/images/swap/swap_waiting.svg'),
          ),
          Visibility(
            visible: result.txnStatus == "confirming",
            child:showImage('assets/images/swap/swap_pending.svg'),
          ),
          Visibility(
            visible: result.txnStatus == "finished",
            child:showImage('assets/images/swap/swap_completed.svg'),
          ),
          Visibility(
            visible: result.txnStatus == "refunded",
            child:showImage('assets/images/swap/swap_refund.svg'),
          ),
          Visibility(
            visible: result.txnStatus == "overdue",
            child:showImage('assets/images/swap/swap_waiting.svg'),
          ),
          Visibility(
            visible: result.txnStatus == "expired",
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
                          Text('${toStringAsFixed(result.amountFrom)} ${result.currencyFrom.toUpperCase()}',
                              style: TextStyle(
                                  backgroundColor:
                                  Colors.transparent,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff222222))),
                          Text(getDate(result.createdAt),
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
                                      text: result.txnStatus == "finished" ? '~ ${toStringAsFixed(result.amountTo)} ${result.currencyTo.toUpperCase()}' : '---',
                                      style: TextStyle(
                                          backgroundColor:
                                          Colors
                                              .transparent,
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: result.txnStatus == "finished"
                                              ? Color(
                                              0xff00AD07)
                                              : settingsStore
                                              .isDarkTheme
                                              ? Color(0xffAFAFBE)
                                              : Color(0xff737373)))
                                ]),
                          ),
                          Text(
                              result.txnStatus.capitalized(),
                              style: TextStyle(
                                  backgroundColor:
                                  Colors.transparent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: result.txnStatus == "finished"
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

