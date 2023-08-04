import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget{
  final WalletDescription wallet;
  final WalletListStore walletListStore;
  LoadingPage({ Key key, this.wallet,this.walletListStore }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(milliseconds: 250), () {
      walletListStore.loadWallet(wallet);
      Navigator.of(context).pop();
    });
    return Container(
      color: Colors.black,
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text('Changing Wallet...',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
          )
        ],
      ),
    );
  }


}