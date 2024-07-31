import 'dart:io';
import 'dart:typed_data';

import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/subaddress/newsubAddress_dialog.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/receive/qr_image.dart';
import 'package:beldex_wallet/src/stores/subaddress_list/subaddress_list_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

String currentSubAddress = '';

class ReceivePage extends BasePage {
  @override
  bool get isModalBackButton => false;

  @override
  String getTitle(AppLocalizations t) => t.receive;

  @override
  Color get textColor => Colors.white;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) =>
      SingleChildScrollView(child: ReceiveBody());
}

class ReceiveBody extends StatefulWidget {
  @override
  ReceiveBodyState createState() => ReceiveBodyState();
}

class ReceiveBodyState extends State<ReceiveBody> with WidgetsBindingObserver {
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isExpand = false;
  bool isOpen = false;
  OverlayEntry? overlayEntry;
  GlobalKey globalKey = GlobalKey();
  bool _isOverlayVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  final _globalKey = GlobalKey();

  Future<Uint8List?> _capturePng() async {
    try {
      final boundary =
          _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(
        pixelRatio: 3.0,
      );
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  void _incrementCounter(String address, String text) async {
    try {
      final imageUint8List = await _capturePng();
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/share.jpeg';

      await File(filePath).writeAsBytes(imageUint8List!);

      await Share.shareFiles(
          [filePath],
          text: address,
          subject: 'Share',
          mimeTypes: ['image/jpeg']
      );
      /*await WcFlutterShare.share(
          text: address,
          sharePopupTitle: 'share',
          fileName: 'share.jpeg',
          mimeType: 'image/jpeg',
          bytesOfFile: imageUint8List);*/
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncStore = Provider.of<SyncStore>(context);
    return syncStore.status is SyncedSyncStatus ||
            syncStore.status.blocksLeft == 0
        ? bodyContainerWithWallet()
        : bodyContainerWithoutWallet();
  }

  Widget bodyContainerWithWallet() {
    final walletStore = Provider.of<WalletStore>(context);
    final subAddressListStore = Provider.of<SubaddressListStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    amountController.addListener(() {
      if (_formKey.currentState?.validate() ?? false) {
        walletStore.onChangedAmountValue(amountController.text);
      } else {
        walletStore.onChangedAmountValue('');
      }
    });
    ToastContext().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Container(
            color: settingsStore.isDarkTheme
                ? Color(0xff171720)
                : Color(0xffffffff),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35.0, right: 35.0),
                  child: Column(
                    children: <Widget>[
                      Observer(builder: (_) {
                        if (amountController.text.isEmpty) {
                          walletStore.onChangedAmountValue('');
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height:
                                  MediaQuery.of(context).size.height * 0.60 / 3,
                              width:
                                  MediaQuery.of(context).size.height * 0.60 / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff1F1F28)
                                    : Color(0xffEDEDED),
                              ),
                              padding: EdgeInsets.all(18),
                              child: RepaintBoundary(
                                key: _globalKey,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(10),
                                  child: QrImage(
                                    data: walletStore.subaddress.address +
                                        walletStore.amountValue,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      Observer(builder: (_) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    tr(context).walletAddress,
                                    style: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17,
                                        color: Color(0xff1BB51E)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text: walletStore.subaddress.address));
                                    Toast.show(
                                      tr(context).copied,
                                      duration: Toast.lengthShort,
                                      // Toast duration (short or long)
                                      gravity: Toast.bottom,
                                      // Toast gravity (top, center, or bottom)
                                      textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white),
                                      backgroundColor: settingsStore.isDarkTheme
                                          ? Colors.grey.shade50
                                          : Colors.grey.shade900,
                                    );
                                  },
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/images/new-images/copy.svg',
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff16161D),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Center(
                                            child: GestureDetector(
                                                child: Text(
                                                    walletStore
                                                        .subaddress.address,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      backgroundColor: Colors.transparent,
                                                      fontSize: 11.0,
                                                      height: 1.5,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(
                                                          0xff82828D), //Theme.of(context).primaryTextTheme.headline6.color
                                                    ))))))
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        tr(context).enterBdxToReceive,
                        style: TextStyle(backgroundColor: Colors.transparent,fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Form(
                      key: _formKey,
                      child: NewBeldexTextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
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
                        hintText: tr(context).enterAmount,
                        validator: (value) {
                          walletStore.validateAmount(value ?? '',tr(context));
                          if (walletStore.errorMessage?.isNotEmpty ?? false) {
                            return walletStore.errorMessage!;
                          } else {
                            return null;
                          }
                        },
                        controller: amountController,
                        onChanged: (val) {
                          print('amount value called automatically');
                          _globalKey.currentContext!.findRenderObject()!.reassemble();
                          if (amountController.text.isEmpty) {
                            walletStore.onChangedAmountValue('');
                          }
                        },
                      )),
                ),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 15.0, right: 15.0, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff464657)
                                  : Color(0xffDADADA),
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            //SubAddressDropDownList(settingsStore: settingsStore,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () async {
                                    await showDialog<void>(
                                        context: context,
                                        builder: (_) {
                                          return SubAddressDropDownList(
                                            settingsStore: settingsStore,
                                            walletStore: walletStore,
                                            subAddressListStore:
                                                subAddressListStore,
                                            globalKey: _globalKey,
                                          );
                                        });
                                  },
                                  child: displayContainerWithWallet(context)),
                            ),
                            SizedBox(height: 15),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                      context: context,
                                      builder: (context) {
                                        return SubAddressAlert(
                                            subAddressListStore:
                                                subAddressListStore);
                                      });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 25.0,
                                      height: 25.0,
                                      child: SvgPicture.asset(
                                          'assets/images/new-images/plus_fill.svg',
                                          color: Color(0xff2979FB)),
                                    ),
                                    Text(
                                      tr(context).addSubAddress,
                                      //tr(context).subaddresses,
                                      style: TextStyle(
                                          backgroundColor: Colors.transparent,
                                          decoration: TextDecoration.underline,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff2979FB)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.20 / 3),
                Container(
                  margin: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () => _incrementCounter(
                        walletStore.subaddress.address, amountController.text),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xff0BA70F),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              tr(context).shareQr,
                              style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ))),
    );
  }

  Widget bodyContainerWithoutWallet() {
    final receivePageChangeNotifier = Provider.of<ReceivePageChangeNotifier>(context);
    getCurrentAddress().then((value){
     receivePageChangeNotifier.setCurrentAddress(value);
     setState(() {});
    });
    final settingsStore = Provider.of<SettingsStore>(context);
    amountController.addListener(() {
      if (_formKey.currentState?.validate() ?? false) {
        onChangedAmountValue(amountController.text,receivePageChangeNotifier);
      } else {
        onChangedAmountValue('',receivePageChangeNotifier);
      }
    });
    if (amountController.text.isEmpty) {
      onChangedAmountValue('',receivePageChangeNotifier);
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Container(
            color: settingsStore.isDarkTheme
                ? Color(0xff171720)
                : Color(0xffffffff),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35.0, right: 35.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height:
                                MediaQuery.of(context).size.height * 0.60 / 3,
                            width:
                                MediaQuery.of(context).size.height * 0.60 / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff1F1F28)
                                  : Color(0xffEDEDED),
                            ),
                            padding: EdgeInsets.all(18),
                            child: RepaintBoundary(
                              key: _globalKey,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(10),
                                child: QrImage(
                                  data: receivePageChangeNotifier.currentAddress +
                                      receivePageChangeNotifier.amountValue,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  tr(context).walletAddress,
                                  style: TextStyle(
                                      backgroundColor: Colors.transparent,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                      color: Color(0xff1BB51E)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: receivePageChangeNotifier.currentAddress));
                                  Toast.show(
                                    tr(context).copied,
                                    duration: Toast.lengthShort,
                                    // Toast duration (short or long)
                                    gravity: Toast.bottom,
                                    // Toast gravity (top, center, or bottom)
                                    webTexColor: settingsStore.isDarkTheme
                                        ? Colors.black
                                        : Colors.white,
                                    backgroundColor: settingsStore.isDarkTheme
                                        ? Colors.grey.shade50
                                        : Colors.grey.shade900,
                                  );
                                },
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                      'assets/images/new-images/copy.svg',
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff16161D),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Center(
                                          child: GestureDetector(
                                              child: Text(
                                                  receivePageChangeNotifier.currentAddress,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    backgroundColor: Colors.transparent,
                                                    fontSize: 11.0,
                                                    height: 1.5,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Color(
                                                        0xff82828D), //Theme.of(context).primaryTextTheme.headline6.color
                                                  ))))))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        tr(context).enterBdxToReceive,
                        style: TextStyle( backgroundColor: Colors.transparent,fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Form(
                      key: _formKey,
                      child: NewBeldexTextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
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
                        hintText: tr(context).enterAmount,
                        validator: (value) {
                          validateAmount(value ?? '',receivePageChangeNotifier);
                          if (receivePageChangeNotifier.errorMessage?.isNotEmpty ?? false) {
                            return receivePageChangeNotifier.errorMessage!;
                          } else {
                            return null;
                          }
                        },
                        controller: amountController,
                        onChanged: (val) {
                          print('amount value called automatically');
                          _globalKey.currentContext!.findRenderObject()!.reassemble();
                          if (amountController.text.isEmpty) {
                            onChangedAmountValue('',receivePageChangeNotifier);
                          }
                        },
                      )),
                ),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 15.0, right: 15.0, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff464657)
                                  : Color(0xffDADADA),
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            //SubAddressDropDownList(settingsStore: settingsStore,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () async {
                                   /* await showDialog<void>(
                                        context: context,
                                        builder: (_) {
                                          return SubAddressDropDownList(
                                            settingsStore: settingsStore,
                                            walletStore: walletStore,
                                            subAddressListStore:
                                                subAddressListStore,
                                            globalKey: _globalKey,
                                          );
                                        });*/
                                  },
                                  child: displayContainerWithoutWallet(context)),
                            ),
                            SizedBox(height: 15),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  /*showDialog<void>(
                                      context: context,
                                      builder: (context) {
                                        return SubAddressAlert(
                                            subAddressListStore:
                                                subAddressListStore);
                                      });*/
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 25.0,
                                      height: 25.0,
                                      child: SvgPicture.asset(
                                          'assets/images/new-images/plus_fill.svg',
                                          color: Color(0xff2979FB)),
                                    ),
                                    Text(
                                      tr(context).addSubAddress,
                                      style: TextStyle(
                                          backgroundColor: Colors.transparent,
                                          decoration: TextDecoration.underline,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff2979FB)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.20 / 3),
                Container(
                  margin: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () => _incrementCounter(
                        receivePageChangeNotifier.currentAddress, amountController.text),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xff0BA70F),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              tr(context).shareQr,
                              style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ))),
    );
  }

  Widget displayContainerWithWallet(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    getSubAddress(context);
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.19 / 3,
            decoration: BoxDecoration(
                color: settingsStore.isDarkTheme
                    ? Color(0xff292937)
                    : Color(0xffEDEDED),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 4.0, right: 6.0, top: 3.0, bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.all(8),
                        width: 20,
                        //height:mHeight*0.15/3,width: mHeight*0.20/3,
                        // margin:EdgeInsets.only(right:mHeight*0.03/3,),
                        child:
                            Icon(Icons.more_horiz, color: Colors.transparent)),
                    Expanded(
                        child: Center(
                      child: Text('$currentSubAddress',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff00DC00)
                                  : Color(0xff0BA70F))),
                    )),
                    Container(
                        child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ))
                  ],
                ))),
      ],
    );
  }

  Widget displayContainerWithoutWallet(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.19 / 3,
            decoration: BoxDecoration(
                color: settingsStore.isDarkTheme
                    ? Color(0xff292937)
                    : Color(0xffEDEDED),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 4.0, right: 6.0, top: 3.0, bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.all(8),
                        width: 20,
                        //height:mHeight*0.15/3,width: mHeight*0.20/3,
                        // margin:EdgeInsets.only(right:mHeight*0.03/3,),
                        child:
                        Icon(Icons.more_horiz, color: Colors.transparent)),
                    Expanded(
                        child: Center(
                          child: Text('Primary account',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff00DC00)
                                      : Color(0xff0BA70F))),
                        )),
                    Container(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ))
                  ],
                ))),
      ],
    );
  }

  void getSubAddress(BuildContext context) async {
    final subAddressListStore = Provider.of<SubaddressListStore>(context);
    final walletStore = Provider.of<WalletStore>(context);

    final prefs = await SharedPreferences.getInstance();
    bool isCurrent;
    setState(() {
      for (var i = 0; i < subAddressListStore.subaddresses.length; i++) {
        final subaddress = subAddressListStore.subaddresses[i];
        isCurrent = walletStore.subaddress.address == subaddress.address;
        final label =
            subaddress.label.isNotEmpty ? subaddress.label : subaddress.address;
        final address = subaddress.address;
        if (isCurrent) {
          prefs.setString('currentSubAddress', label.toString());
          prefs.setString('currentAddress', address);
        }
      }
      currentSubAddress = prefs.getString('currentSubAddress')! ?? '';
    });
  }

  void onChangedAmountValue(String value, ReceivePageChangeNotifier receivePageChangeNotifier) => receivePageChangeNotifier.setAmountValue(value.isNotEmpty ? '?tx_amount=$value' : '');

  void validateAmount(String amount, ReceivePageChangeNotifier receivePageChangeNotifier) {
    if (amount.isEmpty) {
      receivePageChangeNotifier.setIsValid(true);
    } else {
      final maxValue = 150000000.00000;
      final pattern = RegExp(r'^(([0-9]{1,9})(\.[0-9]{1,5})?$)|\.[0-9]{1,5}?$');

      if (pattern.hasMatch(amount)) {
        try {
          final dValue = double.parse(amount);
          receivePageChangeNotifier.setIsValid((dValue <= maxValue && dValue > 0));
        } catch (e) {
          receivePageChangeNotifier.setIsValid(false);
        }
      }else{
        receivePageChangeNotifier.setIsValid(false);
      }
    }

    receivePageChangeNotifier.setErrorMessage(receivePageChangeNotifier.isValid ? "" : tr(context).pleaseEnterAValidAmount);
  }

  Future<String> getCurrentAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentAddress') ?? '';
  }

