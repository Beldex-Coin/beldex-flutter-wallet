import 'package:beldex_coin/wallet.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/get_height_by_date.dart';
import 'package:beldex_wallet/src/widgets/nospaceformatter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_store.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_state.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/blockchain_height_widget.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n.dart';

// blockheight widget's property
final dateController = TextEditingController();
final restoreHeightController = TextEditingController();

int get height => _height;
int _height = 0;
bool isRestoreByHeight = true;
final _formKey2 = GlobalKey<FormState>();

class RestoreWalletFromSeedDetailsPage extends BasePage {
  @override
  String getTitle(AppLocalizations t) => t.walletRestore;

  @override
  Widget trailing(BuildContext context) {
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
  String? heighterrorMessage;
 // ReactionDisposer restoreSeedDisposer;

  @override
  void dispose() {
   // restoreSeedDisposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletRestorationStore = Provider.of<WalletRestorationStore>(context);
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

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: ScrollableWithBottomSection(
        contentPadding:
            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 10),
        content: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr(context).enterWalletName,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.07 / 3,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffEBEBEB)
                                : Color(0xff373737),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        child: TextFormField(
                          style: TextStyle(fontSize: 14.0),
                          controller: _nameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff77778B)
                                      : Color(0xff6F6F6F)),
                              hintText: tr(context).enterWalletName_,
                              errorStyle: TextStyle(height: 0.1)),
                          onChanged: (val) => _formKey.currentState?.validate(),
                          validator: (value) {
                            walletRestorationStore.validateWalletName(value ?? '',tr(context));
                            return walletRestorationStore.errorMessage;
                          },
                        ),
                      ),
                    ),
                    BlockHeightSwappingWidget(key: _blockchainHeightKey),
                  ])
            ],
          ),
        ),
        bottomSection: Observer(builder: (_) {
          return LoadingPrimaryButton(
              onPressed: () {
                if ((_formKey.currentState?.validate() ?? false) && (_formKey2.currentState?.validate() ?? false)) {
                  walletRestorationStore.restoreFromSeed(
                      name: _nameController.text, restoreHeight: height);
                  restoreHeights(height);
                } else {
                  return;
                }
              },
              isLoading: walletRestorationStore.state is WalletIsRestoring,
              text: tr(context).restore_recover,
              color: Color.fromARGB(255,46, 160, 33),
              borderColor: Color.fromARGB(255,46, 160, 33));
        }),
      ),
    );
  }

  void restoreHeights(int height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentHeight', height);
  }
}

class BlockHeightSwappingWidget extends StatefulWidget {
  const BlockHeightSwappingWidget({Key? key}) : super(key: key);

  @override
  State<BlockHeightSwappingWidget> createState() =>
      _BlockHeightSwappingWidgetState();
}

class _BlockHeightSwappingWidgetState extends State<BlockHeightSwappingWidget> {
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
                          style: TextStyle(fontSize: 14.0),
                          controller: restoreHeightController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,NoSpaceFormatter(),FilteringTextInputFormatter.deny(RegExp('[-,. ]'))],
                          keyboardType: TextInputType.numberWithOptions(decimal : true),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff77778B)
                                      : Color(0xff77778B)),
                              hintText: tr(context)
                                  .widgets_restore_from_blockheight,
                              errorStyle: TextStyle(height: 0.1)),
                          validator: (value) {
                            final pattern = RegExp(r'^(?!.*\s)\d+$');
                            if (!pattern.hasMatch(value!)) {
                              return tr(context).enterValidHeightWithoutSpace;
                            }else {
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
                                      hintText: tr(context)
                                          .widgets_restore_from_date,
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
                          ? tr(context).widgets_restore_from_date
                          : tr(context).widgets_restore_from_blockheight,
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
