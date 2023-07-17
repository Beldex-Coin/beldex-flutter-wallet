import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:provider/provider.dart';

class WalletMenu {
  WalletMenu(this.context);

 /* final List<String> items = [
    S.current.reconnect,
    S.current.rescan,
    S.current.reload_fiat
  ];*/
  final List<String> items = [
    S.current.reconnect,
    S.current.rescan
  ];

  final BuildContext context;

  void action(int index) {
    switch (index) {
      case 0:
        _presentReconnectAlert(context);
        //Navigator.pop(context);
        break;
      case 1:
        Navigator.of(context).pushNamed(Routes.rescan);
        break;
     /* case 2:
        context.read<BalanceStore>().updateFiatBalance();
        break;*/
    }
  }

  Future<void> _presentReconnectAlert(BuildContext context) async {
    final walletStore = context.read<WalletStore>();

    // await showSimpleBeldexDialog(
    //     context, S.of(context).reconnection, S.of(context).reconnect_alert_text,
    //     onPressed: (context) {
    //   walletStore.reconnect();
    //   Navigator.of(context)..pop()..pop();
    // });
   await showReconnectConfirmDialog( context, S.of(context).reconnection, S.of(context).reconnect_alert_text,
        onPressed: (context) {
      walletStore.reconnect();
      Navigator.of(context)..pop()..pop();
    });
  
}
}

Future showReconnectConfirmDialog(BuildContext context, String title, String body,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => AlertReconnectConfirmDialog(title, body,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}


class AlertReconnectConfirmDialog extends StatefulWidget {
  const AlertReconnectConfirmDialog(this.title, this.body,
      {this.buttonText, this.onPressed, this.onDismiss,});
 final String title;
  final String body;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;
  @override
  State<AlertReconnectConfirmDialog> createState() => _AlertReconnectConfirmDialogState();
}

class _AlertReconnectConfirmDialogState extends State<AlertReconnectConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return  AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('Reconnect wallet?',style: TextStyle(fontWeight:FontWeight.w800))),
       backgroundColor:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
       content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('Do you want to reconnect\n the wallet?',textAlign: TextAlign.center,style:TextStyle(fontSize:18)),
         ),
           SizedBox(
            height: 10,
           ),
           Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(onPressed: ()=> Navigator.of(context)..pop()..pop(),
              // async {
              //     if (_formKey.currentState.validate()) {
              //       await subaddressCreationStore.add(label: _labelController.text);
              //       Navigator.of(context).pop();
              //     }
              //   },
                elevation: 0,
              color:settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffE8E8E8),
              height: MediaQuery.of(context).size.height*0.18/3,
              minWidth: MediaQuery.of(context).size.width*0.89/3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              child: Text('Cancel',style: TextStyle(fontSize:17,color:settingsStore.isDarkTheme ? Colors.white : Colors.black,fontWeight:FontWeight.w800),),
              ),
              
                  MaterialButton(onPressed:()=> widget.onPressed(context),
                   
              // async {
              //     if (_formKey.currentState.validate()) {
              //       await subaddressCreationStore.add(label: _labelController.text);
              //       Navigator.of(context).pop();
              //     }
              //   },
                elevation: 0,
              color: Color(0xff0BA70F),
              height: MediaQuery.of(context).size.height*0.18/3,
              minWidth: MediaQuery.of(context).size.width*0.89/3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              child: Text('OK',style: TextStyle(fontSize:17,color:Colors.white,fontWeight:FontWeight.w800),),
              )
                ],
              )
              
           
           
        ],
       ),
    );
  }
}