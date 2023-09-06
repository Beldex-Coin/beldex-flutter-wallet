import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/get_height_by_date.dart';
import 'package:beldex_wallet/src/widgets/nospaceformatter.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/blockchain_height_widget.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/stores/rescan/rescan_wallet_store.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

//blockheight widget's property
final dateController = TextEditingController();
final restoreHeightController = TextEditingController();
int get height => _height;
int _height = 0;
bool isRestoreByHeight = true;
final _formKey = GlobalKey<FormState>();
class RescanPage extends BasePage {
  final blockchainKey = GlobalKey<_BlockHeightSwapingWidgetState>();
  @override
  String get title => '${S.current.rescan} wallet';

  @override
  Widget trailing(BuildContext context) {
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
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.60 / 3),
            Center(child: BlockHeightSwapingWidget(key: blockchainKey)),
          ]),
      //),
      bottomSection: Observer(
          builder: (_) => LoadingPrimaryButton(
              isLoading: rescanWalletStore.state == RescanWalletState.rescaning,
              text: S.of(context).rescan,
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  print('block height ---> $height');
                  await rescanWalletStore.rescanCurrentWallet(
                 restoreHeight:height);
                 Navigator.of(context).pop();
                 restoreHeights(height);
                }else{
                  return null;
                }
              },
              color: Theme.of(context).primaryTextTheme.button.backgroundColor,
              borderColor:
                  Theme.of(context).primaryTextTheme.button.backgroundColor)),
    );
  }

 void restoreHeights(int height)async{
     final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentHeight', height);
  }
}

class BlockHeightSwapingWidget extends StatefulWidget {
  const BlockHeightSwapingWidget({Key key}) : super(key: key);

  @override
  State<BlockHeightSwapingWidget> createState() =>
      _BlockHeightSwapingWidgetState();
}

class _BlockHeightSwapingWidgetState extends State<BlockHeightSwapingWidget> {
  //   final dateController = TextEditingController();
  // final restoreHeightController = TextEditingController();
  // int get height => _height;
  // int _height = 0;
  // bool isRestoreByHeight = true;
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
//_height = null;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Form(
      key: _formKey,
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
          SizedBox(height: 20,),
          Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  isRestoreByHeight = isRestoreByHeight ? false : true;
                });
              },
              child: Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff2979FB),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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



