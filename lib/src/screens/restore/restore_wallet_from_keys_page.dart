import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/get_height_by_date.dart';
import 'package:beldex_wallet/src/widgets/nospaceformatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
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

///block height widget's property
final dateController = TextEditingController();
final restoreHeightController = TextEditingController();
int get height => _height;
int _height = 0;
bool isRestoreByHeight = true;
final _formKey1 = GlobalKey<FormState>();





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
  ReactionDisposer restoreKeysDisposer;

@override
  void dispose() {
    restoreKeysDisposer?.call();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final walletRestorationStore = Provider.of<WalletRestorationStore>(context);
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
 final settingsStore = Provider.of<SettingsStore>(context);
  restoreKeysDisposer =  reaction((_) => walletRestorationStore.state, (WalletRestorationState state) {
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
            //  Container(
            //       //color: Colors.yellow,
            //       child: Text(S.of(context).enter_wallet_name,style:TextStyle(fontSize:18,fontWeight:FontWeight.w700))),
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
                  BlockHeightSwapingWidget(key: _blockchainHeightKey),
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
                  width:double.infinity,  //MediaQuery.of(context).size.width*2.5/3,
                  child: Observer(builder: (_) {
                    return LoadingPrimaryButton(
                        onPressed: ()async{
                          final prefs =await SharedPreferences.getInstance();
                          if (_formKey.currentState.validate()) {
                            if(_formKey1.currentState.validate()){
                               await walletRestorationStore.restoreFromKeys(
                                name: _nameController.text,
                                language: seedLanguageStore.selectedSeedLanguage,
                                address: _addressController.text,
                                viewKey: _viewKeyController.text,
                                spendKey: _spendKeyController.text,
                                restoreHeight: height);
                                 setState(() {
                                  canShowPopup = prefs.getBool('isRestored');                     
                                                    });
                                restoreHeights(height);
                            }
                          
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
  void restoreHeights(int height)async{
     final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentHeight', height);
  }
  
}






///// block height selection widget 
///
class BlockHeightSwapingWidget extends StatefulWidget {
  const BlockHeightSwapingWidget({Key key}) : super(key: key);

  @override
  State<BlockHeightSwapingWidget> createState() =>
      _BlockHeightSwapingWidgetState();
}

class _BlockHeightSwapingWidgetState extends State<BlockHeightSwapingWidget> {
  @override
  void initState() {
    restoreHeightController.addListener(() => _height =
        restoreHeightController.text != null
            ? int.parse(restoreHeightController.text, onError: (source) => 0)
            : 0);
    super.initState();
  }

@override
  void dispose() {
     dateController.text = '';
    restoreHeightController.text = '';
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isRestoreByHeight
              ? Row(
                  children: <Widget>[
                    Flexible(
                        child: Card(
                      elevation: 0, //5,
                      color: Theme.of(context)
                          .cardColor, //Color.fromARGB(255, 40, 42, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: TextFormField(
                          style: TextStyle(fontSize: 14.0),
                          controller: restoreHeightController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [NoSpaceFormatter()],
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff77778B)
                                    : Color(0xff77778B)),
                            hintText:
                                S.of(context).widgets_restore_from_blockheight,
                            /*focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: BeldexPalette.teal, width: 2.0)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).focusColor, width: 1.0))*/
                          ),
                          validator: (value) {
                            final pattern = RegExp(r'^(?!.*\s)\d+$');
                            if (!pattern.hasMatch(value)) {
                              return 'Enter valid height without space';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ))
                  ],
                )
              :
              // Padding(
              //   padding: EdgeInsets.only(top: 25,bottom: 5),
              //   child: Center(
              //     child: Text(
              //       S.of(context).widgets_or,
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //           fontSize: 16.0,
              //           fontWeight: FontWeight.normal,
              //           color: Theme.of(context).primaryTextTheme.headline6.color),
              //     ),
              //   ),
              // ),
              Row(
                  children: <Widget>[
                    Flexible(
                        child: Card(
                      elevation: 0, //5,
                      color: Theme.of(context)
                          .cardColor, //Color.fromARGB(255, 40, 42, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 30, top: 5, bottom: 5, right: 10
                            ),
                        child: InkWell(
                          onTap: () => selectDate(context),
                          child: IgnorePointer(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 130,
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: TextStyle(fontSize: 14.0),
                                    decoration: InputDecoration(
                                      //suffix:Icon(Icons.calendar_today,), //SvgPicture.asset('assets/images/new-images/calendar.svg',color:Colors.black),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xff77778B)
                                              : Color(0xff77778B)),
                                      hintText:
                                          S.of(context).widgets_restore_from_date,
                                    ),
                                    controller: dateController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Date should not be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Icon(Icons.calendar_today,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff77778B)
                                        : Color(0xffB5B5C1))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
          Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  isRestoreByHeight = isRestoreByHeight ? false : true;
                });
              },
              child: Container(
                  height: 50,
                  width: isRestoreByHeight ? 160 : 220,
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff2979FB),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Text(
                          isRestoreByHeight
                              ? S.of(context).widgets_restore_from_date
                              : S.of(context).widgets_restore_from_blockheight,
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Color(0xffffffff),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  Future selectDate(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
        context: context,
        initialDate: now.subtract(Duration(days: 1)),
        firstDate: DateTime(2014, DateTime.april),
        lastDate: now);

    if (date != null) {
      setState(() {});
      final height = getHeightByDate(date: date);

      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(date);
        restoreHeightController.text = '$height';
        _height = height;
      });
    }
  }
}



