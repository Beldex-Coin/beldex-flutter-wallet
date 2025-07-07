import 'package:beldex_coin/wallet.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/get_height_by_date.dart';
import 'package:beldex_wallet/src/widgets/nospaceformatter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_store.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_state.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/blockchain_height_widget.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:beldex_wallet/src/stores/seed_language/seed_language_store.dart';
import 'package:toast/toast.dart';
///block height widget's property
final dateController = TextEditingController();
final restoreHeightController = TextEditingController();

int get height => _height;
int _height = 0;
bool isRestoreByHeight = true;
final _formKey1 = GlobalKey<FormState>();

class RestoreWalletFromKeysPage extends BasePage {
  RestoreWalletFromKeysPage(
      {required this.walletsService,
      required this.sharedPreferences,
      required this.walletService});

  final WalletListService walletsService;
  final WalletService walletService;
  final SharedPreferences sharedPreferences;

  @override
  String getTitle(AppLocalizations t) => t.restore_title_from_keys;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
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
 // ReactionDisposer restoreKeysDisposer;

  @override
  void dispose() {
    //restoreKeysDisposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletRestorationStore = Provider.of<WalletRestorationStore>(context);
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    reaction((_) => walletRestorationStore.state,
        (WalletRestorationState state) {
      if (state is WalletRestoredSuccessfully) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }

      if (state is WalletRestorationFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  surfaceTintColor: Colors.transparent,
                  content: Text(state.error),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(tr(context).ok),
                    ),
                  ],
                );
              });
        });
      }
    });

    ToastContext().init(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: ScrollableWithBottomSection(
        contentPadding: EdgeInsets.all(20.0),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                        child: Card(
                      elevation: 0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Color(0xffEDEDED),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: Observer(
                          builder: (context) {
                            return TextFormField(
                              enabled: !(walletRestorationStore.state is WalletIsRestoring),
                              style: TextStyle(backgroundColor:Colors.transparent,fontSize: 14.0),
                              controller: _nameController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    backgroundColor:Colors.transparent,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff77778B)
                                        : Color(0xff77778B)),
                                hintText: tr(context).enterWalletName_,
                                errorStyle: TextStyle(backgroundColor:Colors.transparent,color:Colors.red,height: 0.10),
                              ),
                              validator: (value) {
                                walletRestorationStore.validateWalletName(value!,tr(context));
                                return walletRestorationStore.errorMessage;
                              },
                            );
                          }
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
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Color(0xffEDEDED),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: Observer(
                            builder: (context) {
                            return TextFormField(
                              enabled: !(walletRestorationStore.state is WalletIsRestoring),
                              style: TextStyle(backgroundColor:Colors.transparent,fontSize: 14.0),
                              controller: _addressController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    backgroundColor:Colors.transparent,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff77778B)
                                        : Color(0xff77778B)),
                                hintText: tr(context).restore_address,
                                errorStyle: TextStyle(backgroundColor:Colors.transparent,color:Colors.red,height: 0.10),
                              ),
                              validator: (value) {
                                walletRestorationStore.validateAddress(value!,t:tr(context));
                                return walletRestorationStore.errorMessage;
                              },
                            );
                          }
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
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Color(0xffEDEDED),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: Observer(
                            builder: (context) {
                            return TextFormField(
                              enabled: !(walletRestorationStore.state is WalletIsRestoring),
                              style: TextStyle(backgroundColor:Colors.transparent,fontSize: 14.0),
                              controller: _viewKeyController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    backgroundColor:Colors.transparent,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff77778B)
                                        : Color(0xff77778B)),
                                hintText: tr(context).restore_view_key_private,
                                errorStyle: TextStyle(backgroundColor:Colors.transparent,color:Colors.red,height: 0.10),
                              ),
                              validator: (value) {
                                walletRestorationStore.validateKeys(value!,tr(context));
                                return walletRestorationStore.errorMessage;
                              },
                            );
                          }
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
                      color: settingsStore.isDarkTheme
                          ? Color(0xff272733)
                          : Color(0xffEDEDED),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: Observer(
                            builder: (context) {
                            return TextFormField(
                              enabled: !(walletRestorationStore.state is WalletIsRestoring),
                              style: TextStyle(backgroundColor:Colors.transparent,fontSize: 14.0),
                              controller: _spendKeyController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    backgroundColor:Colors.transparent,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff77778B)
                                        : Color(0xff77778B)),
                                hintText: tr(context).restore_spend_key_private,
                                errorStyle: TextStyle(backgroundColor:Colors.transparent,color:Colors.red,height: 0.10),
                              ),
                              validator: (value) {
                                walletRestorationStore.validateKeys(value!,tr(context));
                                return walletRestorationStore.errorMessage;
                              },
                            );
                          }
                        ),
                      ),
                    ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 1.5 / 3,
                  child: Divider(
                    height: 3,
                    color: settingsStore.isDarkTheme
                        ? Color(0xff3A3A4F)
                        : Color(0xffEDEDED),
                  ),
                ),
                BlockHeightSwappingWidget(key: _blockchainHeightKey, walletRestorationStore: walletRestorationStore),
              ]),
            ],
          ),
        ),
        bottomSection: Observer(builder: (_) {
          return LoadingPrimaryButton(
            onPressed: () async {
                if ((_formKey.currentState?.validate() ?? false) && (_formKey1.currentState?.validate() ?? false)) {
                  await walletRestorationStore.restoreFromKeys(
                      name: _nameController.text,
                      language: seedLanguageStore.selectedSeedLanguage,
                      address: _addressController.text,
                      viewKey: _viewKeyController.text,
                      spendKey: _spendKeyController.text,
                      restoreHeight: height);
                  restoreHeights(height,settingsStore);
              }
            },
            text: tr(context).restore_recover,
            color: Color.fromARGB(255,46, 160, 33),
            borderColor: Color.fromARGB(255,46, 160, 33),
            isLoading: walletRestorationStore.state is WalletIsRestoring,
          );
        }),
      ),
    );
  }

  void restoreHeights(int height ,SettingsStore settingsStore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentHeight', height);
    canShowPopup = prefs.getBool('isRestored') ?? false;
    if (canShowPopup) {
       Toast.show(
      'You restored via keys',
         duration: Toast.lengthShort,
         gravity: Toast.bottom,
         textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white), // Text color
                                backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,
    );
    }
  }
}

