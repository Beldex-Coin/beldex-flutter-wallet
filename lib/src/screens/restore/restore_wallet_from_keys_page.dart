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
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_store.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_state.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/blockchain_height_widget.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
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
    restoreKeysDisposer = reaction((_) => walletRestorationStore.state,
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
                      child: TextFormField(
                        style: TextStyle(fontSize: 14.0),
                        controller: _nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          hintText: S.of(context).enterWalletName_,
                          errorStyle: TextStyle(height: 0.10),
                        ),
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
                    color: settingsStore.isDarkTheme
                        ? Color(0xff272733)
                        : Color(0xffEDEDED),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 8.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                      child: TextFormField(
                        style: TextStyle(fontSize: 14.0),
                        controller: _addressController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          hintText: S.of(context).restore_address,
                          errorStyle: TextStyle(height: 0.10),
                        ),
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
                    color: settingsStore.isDarkTheme
                        ? Color(0xff272733)
                        : Color(0xffEDEDED),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 8.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                      child: TextFormField(
                        style: TextStyle(fontSize: 14.0),
                        controller: _viewKeyController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          hintText: S.of(context).restore_view_key_private,
                          errorStyle: TextStyle(height: 0.10),
                        ),
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
                    color: settingsStore.isDarkTheme
                        ? Color(0xff272733)
                        : Color(0xffEDEDED),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 8.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                      child: TextFormField(
                        style: TextStyle(fontSize: 14.0),
                        controller: _spendKeyController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          hintText: S.of(context).restore_spend_key_private,
                          errorStyle: TextStyle(height: 0.10),
                        ),
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
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 1.5 / 3,
                child: Divider(
                  height: 3,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff3A3A4F)
                      : Color(0xffEDEDED),
                ),
              ),
              BlockHeightSwappingWidget(key: _blockchainHeightKey),
            ]),
          ],
        ),
      ),
      bottomSection: Observer(builder: (_) {
        return LoadingPrimaryButton(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              if (_formKey1.currentState.validate()) {
                await walletRestorationStore.restoreFromKeys(
                    name: _nameController.text,
                    language: seedLanguageStore.selectedSeedLanguage,
                    address: _addressController.text,
                    viewKey: _viewKeyController.text,
                    spendKey: _spendKeyController.text,
                    restoreHeight: height);
                restoreHeights(height);
              }
            }
          },
          text: S.of(context).restore_recover,
          color: Theme.of(context).primaryTextTheme.button.backgroundColor,
          borderColor:
              Theme.of(context).primaryTextTheme.button.backgroundColor,
          isLoading: walletRestorationStore.state is WalletIsRestoring,
        );
      }),
    );
  }

  void restoreHeights(int height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentHeight', height);
    canShowPopup = prefs.getBool('isRestored') ?? false;
    if (canShowPopup) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.30 / 3,
            left: MediaQuery.of(context).size.height * 0.30 / 3,
            right: MediaQuery.of(context).size.height * 0.30 / 3),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: Text(
          'You restored via keys',
          style: TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.w700,
              fontSize: 15),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff0BA70F),
        duration: Duration(milliseconds: 1900),
      ));
    }
  }
}

///// block height selection widget
///
class BlockHeightSwappingWidget extends StatefulWidget {
  const BlockHeightSwappingWidget({Key key}) : super(key: key);

  @override
  State<BlockHeightSwappingWidget> createState() =>
      _BlockHeightSwappingWidgetState();
}

class _BlockHeightSwappingWidgetState extends State<BlockHeightSwappingWidget> {
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
                      elevation: 0,
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: TextFormField(
                          style: TextStyle(fontSize: 14.0),
                          controller: restoreHeightController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,NoSpaceFormatter(),FilteringTextInputFormatter.deny(RegExp('[-,. ]'))],
                          keyboardType: TextInputType.numberWithOptions(
                              decimal:true),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff77778B)
                                    : Color(0xff77778B)),
                            hintText:
                                S.of(context).widgets_restore_from_blockheight,
                            errorStyle: TextStyle(height: 0.10),
                          ),
                          validator: (value) {
                            final pattern = RegExp(r'^(?!.*\s)\d+$');
                            if (!pattern.hasMatch(value)) {
                              return S.of(context).enterValidHeightWithoutSpace;
                            } else {
                              return null;
                            }
                          },
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
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xff77778B)
                                              : Color(0xff77778B)),
                                      hintText: S
                                          .of(context)
                                          .widgets_restore_from_date,
                                      errorStyle: TextStyle(height: 0.10),
                                    ),
                                    controller: dateController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return S
                                            .of(context)
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
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isRestoreByHeight = isRestoreByHeight ? false : true;
                });
              },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                primary: Color(0xff2979FB),
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
                          ? S.of(context).widgets_restore_from_date
                          : S.of(context).widgets_restore_from_blockheight,
                      style: TextStyle(
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
