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
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../util/clipboard_helper.dart';

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
  Widget? leading(BuildContext context) {
     return leadingIcon(context);
  }

  @override
  Widget body(BuildContext context) =>
      SingleChildScrollView(child: ReceiveBody());
}

class ReceiveBody extends StatefulWidget {
  @override
  ReceiveBodyState createState() => ReceiveBodyState();
}

class ReceiveBodyState extends State<ReceiveBody> {
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _addressLoaded = false;

  @override
  void initState() {
    super.initState();
    amountController.addListener(_onAmountChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_addressLoaded) return;
    _addressLoaded = true;

    final receivePageChangeNotifier =
        Provider.of<ReceivePageChangeNotifier>(context, listen: false);
    final walletStore = Provider.of<WalletStore>(context, listen: false);
    final initialAddress = walletStore.subaddress.address.isNotEmpty
        ? walletStore.subaddress.address
        : '';
    final initialAddressLabel = walletStore.subaddress.label.isNotEmpty
        ? walletStore.subaddress.label
        : '';

    if (initialAddress.isNotEmpty) {
      receivePageChangeNotifier.currentAddress = initialAddress;
    }
    if (initialAddressLabel.isNotEmpty) {
      receivePageChangeNotifier.currentAddressLabel = initialAddressLabel;
    }

    getCurrentAddress(walletStore).then((value) {
      if (!mounted) return;
      if (value.isNotEmpty && value != initialAddress) {
        receivePageChangeNotifier.setCurrentAddress(value);
      }
    });

    getCurrentAddressLabel(walletStore).then((value) {
      if (!mounted) return;
      if (value.isNotEmpty && value != initialAddressLabel) {
        receivePageChangeNotifier.setCurrentAddressLabel(value);
      }
    });
  }

  void _onAmountChanged() {
    final syncStore = Provider.of<SyncStore>(context, listen: false);
    final isSynced = syncStore.status is SyncedSyncStatus ||
        syncStore.status.blocksLeft == 0;
    if (isSynced) {
      final walletStore = Provider.of<WalletStore>(context, listen: false);
      if (_formKey.currentState?.validate() ?? false) {
        walletStore.onChangedAmountValue(amountController.text);
      } else {
        walletStore.onChangedAmountValue('');
      }
    } else {
      final receivePageChangeNotifier =
          Provider.of<ReceivePageChangeNotifier>(context, listen: false);
      if (_formKey.currentState?.validate() ?? false) {
        onChangedAmountValue(amountController.text, receivePageChangeNotifier);
      } else {
        onChangedAmountValue('', receivePageChangeNotifier);
      }
    }
  }

