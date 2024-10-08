import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/stores/wallet_seed/wallet_seed_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:toast/toast.dart';

class SeedPage extends BasePage {
  SeedPage({required this.onCloseCallback,required this.showSeed});

  @override
  bool get isModalBackButton => true;

  @override
  String getTitle(AppLocalizations t) => !showSeed ? t.widgets_seed : t.recoverySeed;

  final VoidCallback onCloseCallback;
  final bool showSeed;

  @override
  void onClose(BuildContext context) =>
      !showSeed ? onCloseCallback() : Navigator.of(context).pop();

  @override
  Widget? leading(BuildContext context) {
    return !showSeed ? Offstage() : super.leading(context);
  }

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    return SeedDisplayWidget(
      onCloseCallback: onCloseCallback,
      showSeed: showSeed,
    );
  }
}

class SeedDisplayWidget extends StatefulWidget {
  SeedDisplayWidget({Key? key, this.onCloseCallback,required this.showSeed}) : super(key: key);

  VoidCallback? onCloseCallback;
  bool showSeed;

  @override
  State<SeedDisplayWidget> createState() => _SeedDisplayWidgetState();
}

class _SeedDisplayWidgetState extends State<SeedDisplayWidget> {
  bool isCopied = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    isCopied = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final walletSeedStore = Provider.of<WalletSeedStore>(context);
    String _seed;
    String? _isSeed;
    final _height = MediaQuery.of(context).size.height;
    ToastContext().init(context);
    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        child: Container(child: Observer(
          builder: (_) {
            _isSeed = walletSeedStore.seed;
            // _isSeed = null;
            return Center(
              child: _isSeed == '' || _isSeed == null
                  ? Padding(
                      padding: EdgeInsets.only(top: _height * 1 / 3),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: tr(context).note,
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                color: Color(0xffFF3131),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(
                                  text: tr(context)
                                      .youCantViewTheSeedBecauseYouveRestoredUsingKeys,
                                  style: TextStyle(
                                      backgroundColor: Colors.transparent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffD9D9D9)
                                          : Color(0xff909090)))
                            ]),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: _height * 0.20 / 3),
                        Observer(builder: (_) {
                          _seed = walletSeedStore.seed;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: tr(context).note,
                                      style: TextStyle(
                                          backgroundColor: Colors.transparent,
                                          color: Color(0xffFF3131),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      children: [
                                        TextSpan(
                                            text: tr(context)
                                                .neverShareYourSeedToAnyoneCheckYourSurroundingsTo,
                                            style: TextStyle(
                                                backgroundColor: Colors.transparent,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: settingsStore
                                                        .isDarkTheme
                                                    ? Color(0xffD9D9D9)
                                                    : Color(0xff909090)))
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: _height * 0.10 / 3,
                              ),
                              Text(
                                walletSeedStore.name,
                                style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height *
                                  //         0.50 /
                                  //         3,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff272733)
                                          : Color(0xffEDEDED),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(walletSeedStore.seed,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 15,
                                              color:
                                                  settingsStore.isDarkTheme
                                                      ? Color(0xffE2E2E2)
                                                      : Color(0xff373737))),
                                    ],
                                  )),
                              SizedBox(
                                height: _height * 0.10 / 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: !widget.showSeed
                                    ? Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: ElevatedButton(
                                                onPressed: !isCopied
                                                    ? () {
                                                        setState(() {
                                                          isCopied = true;
                                                        });
                                                        print(
                                                            ' copied value $isCopied');
                                                        Clipboard.setData(
                                                            ClipboardData(
                                                                text:
                                                                    _seed));
                                                        Toast.show(
                                                          tr(context)
                                                              .copied,
                                                          duration: Toast
                                                              .lengthShort,
                                                          // Toast duration (short or long)
                                                          gravity:
                                                              Toast.bottom,
                                                          // Toast gravity (top, center, or bottom)
                                                          textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white), // Text color
                                backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900, // Background color
                                                        );
                                                      }
                                                    : null,
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor: isCopied
                                                      ? settingsStore
                                                              .isDarkTheme
                                                          ? Color(
                                                              0xff272733)
                                                          : Color(
                                                              0xffE8E8E8)
                                                      : Color(0xff0BA70F),
                                                  padding:
                                                      EdgeInsets.all(12),
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Text(
                                                        tr(context)
                                                            .copySeed,
                                                        style: TextStyle(
                                                          backgroundColor: Colors.transparent,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                          color: isCopied
                                                              ? settingsStore
                                                                      .isDarkTheme
                                                                  ? Color(
                                                                      0xff6C6C78)
                                                                  : Color(
                                                                      0xffB2B2B6)
                                                              : Colors
                                                                  .white,
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                                  .only(
                                                              left: 8.0),
                                                      child: Icon(
                                                        Icons.copy,
                                                        color: isCopied
                                                            ? settingsStore
                                                                    .isDarkTheme
                                                                ? Color(
                                                                    0xff6C6C78)
                                                                : Color(
                                                                    0xffB2B2B6)
                                                            : Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Share.share(_seed,subject: tr(context).seed_share,);
                                              },
                                              style:
                                                  ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xff2979FB),
                                                padding: EdgeInsets.all(12),
                                                shape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                ),
                                              ),
                                              child: Text(
                                                  tr(context).save,
                                                  style: TextStyle(
                                                      backgroundColor: Colors.transparent,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  isCopied = true;
                                                });

                                                print(
                                                    ' copied value $isCopied');
                                                Clipboard.setData(
                                                    ClipboardData(
                                                        text: _seed));
                                                Toast.show(
                                                  tr(context).copied,
                                                  duration:
                                                      Toast.lengthShort,
                                                  // Toast duration (short or long)
                                                  gravity: Toast.bottom,
                                                  // Toast gravity (top, center, or bottom)
                                                  textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white), // Text color
                                backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,
                                                );
                                              },
                                              style:
                                                  ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xff0BA70F),
                                                padding: EdgeInsets.all(12),
                                                shape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                ),
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Text(
                                                        tr(context)
                                                            .copySeed,
                                                        style: TextStyle(
                                                          backgroundColor: Colors.transparent,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                          color:
                                                              Colors.white,
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                                  .only(
                                                              left: 8.0),
                                                      child: Icon(
                                                        Icons.copy,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Share.share(_seed,subject: tr(context).seed_share);
                                              },
                                              style:
                                                  ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xff2979FB),
                                                padding: EdgeInsets.all(12),
                                                shape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                ),
                                              ),
                                              child: Text(
                                                  tr(context).save,
                                                  style: TextStyle(
                                                      backgroundColor: Colors.transparent,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
            );
          },
        )),
      ),
      bottomSection:  Column(children: [
        !widget.showSeed && !isCopied || _isSeed != null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tr(context).copyAndSaveTheSeedToContinue,
            style: TextStyle(backgroundColor: Colors.transparent,fontSize: 15),
          ),
        )
            : Container(),
        Row(children: [
          Expanded(
            child: !widget.showSeed || _isSeed != null
                ? Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: isCopied
                    ? () {
                  !widget.showSeed
                      ? widget.onCloseCallback!()
                      : Navigator.of(context).pop();
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCopied
                      ? Color(0xff0BA70F)
                      : settingsStore.isDarkTheme
                      ? Color(0xff272733)
                      : Color(0xffE8E8E8),
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(tr(context).continue_text,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        color: isCopied
                            ? Color(0xffffffff)
                            : settingsStore.isDarkTheme
                            ? Color(0xff6C6C78)
                            : Color(0xffB2B2B6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            )
                : Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0BA70F),
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(tr(context).ok,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        color: Color(0xffffffff),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ])
      ]),
    );
  }
}
