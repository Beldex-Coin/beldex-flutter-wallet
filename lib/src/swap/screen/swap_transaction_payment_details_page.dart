import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/api_client/get_status_api_client.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../../routes.dart';
import '../../stores/sync/sync_store.dart';
import '../../widgets/no_internet.dart';
import '../dialog/show_qr_code_dialog.dart';
import '../model/get_status_model.dart';
import '../util/circular_progress_bar.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import 'number_stepper.dart';

class SwapTransactionPaymentDetailsPage extends BasePage {
  SwapTransactionPaymentDetailsPage({required this.transactionDetails});

  final GetTransactionResult transactionDetails;

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
    return SwapTransactionPaymentDetailsHome(transactionDetails: transactionDetails);
  }
}

class SwapTransactionPaymentDetailsHome extends StatefulWidget {
  SwapTransactionPaymentDetailsHome({required this.transactionDetails});

  final GetTransactionResult transactionDetails;

  @override
  State<SwapTransactionPaymentDetailsHome> createState() => _SwapTransactionPaymentDetailsHomeState();
}

class _SwapTransactionPaymentDetailsHomeState extends State<SwapTransactionPaymentDetailsHome> {
  int currentStep = 3;
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

  late GetTransactionResult createdTransactionDetails;
  late String _fromBlockChain;
  late Timer timer;
  late GetStatusApiClient getStatusApiClient;
  late StreamController<GetStatusModel> _getStatusStreamController;

  ValueNotifier<String> pendingTransactionTimeRemaining = ValueNotifier("");
  Timer? pendingTransactionTimer;
  bool timeIsExpire = false;
  String status = "overdue";
  //var createdTxnDetails = {'type': 'float', 'payTill': DateTime.now().toString()};

