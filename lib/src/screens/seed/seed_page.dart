import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:provider/provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/wallet_seed/wallet_seed_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:toast/toast.dart';

class SeedPage extends BasePage {
  SeedPage({this.onCloseCallback});

  @override
  bool get isModalBackButton => true;

  @override
  String get title =>
      onCloseCallback != null ? S.current.widgets_seed : S.current.recoverySeed;

  final VoidCallback onCloseCallback;

  @override
  void onClose(BuildContext context) =>
      onCloseCallback != null ? onCloseCallback() : Navigator.of(context).pop();

  @override
  Widget leading(BuildContext context) {
    return onCloseCallback != null ? Offstage() : super.leading(context);
  }

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    return SeedDisplayWidget(
      onCloseCallback: onCloseCallback,
    );
  }
}

class SeedDisplayWidget extends StatefulWidget {
  SeedDisplayWidget({Key key, this.onCloseCallback}) : super(key: key);

  VoidCallback onCloseCallback;

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
    String _isSeed;
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
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
                                text: S.of(context).note,
                                style: TextStyle(
                                    color: Color(0xffFF3131),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                      text: S
                                          .of(context)
                                          .youCantViewTheSeedBecauseYouveRestoredUsingKeys,
                                      style: TextStyle(
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
                                          text: S.of(context).note,
                                          style: TextStyle(
                                              color: Color(0xffFF3131),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                          children: [
                                            TextSpan(
                                                text: S
                                                    .of(context)
                                                    .neverShareYourSeedToAnyoneCheckYourSurroundingsTo,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        settingsStore.isDarkTheme
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
                                                  fontSize: 15,
                                                  color: settingsStore.isDarkTheme
                                                      ? Color(0xffE2E2E2)
                                                      : Color(0xff373737))),
                                        ],
                                      )),
                                  SizedBox(
                                    height: _height * 0.10 / 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: widget.onCloseCallback != null
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
                                                                    text: _seed));
                                                            Toast.show(
                                                              S
                                                                  .of(context)
                                                                  .copied,
                                                              context,
                                                              duration: Toast
                                                                  .LENGTH_SHORT, // Toast duration (short or long)
                                                              gravity: Toast
                                                                  .BOTTOM, // Toast gravity (top, center, or bottom)
                                                              textColor: Colors
                                                                  .white, // Text color
                                                              backgroundColor: Color(
                                                                  0xff0BA70F), // Background color
                                                            );

                                                            // Scaffold.of(context)
                                                            //     .showSnackBar(
                                                            //         SnackBar(
                                                            //   content: Text(
                                                            //     S
                                                            //         .of(context)
                                                            //         .copied,
                                                            //     textAlign:
                                                            //         TextAlign
                                                            //             .center,
                                                            //     style: TextStyle(
                                                            //         color: Colors
                                                            //             .white),
                                                            //   ),
                                                            //   backgroundColor:
                                                            //       Color(
                                                            //           0xff0BA70F),
                                                            //   duration: Duration(
                                                            //       seconds: 1),
                                                            // ));
                                                          }
                                                        : null,
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                      primary: isCopied
                                                          ? settingsStore
                                                                  .isDarkTheme
                                                              ? Color(0xff272733)
                                                              : Color(0xffE8E8E8)
                                                          : Color(0xff0BA70F),
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
                                                            S
                                                                .of(context)
                                                                .copySeed,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: isCopied
                                                                  ? settingsStore
                                                                          .isDarkTheme
                                                                      ? Color(
                                                                          0xff6C6C78)
                                                                      : Color(
                                                                          0xffB2B2B6)
                                                                  : Colors.white,
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
                                                    Share.text(
                                                        S.of(context).seed_share,
                                                        _seed,
                                                        'text/plain');
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Color(0xff2979FB),
                                                    padding: EdgeInsets.all(12),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  child: Text(S.of(context).save,
                                                      style: TextStyle(
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
                                  S.of(context).copied,
                                  context,
                                  duration: Toast
                                      .LENGTH_SHORT, // Toast duration (short or long)
                                  gravity: Toast
                                      .BOTTOM, // Toast gravity (top, center, or bottom)
                                  textColor: Colors.white, // Text color
                                  backgroundColor:
                                      Color(0xff0BA70F), // Background color
                                );
                                                    // Scaffold.of(context)
                                                    //     .showSnackBar(SnackBar(
                                                    //   content: Text(
                                                    //     S.of(context).copied,
                                                    //     textAlign:
                                                    //         TextAlign.center,
                                                    //     style: TextStyle(
                                                    //         color: Colors.white),
                                                    //   ),
                                                    //   backgroundColor:
                                                    //       Color(0xff0BA70F),
                                                    //   duration:
                                                    //       Duration(seconds: 1),
                                                    // ));
                                                    // ScaffoldMessenger.of(
                                                    //         context)
                                                    //     .showSnackBar(SnackBar(
                                                    //   margin: EdgeInsets.only(
                                                    //       bottom: MediaQuery.of(
                                                    //                   context)
                                                    //               .size
                                                    //               .height *
                                                    //           0.30 /
                                                    //           3,
                                                    //       left: MediaQuery.of(
                                                    //                   context)
                                                    //               .size
                                                    //               .height *
                                                    //           0.30 /
                                                    //           3,
                                                    //       right: MediaQuery.of(
                                                    //                   context)
                                                    //               .size
                                                    //               .height *
                                                    //           0.30 /
                                                    //           3),
                                                    //   elevation: 0,
                                                    //   behavior: SnackBarBehavior
                                                    //       .floating,
                                                    //   shape:
                                                    //       RoundedRectangleBorder(
                                                    //           borderRadius:
                                                    //               BorderRadius
                                                    //                   .circular(
                                                    //                       15.0)),
                                                    //   content: Text(
                                                    //     S.of(context).copied,
                                                    //     style: TextStyle(
                                                    //         color: Color(
                                                    //             0xff0EB212),
                                                    //         fontWeight:
                                                    //             FontWeight.w700,
                                                    //         fontSize: 15),
                                                    //     textAlign:
                                                    //         TextAlign.center,
                                                    //   ),
                                                    //   backgroundColor: Color(
                                                    //           0xff0BA70F)
                                                    //       .withOpacity(0.10),
                                                    //   duration: Duration(
                                                    //       milliseconds: 1500),
                                                    // ));
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Color(0xff0BA70F),
                                                    padding: EdgeInsets.all(12),
                                                    shape: RoundedRectangleBorder(
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
                                                            S
                                                                .of(context)
                                                                .copySeed,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.white,
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
                                                    Share.text(
                                                        S.of(context).seed_share,
                                                        _seed,
                                                        'text/plain');
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Color(0xff2979FB),
                                                    padding: EdgeInsets.all(12),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  child: Text(S.of(context).save,
                                                      style: TextStyle(
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
                            // SizedBox(
                            //   height:
                            //       _height * 0.54 / 3,
                            // ),
                            // widget.onCloseCallback != null && !isCopied
                            //     ? Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Text(
                            //           S
                            //               .of(context)
                            //               .copyAndSaveTheSeedToContinue,
                            //           style: TextStyle(fontSize: 15),
                            //         ),
                            //       )
                            //     : Container(),
                            // widget.onCloseCallback != null
                            //     ? Container(
                            //         width: _width *
                            //             2.6 /
                            //             3,
                            //         child: ElevatedButton(
                            //           onPressed: isCopied
                            //               ? () {
                            //                   widget.onCloseCallback != null
                            //                       ? widget.onCloseCallback()
                            //                       : Navigator.of(context).pop();
                            //                 }
                            //               : null,
                            //           style: ElevatedButton.styleFrom(
                            //             primary: isCopied
                            //                 ? Color(0xff0BA70F)
                            //                 : settingsStore.isDarkTheme
                            //                     ? Color(0xff272733)
                            //                     : Color(0xffE8E8E8),
                            //             padding: EdgeInsets.all(15),
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //           ),
                            //           child: Text(S.of(context).continue_text,
                            //               style: TextStyle(
                            //                   color: isCopied
                            //                       ? Color(0xffffffff)
                            //                       : settingsStore.isDarkTheme
                            //                           ? Color(0xff6C6C78)
                            //                           : Color(0xffB2B2B6),
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.bold)),
                            //         ),
                            //       )
                            //     : Container(
                            //         width: _width *
                            //             2.6 /
                            //             3,
                            //         child: ElevatedButton(
                            //           onPressed: () =>
                            //               Navigator.of(context).pop(),
                            //           style: ElevatedButton.styleFrom(
                            //             primary: Color(0xff0BA70F),
                            //             padding: EdgeInsets.all(15),
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //           ),
                            //           child: Text(S.of(context).ok,
                            //               style: TextStyle(
                            //                   color: Color(0xffffffff),
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.bold)),
                            //         ),
                            //       ),
                          ],
                        ),
                );
              },
            )),
          ),
          Column(children: [
            // _isSeed == '' || _isSeed == null ?
            //  Container()
            // :
            widget.onCloseCallback != null && !isCopied || _isSeed != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).copyAndSaveTheSeedToContinue,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : Container(),
            Row(children: [
              // _isSeed == '' || _isSeed == null ?
              // Expanded(
              //   child: Container(
              //                         margin:EdgeInsets.all(10),
              //                           // width: _width *
              //                           //     2.6 /
              //                           //     3,
              //                           child: ElevatedButton(
              //                             onPressed: () =>
              //                                 Navigator.of(context).pop(),
              //                             style: ElevatedButton.styleFrom(
              //                               primary: Color(0xff0BA70F),
              //                               padding: EdgeInsets.all(15),
              //                               shape: RoundedRectangleBorder(
              //                                 borderRadius:
              //                                     BorderRadius.circular(10),
              //                               ),
              //                             ),
              //                             child: Text(S.of(context).ok,
              //                                 style: TextStyle(
              //                                     color: Color(0xffffffff),
              //                                     fontSize: 16,
              //                                     fontWeight: FontWeight.bold)),
              //                           ),
              //                         ),
              // )
              // :
              Expanded(
                // flex:2,
                child: widget.onCloseCallback != null || _isSeed != null
                    ? Container(
                        margin: EdgeInsets.all(10),
                        // width: _width *
                        //     2.6 /
                        //     3,
                        child: ElevatedButton(
                          onPressed: isCopied
                              ? () {
                                  widget.onCloseCallback != null
                                      ? widget.onCloseCallback()
                                      : Navigator.of(context).pop();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: isCopied
                                ? Color(0xff0BA70F)
                                : settingsStore.isDarkTheme
                                    ? Color(0xff272733)
                                    : Color(0xffE8E8E8),
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(S.of(context).continue_text,
                              style: TextStyle(
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
                        // width: _width *
                        //     2.6 /
                        //     3,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff0BA70F),
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(S.of(context).ok,
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
              )
            ])
            // widget.onCloseCallback != null
            //                         ? Container(
            //                             // width: _width *
            //                             //     2.6 /
            //                             //     3,
            //                             child: ElevatedButton(
            //                               onPressed: isCopied
            //                                   ? () {
            //                                       widget.onCloseCallback != null
            //                                           ? widget.onCloseCallback()
            //                                           : Navigator.of(context).pop();
            //                                     }
            //                                   : null,
            //                               style: ElevatedButton.styleFrom(
            //                                 primary: isCopied
            //                                     ? Color(0xff0BA70F)
            //                                     : settingsStore.isDarkTheme
            //                                         ? Color(0xff272733)
            //                                         : Color(0xffE8E8E8),
            //                                 padding: EdgeInsets.all(15),
            //                                 shape: RoundedRectangleBorder(
            //                                   borderRadius:
            //                                       BorderRadius.circular(10),
            //                                 ),
            //                               ),
            //                               child: Text(S.of(context).continue_text,
            //                                   style: TextStyle(
            //                                       color: isCopied
            //                                           ? Color(0xffffffff)
            //                                           : settingsStore.isDarkTheme
            //                                               ? Color(0xff6C6C78)
            //                                               : Color(0xffB2B2B6),
            //                                       fontSize: 16,
            //                                       fontWeight: FontWeight.bold)),
            //                             ),
            //                           )
            //                         : Container(
            //                             width: _width *
            //                                 2.6 /
            //                                 3,
            //                             child: ElevatedButton(
            //                               onPressed: () =>
            //                                   Navigator.of(context).pop(),
            //                               style: ElevatedButton.styleFrom(
            //                                 primary: Color(0xff0BA70F),
            //                                 padding: EdgeInsets.all(15),
            //                                 shape: RoundedRectangleBorder(
            //                                   borderRadius:
            //                                       BorderRadius.circular(10),
            //                                 ),
            //                               ),
            //                               child: Text(S.of(context).ok,
            //                                   style: TextStyle(
            //                                       color: Color(0xffffffff),
            //                                       fontSize: 16,
            //                                       fontWeight: FontWeight.bold)),
            //                             ),
            //                           ),
          ])
        ],
      ),
    );
  }
}
