import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/blockchain_height_widget.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/stores/rescan/rescan_wallet_store.dart';
import 'package:beldex_wallet/generated/l10n.dart';

class RescanPage extends BasePage {
  final blockchainKey = GlobalKey<BlockchainHeightState>();
  @override
  String get title => S.current.rescan;
 
 @override
 Widget trailing(BuildContext context){
  return Container();
 }

  @override
  Widget body(BuildContext context) {
    final rescanWalletStore = Provider.of<RescanWalletStore>(context);

    return ScrollableWithBottomSection(
      content: 
      // Padding(
      //   padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      //   child:
            Column(mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*0.60/3),
          Center(child: BlockchainHeightWidget(key: blockchainKey)),
          
        ]),
      //),
      bottomSection: Observer(
              builder: (_) => LoadingPrimaryButton(
                  isLoading:
                      rescanWalletStore.state == RescanWalletState.rescaning,
                  text: S.of(context).rescan,
                  onPressed: () async {
                    await rescanWalletStore.rescanCurrentWallet(
                        restoreHeight: blockchainKey.currentState.height);
                    Navigator.of(context).pop();
                  },
                  color:
                      Theme.of(context).primaryTextTheme.button.backgroundColor,
                  borderColor:
                      Theme.of(context).primaryTextTheme.button.decorationColor)),
    );
  }
}
