import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_store.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_state.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/blockchain_height_widget.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/stores/seed_language/seed_language_store.dart';

class RestoreWalletFromKeysPage extends BasePage {
  RestoreWalletFromKeysPage(
      {@required this.walletsService,
      @required this.sharedPreferences,
      @required this.walletService});

  final WalletListService walletsService;
  final WalletService walletService;
  final SharedPreferences sharedPreferences;

  @override
  String get title => S.current.restore_title_from_keys;


  // @override
  // Widget leading(BuildContext context) {
  //   return Container(
  //       padding: const EdgeInsets.only(top: 12.0, left: 10),
  //       decoration: BoxDecoration(
  //         //borderRadius: BorderRadius.circular(10),
  //         //color: Colors.black,
  //       ),
  //       child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  // }

 @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) => RestoreFromKeysFrom();
}

class RestoreFromKeysFrom extends StatefulWidget {
  @override
  _RestoreFromKeysFromState createState() => _RestoreFromKeysFromState();
}

class _RestoreFromKeysFromState extends State<RestoreFromKeysFrom> {
  final _formKey = GlobalKey<FormState>();
  final _blockchainHeightKey = GlobalKey<BlockchainHeightState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _viewKeyController = TextEditingController();
  final _spendKeyController = TextEditingController();
  bool canShowPopup = false;
  @override
  Widget build(BuildContext context) {
    final walletRestorationStore = Provider.of<WalletRestorationStore>(context);
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
 final settingsStore = Provider.of<SettingsStore>(context);
    reaction((_) => walletRestorationStore.state, (WalletRestorationState state) {
      if (state is WalletRestoredSuccessfully) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }

      if (state is WalletRestorationFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(state.error),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(S.of(context).ok),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              });
        });
      }
    });

    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.all(20.0),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Container(
                  //color: Colors.yellow,
                  child: Text(S.of(context).enter_wallet_name,style:TextStyle(fontSize:18,fontWeight:FontWeight.w700))),
            Column(
            //  mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               
                Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      
                      
                      
                      
                      Flexible(
                          child: Card(
                            elevation:0, //5,
                            color:settingsStore.isDarkTheme ? Color(0xff272733):Color(0xffEDEDED), //Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            margin: EdgeInsets.only(top: 8.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 30,top:5,bottom:5),
                        child: TextFormField(
                            style: TextStyle(fontSize: 14.0),
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                hintStyle:
                                    TextStyle(color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)),
                                hintText: S.of(context).enter_restore_wallet_name,
                                /*focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: BeldexPalette.teal, width: 2.0)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).focusColor,
                                        width: 1.0))*/),
                            validator: (value) {
                              walletRestorationStore.validateWalletName(value);
                              return walletRestorationStore.errorMessage;
                            },
                        ),
                      ),
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Card(
                            elevation: 0,
                            color:settingsStore.isDarkTheme ? Color(0xff272733):Color(0xffEDEDED),//Color.fromARGB(255, 40, 42, 51),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            margin: EdgeInsets.only(top: 8.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 30,top:5,bottom:5),
                        child: TextFormField(
                            style: TextStyle(fontSize: 14.0),
                            controller: _addressController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                hintStyle:
                                    TextStyle(color: settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)),
                                hintText: S.of(context).restore_address,
                                /*focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: BeldexPalette.teal, width: 2.0)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).focusColor,
                                        width: 1.0))*/),
                            validator: (value) {
                              walletRestorationStore.validateAddress(value);
                              return walletRestorationStore.errorMessage;
                            },
                        ),
                      ),
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Card(
                            elevation: 0,
                            color: settingsStore.isDarkTheme ? Color(0xff272733):Color(0xffEDEDED),//Color.fromARGB(255, 40, 42, 51),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            margin: EdgeInsets.only(top: 8.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 30,top:5,bottom:5),
                        child: TextFormField(
                            style: TextStyle(fontSize: 14.0),
                            controller: _viewKeyController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                hintStyle:
                                    TextStyle(color: settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)),
                                hintText: S.of(context).restore_view_key_private,
                                /*focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: BeldexPalette.teal, width: 2.0)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).focusColor,
                                        width: 1.0))*/),
                            validator: (value) {
                              walletRestorationStore.validateKeys(value);
                              return walletRestorationStore.errorMessage;
                            },
                        ),
                      ),
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Card(
                            elevation: 0,
                            color: settingsStore.isDarkTheme ? Color(0xff272733):Color(0xffEDEDED),//Color.fromARGB(255, 40, 42, 51),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            margin: EdgeInsets.only(top: 8.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 30,top:5,bottom:5),
                        child: TextFormField(
                            style: TextStyle(fontSize: 14.0),
                            controller: _spendKeyController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                hintStyle:
                                    TextStyle(color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)),
                                hintText: S.of(context).restore_spend_key_private,
                                /*focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: BeldexPalette.teal, width: 2.0)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).focusColor,
                                        width: 1.0))*/),
                            validator: (value) {
                              walletRestorationStore.validateKeys(value);
                              return walletRestorationStore.errorMessage;
                            },
                        ),
                      ),
                          ))
                    ],
                  ),
                  Container(
                   margin: EdgeInsets.only(top:20),
                   width: MediaQuery.of(context).size.width*1.5/3,
                   child: Divider(
                     height: 3,
                     //width: MediaQuery.of(context).size.width*1/3,
                     color: settingsStore.isDarkTheme ? Color(0xff3A3A4F) : Color(0xffEDEDED),
                   ),
                  ),
                  BlockchainHeightWidget(key: _blockchainHeightKey),
                ]),
                //SizedBox(height:170),
               
              ],
            ),
            //  Flexible(
            //       flex: 1,
            //     ),
           // Expanded(child: Container()),
            // SizedBox( 
            //       width: 250,
            //       child: Observer(builder: (_) {
            //         return LoadingPrimaryButton(
            //             onPressed: () {
            //               if (_formKey.currentState.validate()) {
            //                 walletRestorationStore.restoreFromKeys(
            //                     name: _nameController.text,
            //                     language: seedLanguageStore.selectedSeedLanguage,
            //                     address: _addressController.text,
            //                     viewKey: _viewKeyController.text,
            //                     spendKey: _spendKeyController.text,
            //                     restoreHeight: _blockchainHeightKey.currentState.height);
            //               }
            //             },
            //             text: S.of(context).restore_recover,
            //             color: Theme.of(context).primaryTextTheme.button.backgroundColor,
            //             borderColor:
            //             Theme.of(context).primaryTextTheme.button.backgroundColor);
            //       }),
            //     ),
          ],
        ),
      ),
      bottomSection:SizedBox( 
                  width: MediaQuery.of(context).size.width*2.5/3,
                  child: Observer(builder: (_) {
                    return LoadingPrimaryButton(
                        onPressed: ()async{
                          final prefs =await SharedPreferences.getInstance();
                          if (_formKey.currentState.validate()) {
                           await walletRestorationStore.restoreFromKeys(
                                name: _nameController.text,
                                language: seedLanguageStore.selectedSeedLanguage,
                                address: _addressController.text,
                                viewKey: _viewKeyController.text,
                                spendKey: _spendKeyController.text,
                                restoreHeight: _blockchainHeightKey.currentState.height);
                                 setState(() {
                                  canShowPopup = prefs.getBool('isRestored');                     
                                                    });
                          }
                         
                          
                         if(canShowPopup){
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
                                                                      content: Text('You restored via keys',
                                                                        style: TextStyle(color: Color(0xffffffff),
                                                                          fontWeight:FontWeight.w700,fontSize:15) ,textAlign: TextAlign.center,),
                                                                      backgroundColor:Color(0xff0BA70F), //Color(0xff0BA70F).withOpacity(0.10), //.fromARGB(255, 46, 113, 43),
                                                                      duration: Duration(
                                                                          milliseconds: 1900),
                                                                    ));
                         }

                        },
                        text: S.of(context).restore_recover,
                        color: Theme.of(context).primaryTextTheme.button.backgroundColor,
                        borderColor:
                        Theme.of(context).primaryTextTheme.button.backgroundColor);
                  }),
                ),
 
      /*bottomSection: Observer(builder: (_) {
        return LoadingPrimaryButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                walletRestorationStore.restoreFromKeys(
                    name: _nameController.text,
                    language: seedLanguageStore.selectedSeedLanguage,
                    address: _addressController.text,
                    viewKey: _viewKeyController.text,
                    spendKey: _spendKeyController.text,
                    restoreHeight: _blockchainHeightKey.currentState.height);
              }
            },
            text: S.of(context).restore_recover,
            color: Theme.of(context).primaryTextTheme.button.backgroundColor,
            borderColor:
                Theme.of(context).primaryTextTheme.button.decorationColor);
      }),*/
    );
  }
}
