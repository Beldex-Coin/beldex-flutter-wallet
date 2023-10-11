import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_keys_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
//import 'package:flutter_windowmanager/flutter_windowmanager.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';

class ShowKeysPage extends BasePage {
  @override
  bool get isModalBackButton => true;

  @override
  String get title => S.current.wallet_keys;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

// void setPageSecure()async{
//    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
// }

  @override
  Widget body(BuildContext context) {
    final walletKeysStore = Provider.of<WalletKeysStore>(context);
    //setPageSecure();
    return Container(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5, right: 5),
        child: Observer(
          builder: (_) {
            final keysMap = {
              S.of(context).view_key_public: walletKeysStore.publicViewKey,
              S.of(context).view_key_private: walletKeysStore.privateViewKey,
              S.of(context).spend_key_public: walletKeysStore.publicSpendKey,
              S.of(context).spend_key_private: walletKeysStore.privateSpendKey
            };

            return ListView.separated(
                separatorBuilder: (_, __) => Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                        color: Theme.of(context).dividerTheme.color,
                        height: 1.0)),
                itemCount: keysMap.length,
                itemBuilder: (BuildContext context, int index) {
                  final key = keysMap.keys.elementAt(index);
                  final value = keysMap.values.elementAt(index);

                  return ListTile(
                      contentPadding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      // onTap: () {
                      //   Clipboard.setData(ClipboardData(
                      //       text: keysMap.values.elementAt(index)));
                      //   Scaffold.of(context).showSnackBar(SnackBar(
                      //     content: Text(
                      //       S.of(context).copied_key_to_clipboard(key),
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     backgroundColor: Colors.green,
                      //     duration: Duration(seconds: 1),
                      //   ));
                      // },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$key:',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w800)),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: keysMap.values.elementAt(index)));
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

                              //      Scaffold.of(context).showSnackBar(SnackBar(
                              //   content: Text(
                              //     S.of(context).copied_key_to_clipboard(key),
                              //     textAlign: TextAlign.center,
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   backgroundColor: Color(0xff0BA70F),
                              //   duration: Duration(seconds: 1),
                              // ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.copy,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(value,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .caption
                                        .color,
                                  )),
                            ),
                            Flexible(flex: 1, child: Container())
                          ],
                        ),
                      ));
                });
          },
        ));
  }
}