  void startAndStopPendingTransactionTimer(int? createdAt) {
    pendingTransactionTimer?.cancel();
    final start = DateTime.fromMicrosecondsSinceEpoch(createdAt!);
    final newTime = start.add(Duration(hours: 3));
    final countDownDate = newTime.millisecondsSinceEpoch;

    pendingTransactionTimer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final distance = countDownDate - now;

      final hours = (distance ~/ (1000 * 60 * 60)) % 24;
      final minutes = (distance ~/ (1000 * 60)) % 60;
      final seconds = (distance ~/ 1000) % 60;

      pendingTransactionTimeRemaining.value = '$hours h $minutes m $seconds s';

      if (distance < 0) {
        pendingTransactionTimeRemaining.value = '00:00:00';
        timeIsExpire = true;
        clearIntervals();
        Future.delayed(Duration(seconds: 2), () {
          callUnPaidScreen(createdTransactionDetails, status);
        });
      }
    });
  }

  void clearIntervals() {
    pendingTransactionTimer?.cancel();
  }

  void callUnPaidScreen(GetTransactionResult createdTransactionDetails, String? status) {
    Navigator.of(context).pop(true);
    Navigator.of(context).pushNamed(Routes.swapTransactionUnPaid,arguments: GetTransactionStatus(createdTransactionDetails, status));
  }

  @override
  void initState() {
    createdTransactionDetails = widget.transactionDetails;
    startAndStopPendingTransactionTimer(createdTransactionDetails.createdAt);
    _fromBlockChain = '---';
    getStatusApiClient = GetStatusApiClient();
    // Create a stream controller and get status to the stream.
    _getStatusStreamController = StreamController<GetStatusModel>();
    Future.delayed(Duration(seconds: 2), () {
      callGetStatusApi(createdTransactionDetails, getStatusApiClient);
      if (!mounted) return;
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        if (!mounted && !isOnline(context)) return;
        callGetStatusApi(createdTransactionDetails, getStatusApiClient);
      }); // Start adding getStatus api result to the stream.
    });
    super.initState();
  }

  void callGetStatusApi(GetTransactionResult? result, GetStatusApiClient getStatusApiClient){
    getStatusApiClient.getStatusData(context, {"id":"${result?.id}"}).then((value){
      if(value!.result!.isNotEmpty){
        if (!_getStatusStreamController.isClosed) {
          _getStatusStreamController.sink.add(value);
        }
        status = value.result!;
        switch(value.result){
          case "waiting" :{
            //Swap Payment Details Screen
            break;
          }
          case "confirming" :
          case "exchanging" :
          case "sending" :{
            //Exchanging Screen
            if(getStatusApiClient.isVisibleQRCodeDialog) {
              Navigator.of(context).pop(true);
            }
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
              Navigator.of(context).pushNamed(Routes.swapTransactionExchanging,arguments: createdTransactionDetails);
            });
            break;
          }
          case "finished" : {
            //Completed Screen
            if(getStatusApiClient.isVisibleQRCodeDialog) {
              Navigator.of(context).pop(true);
            }
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
              Navigator.of(context).pushNamed(Routes.swapTransactionCompleted,arguments: GetTransactionStatus(createdTransactionDetails, value.result));
            });
            break;
          }
          case "refunded" : {
            break;
          }
          case "failed" :
          case "overdue" :
          case "expired" : {
            //Failed, Overdue and Expired Screen
            if(getStatusApiClient.isVisibleQRCodeDialog) {
              Navigator.of(context).pop(true);
            }
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
              callUnPaidScreen(createdTransactionDetails, value.result);
            });
            break;
          }
          default: {
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final syncStore = Provider.of<SyncStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    ToastContext().init(context);
    return StreamBuilder<GetStatusModel>(
      stream: _getStatusStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: circularProgressBar(Color(0xff0BA70F), 4.0)); // Display a loading indicator when waiting for data.
        } else if (snapshot.hasError || !snapshot.hasData || !isOnline(context)) {
          return noInternet(settingsStore, _screenWidth); // Display an error message if an error occurs. or Display a message when no data is available.
        } else {
          return body(
              _screenWidth,
              _screenHeight,
              settingsStore,
              _scrollController,
              createdTransactionDetails,
          syncStore);
        }
      },
    );
  }

  Widget body(double _screenWidth, double _screenHeight, SettingsStore settingsStore, ScrollController _scrollController, GetTransactionResult? createdTransactionDetails, SyncStore syncStore){
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
        Flexible(
          flex:1,
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
                        child: paymentSendFundsToTheAddressBelowScreen(settingsStore,createdTransactionDetails, syncStore),
                      ),
                    ),
                  ),
                ));
          }),
        ),
      ],
    );
  }

  Widget paymentSendFundsToTheAddressBelowScreen(SettingsStore settingsStore, GetTransactionResult? createdTransactionDetails, SyncStore syncStore,) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff222222)),
                      ),
                      Text(
                        '${toStringAsFixed(createdTransactionDetails?.amountExpectedFrom)} ${createdTransactionDetails?.currencyFrom?.toUpperCase()}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff20D030)),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: createdTransactionDetails?.currencyFrom == "bdx",
                  child: Flexible(
                    flex: 1,
                    child: Observer(
                      builder: (_) {
                        return InkWell(
                          onTap: syncStatus(syncStore.status) && isOnline(context)
                                ? () async {
                            await Navigator.pushNamed(context, Routes.send,
                                arguments: {'flash': true, 'address': createdTransactionDetails?.payinAddress, 'amount': createdTransactionDetails?.amountExpectedFrom});
                            } : null ,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff20D030),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(8))),
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
                                        fontWeight: FontWeight.normal,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff222222)))
                              ],
                            ),
                          ),
                        );
                      }
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
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      '${createdTransactionDetails?.id}',
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
                    InkWell(
                      onTap: (){
                        Clipboard.setData(ClipboardData(
                            text: createdTransactionDetails!.id.toString()));
                        Toast.show(
                          tr(context).copied,
                          duration: Toast
                              .lengthShort, // Toast duration (short or long)
                          gravity: Toast
                              .bottom,
                          textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white),// Toast gravity (top, center, or bottom)// Text color
                          backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,
                        );
                      },
                      child: Icon(
                        Icons.copy,
                        color: Color(0xff20D030),
                        size: 14,
                      ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time left to send ${toStringAsFixed(createdTransactionDetails?.amountExpectedFrom)} ${createdTransactionDetails?.currencyFrom?.toUpperCase()}',
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
                    ValueListenableBuilder<String>(
                      valueListenable: pendingTransactionTimeRemaining,
                      builder: (context, value, child) => Text(
                        value,//'${createdTransactionDetails?.createdAt}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffEBEBEB)
                                : Color(0xff222222)),
                      ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    '${createdTransactionDetails?.payinAddress}',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffFFFFFF)
                            : Color(0xff222222)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: createdTransactionDetails!.payinAddress.toString()));
                          Toast.show(
                            tr(context).copied,
                            duration: Toast
                                .lengthShort, // Toast duration (short or long)
                            gravity: Toast
                                .bottom,
                            textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white),// Toast gravity (top, center, or bottom)// Text color
                            backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,
                          );
                        },
                        child: Container(
                          width: 30.0,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color(0xff00AD07),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          child: Icon(
                            Icons.copy,
                            color: Color(0xffFFFFFF),
                            size: 20,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          getStatusApiClient.setQRCodeDialogVisibility(true);
                          showQRCodeDialog(context, settingsStore,createdTransactionDetails?.payinAddress, onDismiss: (buildContext){
                            getStatusApiClient.setQRCodeDialogVisibility(false);
                            Navigator.of(buildContext).pop(true);
                          });
                        },
                        child: Container(
                          width: 30.0,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff32324A)
                                  : Color(0xffFFFFFF),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          child: SvgPicture.asset(
                            'assets/images/swap/scan_qr.svg',
                            colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222), BlendMode.srcIn),
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
            Text('blockchain : $_fromBlockChain',
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
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width:MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Flexible(
                      child: ValueListenableBuilder<String>(
                        valueListenable: pendingTransactionTimeRemaining,
                        builder: (context, value, child) => Text('Time Remaining : $value',//${createdTransactionDetails?.createdAt}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222))),
                      ),
                    )
                  ],
                ),
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
          margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
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
                    padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      '${toStringAsFixed(createdTransactionDetails!.amountExpectedFrom)} ${createdTransactionDetails.currencyFrom?.toUpperCase()}',
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
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
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
                    padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      '1 ${createdTransactionDetails!.currencyFrom?.toUpperCase()} ~ ${toStringAsFixed(createdTransactionDetails.rate)} ${createdTransactionDetails.currencyTo?.toUpperCase()}',
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
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
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
                    padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      '${toStringAsFixed(createdTransactionDetails.networkFee)} ${createdTransactionDetails.currencyTo?.toUpperCase()}',
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
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
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
                      '${toStringAsFixed(createdTransactionDetails.networkFee)} ${createdTransactionDetails.currencyTo?.toUpperCase()}',
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
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
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
                      padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: Column(
                        children: [
                          Text('1 ETH ~ 2,518.97904761 XRP',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffEBEBEB)
                                      : Color(0xff222222))),
                          Text('The fixed rate is updated every 30 Seconds',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffAfAFBE)
                                      : Color(0xff737373)))
                        ],
                      ),
                    )
                  ]),
                if (false)
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
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
                    padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
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
                      '~ ${toStringAsFixed(createdTransactionDetails.amountExpectedTo)} ${createdTransactionDetails.currencyTo?.toUpperCase()}',
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
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel();
    clearIntervals();
    _getStatusStreamController.close();
    super.dispose();
  }
}
