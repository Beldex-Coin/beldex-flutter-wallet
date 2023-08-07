import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/get_height_by_date.dart';
import 'package:beldex_wallet/src/widgets/nospaceformatter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_store.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_state.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/blockchain_height_widget.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/palette.dart';

// blockheight widget's property
final dateController = TextEditingController();
final restoreHeightController = TextEditingController();
int get height => _height;
int _height = 0;
bool isRestoreByHeight = true;
final _formKey2 = GlobalKey<FormState>();
class RestoreWalletFromSeedDetailsPage extends BasePage {
  @override
  String get title => 'Wallet Restore';

 @override
 Widget trailing(BuildContext context){
  return Container();
 }

  @override
  Widget body(BuildContext context) => RestoreFromSeedDetailsForm();
}

class RestoreFromSeedDetailsForm extends StatefulWidget {
  @override
  _RestoreFromSeedDetailsFormState createState() =>
      _RestoreFromSeedDetailsFormState();
}

class _RestoreFromSeedDetailsFormState
    extends State<RestoreFromSeedDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final _blockchainHeightKey = GlobalKey<BlockchainHeightState>();
  final _nameController = TextEditingController();
  String heighterrorMessage; 
  ReactionDisposer restoreSeedDisposer;


 @override
   void dispose() {
     restoreSeedDisposer?.call();
     super.dispose();
   }


  @override
  Widget build(BuildContext context) {
    final walletRestorationStore = Provider.of<WalletRestorationStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
  restoreSeedDisposer =  reaction((_) => walletRestorationStore.state, (WalletRestorationState state) {
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
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(S.of(context).ok),
                    ),
                  ],
                );
              });
        });
      }
    });

    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0,top:10),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(//left: 10, right: 10,
                top:15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Enter ${S.of(context).restore_wallet_name}',style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.07/3,color: settingsStore.isDarkTheme ? Color(0xffEBEBEB) : Color(0xff373737)
                          ,fontWeight: FontWeight.w800),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: Card(
                                elevation: 0,
                                color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                margin: EdgeInsets.only(top: 20.0),
                                child: Container(
                                  padding: EdgeInsets.only(left: 30),
                            child: TextFormField(
                                style: TextStyle(fontSize: 14.0),
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff6F6F6F)),
                                    hintText: S.of(context).restore_wallet_name,
                                    /*focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: BeldexPalette.teal,
                                            width: 2.0)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).focusColor,
                                            width: 1.0))*/),
                                validator: (value) {
                                  walletRestorationStore
                                      .validateWalletName(value);
                                  return walletRestorationStore.errorMessage;
                                },
                            ),
                          ),
                              ))
                        ],
                      ),
                      BlockHeightSwapingWidget(key: _blockchainHeightKey),
                    // heighterrorMessage != null || heighterrorMessage != '' ? Text('$heighterrorMessage',style:TextStyle(color:Colors.red)):Container()
                    ]))
          ],
        ),
      ),
      bottomSection: Observer(builder: (_) {
        return LoadingPrimaryButton(
            onPressed: () {
              // String blockheightValue = BlockchainHeightState().restoreHeightController.text;
              //   final RegExp numberRegex = RegExp(r'^[0-9]+$'); //this regex accept only numbers and not space 
              //  if(blockheightValue.isNotEmpty && numberRegex.hasMatch(blockheightValue)){
                 
              //  }
              if (_formKey.currentState.validate()) {
               if(_formKey2.currentState.validate()){
                 walletRestorationStore.restoreFromSeed(
                    name: _nameController.text,
                    restoreHeight: height);
               }
                
                  
                
               
              }else{
                return ;
              }
            },
            isLoading: walletRestorationStore.state is WalletIsRestoring,
            text: S.of(context).restore_recover,
            color: Theme.of(context).primaryTextTheme.button.backgroundColor,
            borderColor:
                Theme.of(context).primaryTextTheme.button.backgroundColor);
      }),
    );
  }
}



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
      key: _formKey2,
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
                                  width: 150,
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