///// block height selection widget
///
class BlockHeightSwappingWidget extends StatefulWidget {
  const BlockHeightSwappingWidget({Key? key, required this.walletRestorationStore}) : super(key: key);
  final WalletRestorationStore walletRestorationStore;
  @override
  State<BlockHeightSwappingWidget> createState() =>
      _BlockHeightSwappingWidgetState();
}

class _BlockHeightSwappingWidgetState extends State<BlockHeightSwappingWidget> {
  late final WalletRestorationStore walletRestorationStore;
  @override
  void initState() {
    walletRestorationStore = widget.walletRestorationStore;
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
                      elevation: 0,
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: Observer(
                            builder: (context) {
                            return TextFormField(
                              enabled: !(walletRestorationStore.state is WalletIsRestoring),
                              textInputAction: TextInputAction.done,
                              style: TextStyle(backgroundColor:Colors.transparent,fontSize: 14.0),
                              controller: restoreHeightController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly,NoSpaceFormatter(),FilteringTextInputFormatter.deny(RegExp('[-,. ]'))],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal:true),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    backgroundColor:Colors.transparent,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff77778B)
                                        : Color(0xff77778B)),
                                hintText:
                                    tr(context).widgets_restore_from_blockheight,
                                errorStyle: TextStyle(backgroundColor:Colors.transparent,color:Colors.red,height: 0.10),
                              ),
                              validator: (value) {
                                final pattern = RegExp(r'^(?!.*\s)\d+$');
                                if (!pattern.hasMatch(value!)) {
                                  return tr(context).enterValidHeightWithoutSpace;
                                }else {
                                  return null;
                                }
                              },
                            );
                          }
                        ),
                      ),
                    ))
                  ],
                )
              : Row(
                  children: <Widget>[
                    Flexible(
                        child: Card(
                      elevation: 0,
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 30, top: 5, bottom: 5, right: 10),
                        child: InkWell(
                          onTap: () {
                            if(!(walletRestorationStore.state is WalletIsRestoring)) {
                              selectDate(context,settingsStore);
                            }
                          },
                          child: IgnorePointer(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 130,
                                  child: Observer(
                                      builder: (context) {
                                      return TextFormField(
                                        enabled: !(walletRestorationStore.state is WalletIsRestoring),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        style: TextStyle(backgroundColor:Colors.transparent,fontSize: 14.0),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              backgroundColor:Colors.transparent,
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xff77778B)
                                                  : Color(0xff77778B)),
                                          hintText:tr(context)
                                              .widgets_restore_from_date,
                                          errorStyle: TextStyle(backgroundColor:Colors.transparent,color:Colors.red,height: 0.10),
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
                                      );
                                    }
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
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isRestoreByHeight = isRestoreByHeight ? false : true;
                });
              },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: Color(0xff2979FB),
                padding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      isRestoreByHeight
                          ? tr(context).widgets_restore_from_date
                          : tr(context).widgets_restore_from_blockheight,
                      style: TextStyle(
                          backgroundColor:Colors.transparent,
                          color: Color(0xffffffff),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Color(0xffffffff),
                  )
                ],
              ),
            ),
          ),
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
