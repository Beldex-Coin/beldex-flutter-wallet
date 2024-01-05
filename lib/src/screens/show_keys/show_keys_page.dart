import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_keys_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:toast/toast.dart';

import '../../../l10n.dart';

class ShowKeysPage extends BasePage {
  @override
  bool get isModalBackButton => true;

  @override
  String getTitle(AppLocalizations t) => t.wallet_keys;

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
    final settingsStore = Provider.of<SettingsStore>(context);
    //setPageSecure();
    return Container(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5, right: 5),
        child: Observer(
          builder: (_) {
            final keysMap = {
              tr(context).view_key_public: walletKeysStore.publicViewKey,
              tr(context).view_key_private: walletKeysStore.privateViewKey,
              tr(context).spend_key_public: walletKeysStore.publicSpendKey,
              tr(context).spend_key_private: walletKeysStore.privateSpendKey
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
                                tr(context).copied,
                                duration: Toast
                                    .lengthShort, // Toast duration (short or long)
                                gravity: Toast
                                    .bottom, // Toast gravity (top, center, or bottom)
                                webTexColor:settingsStore.isDarkTheme ? Colors.black : Colors.white, // Text color
                                backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,
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
                                    color: Theme.of(context).primaryTextTheme.caption?.color,
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
