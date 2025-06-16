import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/stores/user/user_store.dart';
import 'package:beldex_wallet/src/screens/pin_code/pin_code.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import '../../../l10n.dart';

class SetupPinCodePage extends BasePage {
  SetupPinCodePage({this.onPinCodeSetup});

  final Function(BuildContext, String)? onPinCodeSetup;

  @override
  String getTitle(AppLocalizations t) => t.setup_pin;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
  }

  @override
  Widget body(BuildContext context) =>
      SetupPinCodeForm(onPinCodeSetup: onPinCodeSetup!, hasLengthSwitcher: true);
}

class SetupPinCodeForm extends PinCodeWidget {
  SetupPinCodeForm(
      {required this.onPinCodeSetup, required bool hasLengthSwitcher})
      : super(hasLengthSwitcher: hasLengthSwitcher);

  final Function(BuildContext, String) onPinCodeSetup;

  @override
  _SetupPinCodeFormState createState() => _SetupPinCodeFormState();
}

class _SetupPinCodeFormState<WidgetType extends SetupPinCodeForm>
    extends PinCodeState<WidgetType> {
  /*_SetupPinCodeFormState() {
    title = S.current.enterYourPin;
  }*/

  bool isEnteredOriginalPin() => _originalPin.isNotEmpty;
  //Function(BuildContext) onPinCodeSetup;
  List<int> _originalPin = [];
  UserStore? _userStore;
  SettingsStore? _settingsStore;

  @override
  void onPinCodeEntered(PinCodeState state) {
    if (!isEnteredOriginalPin()) {
      _originalPin = [...state.pin];
      state.setTitle(tr(context).re_enter_your_pin);
      state.clear();
    } else {
      if (listEquals<int>(state.pin, _originalPin)) {
        final pin = state.pin.join();
        _userStore?.set(password: pin);
        _settingsStore?.setDefaultPinLength(pinLength: state.pinLength);
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                backgroundColor: _settingsStore?.isDarkTheme ?? false
                    ? Color(0xff272733)
                    : Color(0xffFFFFFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                //this right here
                child: Container(
                  height: 170,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          tr(context).setup_successful,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Color(
                                      0xff0BA70F) //Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                                  ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                widget.onPinCodeSetup(context, pin);
                                reset(tr(context));
                              },
                              child: Text(
                                tr(context).ok,
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xffffffff)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      } else {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                backgroundColor: _settingsStore?.isDarkTheme ?? false
                    ? Color(0xff272733)
                    : Color(0xffFFFFFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                //this right here
                child: Container(
                  height: 170,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          tr(context).pin_is_incorrect,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Color(
                                    0xff0BA70F), //Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                tr(context).ok,
                                style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  fontWeight: FontWeight.w700, fontSize: 15,
                                  color: Color(0xffffffff), //Colors.white
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
        reset(tr(context));
      }
    }
  }

  void reset(AppLocalizations t) {
    clear();
    setTitle(t.enterYourPin);
    _originalPin = [];
  }

  @override
  Widget build(BuildContext context) {
    _userStore = Provider.of<UserStore>(context);
    _settingsStore = Provider.of<SettingsStore>(context);

    return body(context,false);
  }
}
