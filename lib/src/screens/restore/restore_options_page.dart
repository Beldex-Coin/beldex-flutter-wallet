import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import '../../../l10n.dart';
import 'package:provider/provider.dart';

class RestoreOptionsPage extends BasePage {

  @override
  String getTitle(AppLocalizations t) => t.restore_restore_wallet;

  @override
  Color get backgroundColor => Palette.creamyGrey;

  @override
  Widget trailing(BuildContext context){
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(left: 20,right: 20,top: 50),
          elevation:0,
          color:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED), //Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child:InkWell(
            onTap: (){
              Navigator.pushNamed(
                  context, Routes.restoreWalletOptionsFromWelcome);
            },
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr(context).restore_title_from_seed_keys,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 15),
                        Text(tr(context).restore_description_from_seed_keys,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,
                        color: settingsStore.isDarkTheme ?  Color(0xffACACAC) : Color(0xff545454),
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                         color: Color(0xff1BB71E),
                    ),
                    child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 25,),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