////
  Widget _buildExitnodeListView(double mHeight) {
    final subAddressListStore = Provider.of<SubaddressListStore>(context);
    final walletStore = Provider.of<WalletStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    return subAddressListStore.subaddresses.length <= 1
        ? Container()
        : Material(
            color: Colors.transparent,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (overlayEntry != null) {
                  overlayEntry?.remove();
                  overlayEntry = null;
                }
              },
              child: Container(
                height: 200.0,
                margin: EdgeInsets.only(
                    top: mHeight * 2.080 / 3, //2.010
                    bottom: MediaQuery.of(context).size.height * 0.38 / 3,
                    left: mHeight * 0.15 / 3,
                    right: mHeight * 0.16 / 3),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.70 / 3,
                    width: MediaQuery.of(context).size.width * 2.7 / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: settingsStore.isDarkTheme
                          ? Color(0xff292937)
                          : Color(0xffEDEDED),
                    ),
                    child: Observer(
                      builder: (_) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: subAddressListStore.subaddresses.length,
                            itemBuilder: (BuildContext context, int i) {
                              // print("data inside listview ${exitData[index]}");
                              return Observer(builder: (context) {
                                final subaddress =
                                    subAddressListStore.subaddresses[i];
                                final isCurrent =
                                    walletStore.subaddress.address ==
                                        subaddress.address;
                                final label = subaddress.label.isNotEmpty
                                    ? subaddress.label
                                    : subaddress.address;
                                return InkWell(
                                  onTap: () async {
                                    if (overlayEntry != null) {
                                      overlayEntry?.remove();
                                      overlayEntry = null;
                                    }
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    walletStore.setSubaddress(subaddress);
                                    await prefs.setString(
                                        'currentSubAddress', label.toString());
                                    setState(() {
                                      currentSubAddress =
                                          prefs.getString('currentSubAddress')!;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.all(10),
                                        // decoration: BoxDecoration(
                                        //   border: Border(bottom: BorderSide(color: Colors.grey))
                                        // ),
                                        child: Text(
                                          label,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                              color: Color(
                                                  0xff0BA70F) //Theme.of(context).primaryTextTheme.caption.color,//Colors.white,//Theme.of(context).primaryTextTheme.headline5.color
                                              ),
                                        ),
                                      ),
                                      Divider(
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff454555)
                                            : Colors.grey[300],
                                      )
                                    ],
                                  ),
                                );
                              });
                            }
                            // _buildList(exitData[index]),
                            );
                      },
                    )),
                // ),
              ),
            ),
          );
  }
}

