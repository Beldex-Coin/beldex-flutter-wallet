

import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/dashboard/wallet_menu.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardAlertDialog extends StatefulWidget {
  const DashBoardAlertDialog({ Key key }) : super(key: key);

  @override
  State<DashBoardAlertDialog> createState() => _DashBoardAlertDialogState();
}

class _DashBoardAlertDialogState extends State<DashBoardAlertDialog> {
  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final walletMenu = WalletMenu(context);
    return  AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('Rescan',style: TextStyle(fontWeight:FontWeight.w800))),
       backgroundColor:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
       content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(onPressed: ()=> walletMenu.action(0),
             elevation: 0,
              color: Color(0xff2979FB),
              height: MediaQuery.of(context).size.height*0.20/3,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
             child: Text('Reconnect wallet',style: TextStyle(fontSize:17,color:Colors.white,fontWeight:FontWeight.w800),),
           ),
           SizedBox(
            height: 10,
           ),
           MaterialButton(onPressed: ()=>Navigator.of(context).pushNamed(Routes.rescan),
             elevation: 0,
              color: Color(0xff0BA70F),
              height: MediaQuery.of(context).size.height*0.20/3,
              minWidth: double.infinity, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              child:Text('Rescan wallet',style: TextStyle(fontSize:17,color:Colors.white,fontWeight:FontWeight.w800),),
           ),
           
           
        ],
       ),
    );
  }
}