  @override
  void dispose() {
    amountController.removeListener(_onAmountChanged);
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

      await Share.shareXFiles(
          [XFile(filePath,mimeType: 'image/jpeg',name: address)],
          text: address,
          subject: 'Share'
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
                  padding: EdgeInsetsDirectional.only(start: 35.0, end: 35.0),
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
                              margin: EdgeInsetsDirectional.only(bottom: 10),
                              height:
                                  MediaQuery.sizeOf(context).height * 0.60 / 3,
                              width:
                                  MediaQuery.sizeOf(context).height * 0.60 / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff1F1F28)
                                    : Color(0xffEDEDED),
                              ),
                              padding: EdgeInsetsDirectional.all(18),
                              child: RepaintBoundary(
                                key: _globalKey,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsetsDirectional.all(10),
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
                                  padding: const EdgeInsetsDirectional.only(end: 8.0),
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
                                  onTap: () async {
                                    await ClipboardHelper.copyWithAutoClear(walletStore.subaddress.address);
                                    await Fluttertoast.showToast(
                                      msg: tr(context).copied,
                                      toastLength: Toast.LENGTH_SHORT,
                                      // Toast duration (short or long)
                                      gravity: ToastGravity.BOTTOM,
                                      // Toast gravity (top, center, or bottom)
                                      textColor: settingsStore.isDarkTheme ? Colors.black : Colors.white,
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
                                        colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff16161D), BlendMode.srcIn),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsetsDirectional.only(top: 20.0),
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
                  margin: EdgeInsetsDirectional.only(top: 20, start: 20, bottom: 15),
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
                  padding: EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
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
                        margin: EdgeInsetsDirectional.only(
                            top: 10, start: 15.0, end: 15.0, bottom: 10),
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
                              padding: const EdgeInsetsDirectional.all(8.0),
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
                              margin: EdgeInsetsDirectional.only(
                                  start: 10, end: 10, bottom: 20),
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
                                      margin: EdgeInsetsDirectional.only(end: 10),
                                      width: 25.0,
                                      height: 25.0,
                                      child: SvgPicture.asset(
                                          'assets/images/new-images/plus_fill.svg',
                                          colorFilter: ColorFilter.mode(Color(0xff2979FB), BlendMode.srcIn)),
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
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.20 / 3),
                Container(
                  margin: EdgeInsetsDirectional.all(15),
                  child: InkWell(
                    onTap: () => _incrementCounter(
                        walletStore.subaddress.address, amountController.text),
                    child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xff0BA70F),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Colors.white),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 8.0),
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
    final walletStore = Provider.of<WalletStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final currentAddress = walletStore.subaddress.address.isNotEmpty
        ? walletStore.subaddress.address
        : receivePageChangeNotifier.currentAddress;
    final selectedLabel = walletStore.subaddress.label.isNotEmpty
        ? walletStore.subaddress.label
        : receivePageChangeNotifier.currentAddressLabel;
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
                  padding: EdgeInsetsDirectional.only(start: 35.0, end: 35.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsetsDirectional.only(bottom: 10),
                            height:
                                MediaQuery.sizeOf(context).height * 0.60 / 3,
                            width:
                                MediaQuery.sizeOf(context).height * 0.60 / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff1F1F28)
                                  : Color(0xffEDEDED),
                            ),
                            padding: EdgeInsetsDirectional.all(18),
                            child: RepaintBoundary(
                              key: _globalKey,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsetsDirectional.all(10),
                                child: QrImage(
                                  data: currentAddress +
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
                                padding: const EdgeInsetsDirectional.only(end: 8.0),
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
                                onTap: () async {
                                  await ClipboardHelper.copyWithAutoClear(currentAddress);
                                  await Fluttertoast.showToast(
                                    msg: tr(context).copied,
                                    toastLength: Toast.LENGTH_SHORT,
                                    // Toast duration (short or long)
                                    gravity: ToastGravity.BOTTOM,
                                    // Toast gravity (top, center, or bottom)
                                    textColor: settingsStore.isDarkTheme
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
                                      colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff16161D), BlendMode.srcIn),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsetsDirectional.only(top: 20.0),
                                      child: Center(
                                          child: GestureDetector(
                                              child: Text(
                                                  currentAddress,
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
                  margin: EdgeInsetsDirectional.only(top: 20, start: 20, bottom: 15),
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
                  padding: EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
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
                        margin: EdgeInsetsDirectional.only(
                            top: 10, start: 15.0, end: 15.0, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff464657)
                                  : Color(0xffDADADA),
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.all(8.0),
                              child: GestureDetector(
                                  onTap: () async {},
                                  child: displayContainerWithoutWallet(context, selectedLabel)),
                            ),
                            SizedBox(height: 15),
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                  start: 10, end: 10, bottom: 20),
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsetsDirectional.only(end: 10),
                                      width: 25.0,
                                      height: 25.0,
                                      child: SvgPicture.asset(
                                          'assets/images/new-images/plus_fill.svg',
                                          colorFilter: ColorFilter.mode(Color(0xff2979FB), BlendMode.srcIn)),
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
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.20 / 3),
                Container(
                  margin: EdgeInsetsDirectional.all(15),
                  child: InkWell(
                    onTap: () => _incrementCounter(
                        currentAddress, amountController.text),
                    child: Container(
                      padding: EdgeInsetsDirectional.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xff0BA70F),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Colors.white),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 8.0),
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
    final walletStore = Provider.of<WalletStore>(context);
    final selectedLabel = walletStore.subaddress.label.isNotEmpty
        ? walletStore.subaddress.label
        : walletStore.subaddress.address;

    return Stack(
      children: [
        Container(
            height: MediaQuery.sizeOf(context).height * 0.19 / 3,
            decoration: BoxDecoration(
                color: settingsStore.isDarkTheme
                    ? Color(0xff292937)
                    : Color(0xffEDEDED),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 4.0, end: 6.0, top: 3.0, bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsetsDirectional.all(8),
                        width: 20,
                        child:
                            Icon(Icons.more_horiz, color: Colors.transparent)),
                    Expanded(
                        child: Center(
                      child: Text(selectedLabel,
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

  Widget displayContainerWithoutWallet(BuildContext context, String selectedLabel) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Stack(
      children: [
        Container(
            height: MediaQuery.sizeOf(context).height * 0.19 / 3,
            decoration: BoxDecoration(
                color: settingsStore.isDarkTheme
                    ? Color(0xff292937)
                    : Color(0xffEDEDED),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 4.0, end: 6.0, top: 3.0, bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsetsDirectional.all(8),
                        width: 20,
                        //height:mHeight*0.15/3,width: mHeight*0.20/3,
                        // margin:EdgeInsetsDirectional.only(end:mHeight*0.03/3,),
                        child:
                        Icon(Icons.more_horiz, color: Colors.transparent)),
                    Expanded(
                        child: Center(
                          child: Text(selectedLabel,
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

  Future<String> getCurrentAddress(WalletStore walletStore) async {
    if (walletStore.subaddress.address.isNotEmpty) {
      return walletStore.subaddress.address;
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentAddress') ?? '';
  }

  Future<String> getCurrentAddressLabel(WalletStore walletStore) async {
    if (walletStore.subaddress.label.isNotEmpty) {
      return walletStore.subaddress.label;
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentSubAddress') ?? '';
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
        padding: const EdgeInsetsDirectional.only(start: 25.0),
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
              errorStyle: TextStyle(backgroundColor: Colors.transparent, color: BeldexPalette.red),
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
          height: MediaQuery.sizeOf(context).height * 0.80 / 3,
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
                    padding: const EdgeInsetsDirectional.only(end: 5.0),
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
                                      await prefs.setString(
                                          'currentAddress', subaddress.address);
                                    },
                              child: isCurrent
                                  ? Card(
                                      elevation: 0,
                                      color: Color(0xff2979FB),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        margin: EdgeInsetsDirectional.only(start: 10),
                                        padding: EdgeInsetsDirectional.all(15),
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
                                      margin: EdgeInsetsDirectional.only(start: 10),
                                      padding: EdgeInsetsDirectional.all(15),
                                      child: Center(
                                        child: Text(
                                          label,
                                          style: TextStyle(
                                            backgroundColor: Colors.transparent,
                                            fontSize: 16.0,
                                            color: Theme.of(context).primaryTextTheme.bodySmall?.color, //Colors.white,//Theme.of(context).primaryTextTheme.headline5.color
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
  String currentAddressLabel = '';

  void setAmountValue(String amountValue) {
    if (this.amountValue == amountValue) return;
    this.amountValue = amountValue;
    notifyListeners();
  }

  void setIsValid(bool status) {
    isValid = status;
  }

  void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
  }

  void setCurrentAddress(String address){
    if (currentAddress == address) return;
    currentAddress = address;
    notifyListeners();
  }

  void setCurrentAddressLabel(String label){
    if (currentAddressLabel == label) return;
    currentAddressLabel = label;
    notifyListeners();
  }
}
