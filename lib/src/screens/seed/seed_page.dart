import 'package:provider/provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/stores/wallet_seed/wallet_seed_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';

class SeedPage extends BasePage {
  SeedPage({this.onCloseCallback});

  // static final image = Image.asset('assets/images/seed_image.png');
  static final image =
      Image.asset('assets/images/avatar4.png', height: 124, width: 400);

  @override
  bool get isModalBackButton => true;

  @override
  String get title => S.current.seed_title;

  final VoidCallback onCloseCallback;

  @override
  void onClose(BuildContext context) =>
      onCloseCallback != null ? onCloseCallback() : Navigator.of(context).pop();

  @override
  Widget leading(BuildContext context) {
    return onCloseCallback != null ? Offstage() : super.leading(context);
  }

  @override
  Widget body(BuildContext context) {
    final walletSeedStore = Provider.of<WalletSeedStore>(context);
    String _seed;

    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                 /* Image.asset(
                    'assets/images/avatar4.png',
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),*/ //image,
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0,bottom: 90.0),
                    child: Observer(builder: (_) {
                      _seed = walletSeedStore.seed;
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 10.0),
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  walletSeedStore.name ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryTextTheme.caption.color,//Theme.of(context).primaryTextTheme.button.color
                                  ),
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 35.0,
                                  bottom: 35.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: Column(
                                children: [
                                  Text(
                                    walletSeedStore.seed,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6
                                            .color),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              Share.text(
                                                  S.of(context).seed_share,
                                                  _seed,
                                                  'text/plain');
                                            },
                                            child: Container(
                                              width: 95,
                                              height: 43,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Theme.of(context).accentIconTheme.color,//Colors.black,
                                                    Theme.of(context).primaryTextTheme.subtitle2.backgroundColor,// Colors.grey[900],
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(5, 5),
                                                    blurRadius: 5,
                                                  )
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  S.of(context).save,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentTextTheme
                                                        .caption
                                                        .decorationColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ), /*Container(
                                          decoration: BoxDecoration(
                                            */ /*boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(5, 5),
                                                blurRadius: 10,
                                              )
                                            ],*/ /*
                                            borderRadius: BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black45,
                                                Colors.black38,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: PrimaryButton(
                                              onPressed: () => Share.text(
                                                  S.of(context).seed_share,
                                                  _seed,
                                                  'text/plain'),
                                              color: Colors
                                                  .transparent */ /*Theme.of(context)
                                                      .primaryTextTheme
                                                      .button
                                                      .backgroundColor*/ /*
                                              ,
                                              borderColor: Colors
                                                  .transparent */ /*Theme.of(context)
                                                      .primaryTextTheme
                                                      .button
                                                      .decorationColor*/ /*
                                              ,
                                              text: S.of(context).save),
                                        )*/
                                        ),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(
                                                  ClipboardData(text: _seed));
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                                ),
                                                content: Text(S
                                                    .of(context)
                                                    .copied_to_clipboard,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                                backgroundColor: Color.fromARGB(255, 46, 113, 43),
                                                duration: Duration(
                                                    milliseconds: 1500),
                                              ),);
                                              /*Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(S
                                                      .of(context)
                                                      .copied_to_clipboard),
                                                  backgroundColor: Colors.green,
                                                  duration: Duration(
                                                      milliseconds: 1500),
                                                ),
                                              );*/
                                            },
                                            child: Container(
                                              width: 95,
                                              height: 43,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Theme.of(context).accentIconTheme.color,//Colors.black,
                                                    Theme.of(context).primaryTextTheme.subtitle2.backgroundColor,//Colors.grey[900],
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(5, 5),
                                                    blurRadius: 5,
                                                  )
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  S.of(context).copy,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryTextTheme
                                                        .button
                                                        .backgroundColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ), /*Container(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Builder(
                                                  builder: (context) =>
                                                      PrimaryButton(
                                                          onPressed: () {
                                                            Clipboard.setData(
                                                                ClipboardData(
                                                                    text:
                                                                        _seed));
                                                            Scaffold.of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(S
                                                                    .of(context)
                                                                    .copied_to_clipboard),
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1500),
                                                              ),
                                                            );
                                                          },
                                                          text: S
                                                              .of(context)
                                                              .copy,
                                                          color: Theme.of(
                                                                  context)
                                                              .accentTextTheme
                                                              .caption
                                                              .backgroundColor,
                                                          borderColor: Theme.of(
                                                                  context)
                                                              .accentTextTheme
                                                              .caption
                                                              .decorationColor),
                                                ))*/
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  /*Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            child: Container(
                          padding: EdgeInsets.only(right: 8.0),
                          child: PrimaryButton(
                              onPressed: () => Share.text(
                                  S.of(context).seed_share,
                                  _seed,
                                  'text/plain'),
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .button
                                  .backgroundColor,
                              borderColor: Theme.of(context)
                                  .primaryTextTheme
                                  .button
                                  .decorationColor,
                              text: S.of(context).save),
                        )),
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Builder(
                                  builder: (context) => PrimaryButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                            ClipboardData(text: _seed));
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(S
                                                .of(context)
                                                .copied_to_clipboard),
                                            backgroundColor: Colors.green,
                                            duration:
                                                Duration(milliseconds: 1500),
                                          ),
                                        );
                                      },
                                      text: S.of(context).copy,
                                      color: Theme.of(context)
                                          .accentTextTheme
                                          .caption
                                          .backgroundColor,
                                      borderColor: Theme.of(context)
                                          .accentTextTheme
                                          .caption
                                          .decorationColor),
                                )))
                      ],
                    ),
                  )*/
                  onCloseCallback != null
                      ? SizedBox(
                          width: 250,
                          child: PrimaryButton(
                              onPressed: () => onClose(context),
                              text: S.of(context).restore_next,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .button
                                  .backgroundColor,
                              borderColor: Palette.darkGrey),
                        )
                      : Offstage()
                ],
              ),
            ),
          ),
          /*onCloseCallback != null
              ? PrimaryButton(
                  onPressed: () => onClose(context),
                  text: S.of(context).restore_next,
                  color: Palette.darkGrey,
                  borderColor: Palette.darkGrey)
              : Offstage()*/
        ],
      ),
    );
  }
}
