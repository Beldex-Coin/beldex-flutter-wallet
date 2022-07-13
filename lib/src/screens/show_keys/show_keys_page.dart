import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_keys_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';

class ShowKeysPage extends BasePage {
  @override
  bool get isModalBackButton => true;

  @override
  String get title => S.current.wallet_keys;

  @override
  Widget body(BuildContext context) {
    final walletKeysStore = Provider.of<WalletKeysStore>(context);

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
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text: keysMap.values.elementAt(index)));
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            S.of(context).copied_key_to_clipboard(key),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ));
                      },
                      title: Text('$key:', style: TextStyle(fontSize: 16.0)),
                      subtitle: Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(value,
                            style: TextStyle(
                                fontSize: 16.0, color: Theme.of(context).primaryTextTheme.caption.color,)),
                      ));
                });
          },
        ));
  }
}
