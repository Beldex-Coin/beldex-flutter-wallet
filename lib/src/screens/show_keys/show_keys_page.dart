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
 Widget trailing(BuildContext context){
  return Container();
 }

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
                          Text('$key:', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w800)),
                          InkWell(
                            onTap: (){
                              Clipboard.setData(ClipboardData(
                            text: keysMap.values.elementAt(index)));
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                           margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.30/3,
                                                           left: MediaQuery.of(context).size.height*0.30/3,
                                                           right: MediaQuery.of(context).size.height*0.30/3
                                                           ),
                                                            elevation:0, //5,
                                                            behavior: SnackBarBehavior.floating,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0) //only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                                            ),
                                                            content: Text(S
                                                                .of(context)
                                                                .copied,style: TextStyle(color: Color(0xff0EB212),fontWeight:FontWeight.w700,fontSize:15) ,textAlign: TextAlign.center,),
                                                            backgroundColor: Color(0xff0BA70F).withOpacity(0.10), //.fromARGB(255, 46, 113, 43),
                                                            duration: Duration(
                                                                milliseconds: 1500),
                                                          ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Icon(Icons.copy,size: 20,),
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
                                    fontFamily: 'Poppins',
                                      fontSize: 13.0, color: Theme.of(context).primaryTextTheme.caption.color,)),
                            ),
                            Flexible(
                              flex:1,
                              child: Container())
                            
                          ],
                        ),
                      ));
                });
          },
        ));
  }
}
