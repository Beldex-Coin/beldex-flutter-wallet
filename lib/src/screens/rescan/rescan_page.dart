import 'package:beldex_coin/wallet.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/get_height_by_date.dart';
import 'package:beldex_wallet/src/widgets/nospaceformatter.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/stores/rescan/rescan_wallet_store.dart';
import 'package:beldex_wallet/l10n.dart';
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
  String getTitle(AppLocalizations t) => '${t.rescan} wallet';

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
  }

  @override
  Widget body(BuildContext context) {
    final rescanWalletStore = Provider.of<RescanWalletStore>(context);

    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child: ScrollableWithBottomSection(
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
                text: tr(context).rescan,
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    print('block height ---> $height');
                    await rescanWalletStore.rescanCurrentWallet(
                        restoreHeight: height);
                    Navigator.of(context).pop();
                    restoreHeights(height);
                  } else {
                    return null;
                  }
                },
                color:  Color.fromARGB(255,46, 160, 33),
                borderColor: Color.fromARGB(255,46, 160, 33))),
      ),
    );
  }

  void restoreHeights(int height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentHeight', height);
  }
}

class BlockHeightSwapingWidget extends StatefulWidget {
  const BlockHeightSwapingWidget({Key? key}) : super(key: key);

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
    restoreHeightController.text.isNotEmpty
            ? int.parse(restoreHeightController.text)
            : 0);
    super.initState();
  }

  @override
  void dispose() {
    dateController.text = '';
    restoreHeightController.text = '';
//_height = null;
  FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }


 bool checkCurrentHeight(String value){
  final currentHeight = getCurrentHeight();
  
  print('$currentHeight --> is current height');
  final intValue = int.tryParse(value);
  if(intValue != null && intValue <= currentHeight){
    return true;
  }else{
    return false;
  }
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
                      elevation: 0,
                      //5,
                      color: Theme.of(context).cardColor,
                      //Color.fromARGB(255, 40, 42, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          style: TextStyle(backgroundColor:Colors.transparent,fontSize: 14.0),
                          controller: restoreHeightController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,NoSpaceFormatter(),FilteringTextInputFormatter.deny(RegExp('[-,. ]'))],
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                backgroundColor:Colors.transparent,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff77778B)
                                    : Color(0xff77778B)),
                            hintText:
                                tr(context).widgets_restore_from_blockheight,
                            errorStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.red)
                          ),
                          validator: (value) {
                            final pattern = RegExp(r'^(?!.*\s)\d+$');
                            if (!pattern.hasMatch(value!)) {
                              return tr(context).enterValidHeightWithoutSpace;
                            }else if(!checkCurrentHeight(value!)){
                              return 'Please enter a valid Height';
                            }else {
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
                      elevation: 0,
                      //5,
                      color: Theme.of(context).cardColor,
                      //Color.fromARGB(255, 40, 42, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 30, top: 5, bottom: 5, right: 10),
                        child: InkWell(
                          onTap: () => selectDate(context,settingsStore),
                          child: IgnorePointer(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: TextStyle(backgroundColor:Colors.transparent,fontSize: 14.0),
                                    decoration: InputDecoration(
                                      //suffix:Icon(Icons.calendar_today,), //SvgPicture.asset('assets/images/new-images/calendar.svg',color:Colors.black),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          backgroundColor:Colors.transparent,
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xff77778B)
                                              : Color(0xff77778B)),
                                      hintText: tr(context)
                                          .widgets_restore_from_date,
                                      errorStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.red)
                                    ),
                                    controller: dateController,
                                    validator: (value) {
                                      if (value?.isEmpty ?? false) {
                                        return tr(context)
                                            .dateShouldNotBeEmpty;
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
          SizedBox(
            height: 20,
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff2979FB),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          isRestoreByHeight
                              ? tr(context).widgets_restore_from_date
                              : tr(context).widgets_restore_from_blockheight,
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

  Future selectDate(BuildContext context, SettingsStore settingsStore) async {
    final now = DateTime.now();
    final date = await showDatePicker(
        builder: (context, child){
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Color(0xff0BA70F),
                  onPrimary: Colors.white, // titles and
                  onSurface: settingsStore.isDarkTheme ? Colors.white : Colors.black, // Month days , years
                ),
                datePickerTheme: DatePickerThemeData(
                    backgroundColor: Theme.of(context).dialogBackgroundColor,
                    cancelButtonStyle: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Color(0xff0BA70F)),
                    ),
                    confirmButtonStyle: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Color(0xff0BA70F))
                    ),
                    todayForegroundColor: WidgetStateProperty.all(settingsStore.isDarkTheme ? Colors.white : Colors.black),
                    todayBorder: BorderSide(
                      color: Color(0xff0BA70F),
                    )
                )
            ),
            child: child ?? SizedBox(),
          );
        },
        initialEntryMode:DatePickerEntryMode.calendarOnly,
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