class NewBeldexTextField extends StatelessWidget {
  NewBeldexTextField(
      {this.enabled = true,
      this.hintText,
      this.keyboardType,
      this.controller,
      this.validator,
      this.inputFormatters,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode,
      this.onChanged});

  final bool enabled;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Card(
      color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED),
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.5, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: TextFormField(
          maxLength: 15,
          onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
          enabled: enabled,
          controller: controller,
          focusNode: focusNode,
          style: TextStyle(
            backgroundColor: Colors.transparent,
            fontSize: 16.0,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff77778B)
                      : Color(0xff6F6F6F),
                  fontWeight: FontWeight.w600),
              hintText: hintText,
              errorStyle: TextStyle(color: BeldexPalette.red),
              counterText: ''),
          validator: validator!,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class SubAddressDropDownList extends StatefulWidget {
  const SubAddressDropDownList(
      {Key? key,
      this.settingsStore,
      required this.walletStore,
      required this.subAddressListStore,
      required this.globalKey})
      : super(key: key);

  final SettingsStore? settingsStore;
  final WalletStore walletStore;
  final SubaddressListStore subAddressListStore;
  final GlobalKey globalKey;

  @override
  State<SubAddressDropDownList> createState() => _SubAddressDropDownListState();
}

class _SubAddressDropDownListState extends State<SubAddressDropDownList> {
  final _controller = ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(8),
      backgroundColor: widget.settingsStore?.isDarkTheme ?? false
          ? Color(0xff272733)
          : Color(0xffFFFFFF),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.class_outlined,
            color: Colors.transparent,
          ),
          Text(tr(context).subAddresses,
              style: TextStyle(backgroundColor: Colors.transparent,color:widget.settingsStore?.isDarkTheme ?? false
                  ? Color(0xffFFFFFF)
                  : Color(0xff222222),fontWeight: FontWeight.w800)),
          GestureDetector(
              onTap: () => Navigator.pop(context), child: Icon(Icons.close))
        ],
      )),
      content: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.80 / 3,
          decoration: BoxDecoration(
              color: widget.settingsStore?.isDarkTheme ?? false
                  ? Color(0xff272733)
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Expanded(
                child: RawScrollbar(
                  thumbVisibility: true,
                  controller: _controller,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemCount:
                            widget.subAddressListStore.subaddresses.length,
                        itemBuilder: (context, i) {
                          return Observer(builder: (_) {
                            final subaddress =
                                widget.subAddressListStore.subaddresses[i];
                            final isCurrent =
                                widget.walletStore.subaddress.address ==
                                    subaddress.address;
                            final label = subaddress.label.isNotEmpty
                                ? subaddress.label
                                : subaddress.address;
                            return InkWell(
                              onTap: isCurrent
                                  ? null
                                  : () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      widget.walletStore
                                          .setSubaddress(subaddress);
                                      widget.globalKey.currentContext!.findRenderObject()!.reassemble();
                                      Navigator.pop(context);
                                      await prefs.setString('currentSubAddress',
                                          label.toString());
                                      setState(() {
                                        currentSubAddress = prefs
                                            .getString('currentSubAddress')!;
                                      });
                                    },
                              child: isCurrent
                                  ? Card(
                                      elevation: 0,
                                      color: Color(0xff2979FB),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.all(15),
                                        child: Center(
                                          child: Text(
                                            label,
                                            style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w800,
                                              color: Colors
                                                  .white, //Colors.white,//Theme.of(context).primaryTextTheme.headline5.color
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.all(15),
                                      child: Center(
                                        child: Text(
                                          label,
                                          style: TextStyle(
                                            backgroundColor: Colors.transparent,
                                            fontSize: 16.0,
                                            color: Theme.of(context).primaryTextTheme.caption?.color, //Colors.white,//Theme.of(context).primaryTextTheme.headline5.color
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          });
                        }),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class ReceivePageChangeNotifier with ChangeNotifier {
  String amountValue = '';
  bool isValid = false;
  String? errorMessage;
  String currentAddress = '';

  void setAmountValue(String amountValue) {
    this.amountValue = amountValue;
    notifyListeners();
  }

  void setIsValid(bool status) {
    isValid = status;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
    notifyListeners();
  }

  void setCurrentAddress(String address){
    currentAddress = address;
    notifyListeners();
  }
}
