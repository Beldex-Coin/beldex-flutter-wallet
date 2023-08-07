
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/wallet_list/wallet_menu.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';
class WalletAlertDialog<Item extends int> extends StatefulWidget {
  final Function(Item) onItemSelected;
  WalletAlertDialog({ Key key, this.onItemSelected}) : super(key: key);

  @override
  State<WalletAlertDialog> createState() => _WalletAlertDialogState();
}

class _WalletAlertDialogState extends State<WalletAlertDialog> {

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(child: Text('Change wallet',style: TextStyle(fontWeight:FontWeight.w800))),
      backgroundColor:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(onPressed: (){
            widget.onItemSelected(0);
          },
            elevation: 0,
            color: Color(0xff0BA70F),
            height: MediaQuery.of(context).size.height*0.20/3,
            minWidth: double.infinity,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text('Load wallet',style: TextStyle(fontSize:17,color:Colors.white,fontWeight:FontWeight.w800),),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(onPressed: (){
            widget.onItemSelected(2);
          },
            elevation: 0,
            color: settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffE8E8E8),
            height: MediaQuery.of(context).size.height*0.20/3,
            minWidth: double.infinity,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child:Text('Remove wallet',style: TextStyle(fontSize:17,color:settingsStore.isDarkTheme ? Colors.white : Colors.black,fontWeight:FontWeight.w800),),
          ),
        ],
      ),
    );
  }
}