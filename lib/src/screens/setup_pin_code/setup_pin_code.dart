import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/stores/user/user_store.dart';
import 'package:beldex_wallet/src/screens/pin_code/pin_code.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/generated/l10n.dart';

class SetupPinCodePage extends BasePage {
  SetupPinCodePage({this.onPinCodeSetup});

  final Function(BuildContext, String) onPinCodeSetup;

  @override
  String get title => S.current.setup_pin;

  @override
  Widget leading(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 12.0, left: 10),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10),
          //color: Colors.black,
        ),
        child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  }

  @override
  Widget body(BuildContext context) =>
      SetupPinCodeForm(onPinCodeSetup: onPinCodeSetup, hasLengthSwitcher: true);
}

class SetupPinCodeForm extends PinCodeWidget {
  SetupPinCodeForm(
      {@required this.onPinCodeSetup, @required bool hasLengthSwitcher})
      : super(hasLengthSwitcher: hasLengthSwitcher);

  final Function(BuildContext, String) onPinCodeSetup;

  @override
  _SetupPinCodeFormState createState() => _SetupPinCodeFormState();
}

class _SetupPinCodeFormState<WidgetType extends SetupPinCodeForm>
    extends PinCodeState<WidgetType> {
  _SetupPinCodeFormState() {
    title = S.current.enter_your_pin;
  }

  bool isEnteredOriginalPin() => _originalPin.isNotEmpty;
  Function(BuildContext) onPinCodeSetup;
  List<int> _originalPin = [];
  UserStore _userStore;
  SettingsStore _settingsStore;

  @override
  void onPinCodeEntered(PinCodeState state) {
    if (!isEnteredOriginalPin()) {
      _originalPin = state.pin;
      state.title = S.current.enter_your_pin_again;
      state.clear();
    } else {
      if (listEquals<int>(state.pin, _originalPin)) {
        final String pin = state.pin.fold('', (ac, val) => ac + '$val');
        _userStore.set(password: pin);
        _settingsStore.setDefaultPinLength(pinLength: state.pinLength);
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                elevation: 0,
                backgroundColor: Theme.of(context).cardTheme.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 170,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(S.of(context).setup_successful,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: SizedBox(
                            width: 45,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                widget.onPinCodeSetup(context, pin);
                                reset();
                              },
                              child:Text(
                                S.of(context).ok,
                                style: TextStyle(color: Theme.of(context).primaryTextTheme.caption.color),
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
        /*showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                content: Text(S.of(context).setup_successful),
                actions: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                      child: Text(S.of(context).ok),
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onPinCodeSetup(context, pin);
                        reset();
                      },
                    ),
                  ),
                ],
              );
            });*/
      } else {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                elevation: 0,
                backgroundColor: Theme.of(context).cardTheme.color,//Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 170,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(S.of(context).pin_is_incorrect,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: SizedBox(
                            width: 45,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child:Text(
                                S.of(context).ok,
                                style: TextStyle(color: Theme.of(context).primaryTextTheme.caption.color,//Colors.white
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
        /*showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(S.of(context).pin_is_incorrect),
                actions: <Widget>[
                  FlatButton(
                    child: Text(S.of(context).ok),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });*/

        reset();
      }
    }
  }

  void reset() {
    clear();
    setTitle(S.current.enter_your_pin);
    _originalPin = [];
  }

  @override
  Widget build(BuildContext context) {
    _userStore = Provider.of<UserStore>(context);
    _settingsStore = Provider.of<SettingsStore>(context);

    return body(context);
  }
}
