import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'dart:math' as math;

import '../../../routes.dart';

abstract class PinCodeWidget extends StatefulWidget {
  PinCodeWidget({Key key, this.onPinCodeEntered, this.hasLengthSwitcher, this.notifyParent,})
      : super(key: key);

  final Function(List<int> pin, PinCodeState state) onPinCodeEntered;
  final bool hasLengthSwitcher;
  final Function() notifyParent;
}

class PinCode extends PinCodeWidget {
  PinCode(Function(List<int> pin, PinCodeState state) onPinCodeEntered,
      bool hasLengthSwitcher, Key key,Function() notifyParent)
      : super(
            key: key,
            onPinCodeEntered: onPinCodeEntered,
            hasLengthSwitcher: hasLengthSwitcher,
  notifyParent : notifyParent);

  @override
  PinCodeState createState() => PinCodeState();
}

class PinCodeState<T extends PinCodeWidget> extends State<T> {
  static const defaultPinLength = 4;
  static const sixPinLength = 6;
  static const fourPinLength = 4;
  static final deleteIcon = Icon(Icons.backspace, color: Colors.white);
  final _gridViewKey = GlobalKey();

  int pinLength = defaultPinLength;
  List<int> pin = List<int>.filled(defaultPinLength, null);
  String title = S.current.enter_your_pin;
  double _aspectRatio = 0;

  void setTitle(String title) => setState(() => this.title = title);

  void clear() => setState(() => pin = List<int>.filled(pinLength, null));

  void onPinCodeEntered(PinCodeState state) =>
      widget.onPinCodeEntered(state.pin, this);

  void changePinLength(int length) {
    final newPin = List<int>.filled(length, null);

    setState(() {
      pinLength = length;
      pin = newPin;
    });
  }

  void setDefaultPinLength() {
    final settingsStore = context.read<SettingsStore>();

    pinLength = settingsStore.defaultPinLength;
    changePinLength(pinLength);
  }

  void calculateAspectRatio() {
    final renderBox =
        _gridViewKey.currentContext.findRenderObject() as RenderBox;
    final cellWidth = renderBox.size.width / 3;
    final cellHeight = renderBox.size.height / 4;

    if (cellWidth > 0 && cellHeight > 0) {
      _aspectRatio = cellWidth / cellHeight;
    }

    setState(() {});
  }
  LocalAuthentication auth;
  List<BiometricType> _availableBiometrics = <BiometricType>[];

  @override
  void initState() {
    auth = LocalAuthentication();
    //-->
    _getAvailableBiometrics();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(afterLayout);
  }

  //-->
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }
  //Platform.isAndroid?S.current.settings_allow_biometric_authentication:_availableBiometrics.contains(BiometricType.face)?'Allow face id authentication':S.current.settings_allow_biometric_authentication

  void afterLayout(dynamic _) {
    setDefaultPinLength();
    calculateAspectRatio();
  }

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(100),
  );

  // border for all 3 colors
  final kGradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.green.shade600, Colors.green, Colors.blue],
        transform: GradientRotation(math.pi / 4)),
    border: Border.all(
      color: Colors.white, //kHintColor, so this should be changed?
    ),
    borderRadius: BorderRadius.circular(32),
  );

  /*appBar:AppBar(
  elevation: 0,
  centerTitle: true,
  leading: Container(
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.black,
  ),
  child: Image.asset(
  'assets/images/beldex_logo_foreground.png',
  width: 50,
  height: 50,
  )),
  title: Text(
  'Wallet',
  style: TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  ),
  ),
  backgroundColor:  Theme.of(context).backgroundColor)*/
  @override
  Widget build(BuildContext context) => Scaffold(body: body(context));

  List<Color> colorList = [
    Colors.green.shade600,
    Colors.green,
    Colors.blue,
    Colors.green.shade600
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.green.shade600;
  Color middleColor = Colors.green;
  Color topColor = Colors.blue;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  Widget body(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 40.0),
      child: Column(children: <Widget>[
        Spacer(
          flex: 2,
        ),
        ClipOval(
          clipBehavior: Clip.antiAlias,
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            onEnd: () {
              setState(() {
                index = index + 1;
                // animate the color
                bottomColor = colorList[index % colorList.length];
                topColor = colorList[(index + 1) % colorList.length];

                //// animate the alignment
                // begin = alignmentList[index % alignmentList.length];
                // end = alignmentList[(index + 2) % alignmentList.length];
              });
            },
            padding: EdgeInsets.all(19.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  colors: [bottomColor, topColor],
                  transform: GradientRotation(math.pi / 4)),
              border: Border.all(
                color: Theme.of(context)
                    .backgroundColor, //kHintColor, so this should be changed?
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: 175,
                // this width forces the container to be a circle
                height: 175,
                padding: EdgeInsets.all(46),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(color: Theme.of(context).backgroundColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                // this height forces the container to be a circle
                child: InkWell(
                    onTap: () {
                      setState(() {
                        bottomColor = Colors.white;
                      });
                      widget.notifyParent();
                     /* Navigator.of(context).pushNamed(Routes.auth1, arguments:
                          (bool isAuthenticatedSuccessfully,
                              AuthPageState auth) {
                        if (isAuthenticatedSuccessfully) {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            SystemNavigator.pop();
                          }
                          return Navigator.of(context).popAndPushNamed(
                              Routes.dashboard,
                              arguments:
                                  (BuildContext setupPinContext, String _) =>
                                      Navigator.of(context).pop());
                        } else {
                          return null;
                        }
                      });*/
                    },
                    child: SvgPicture.asset(
                      Platform.isAndroid?'assets/images/fingerprint_svg.svg':_availableBiometrics.contains(BiometricType.face)?'assets/images/face_id.svg':'assets/images/fingerprint_svg.svg',
                      color: Theme.of(context).primaryTextTheme.caption.color,
                    )),
              ),
            ),
          ),
        ),
        /*ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: EdgeInsets.all(19.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green.shade600, Colors.green, Colors.blue],
                  transform: GradientRotation(math.pi/4)),
              border: Border.all(
                color: Theme.of(context).backgroundColor, //kHintColor, so this should be changed?
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: 175, // this width forces the container to be a circle
                height: 175,
                padding: EdgeInsets.all(46),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(color: Theme.of(context).backgroundColor),
                  borderRadius: BorderRadius.circular(100),
                ),// this height forces the container to be a circle
                child: SvgPicture.asset('assets/images/fingerprint_svg.svg',color: Colors.white,),
              ),
            ),
          ),
        ),*/
        Spacer(flex: 4),
        Text(title,
            style: TextStyle(fontSize: 24, color: Theme.of(context).primaryTextTheme.caption.color)),
        Spacer(flex: 1),
        Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(pinLength, (index) {
              const size = 20.0;
              final isFilled = pin[index] != null;

              return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled ? BeldexPalette.teal : Colors.transparent,
                    border: Border.all(color: isFilled ? BeldexPalette.teal:Theme.of(context).primaryTextTheme.headline5.color),
                  ));
            }),
          ),
        ),
        if (widget.hasLengthSwitcher) ...[
          FlatButton(
              onPressed: () {
                changePinLength(pinLength == PinCodeState.fourPinLength
                    ? PinCodeState.sixPinLength
                    : PinCodeState.fourPinLength);
              },
              child: Text(
                _changePinLengthText(),
                style: TextStyle(fontSize: 16.0, color: Theme.of(context).primaryTextTheme.caption.color),
              ))
        ],
        Flexible(
            flex: 24,
            child: Container(
                key: _gridViewKey,
                child: _aspectRatio > 0
                    ? GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: _aspectRatio,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(12, (index) {
                          const marginRight = 15.0;
                          const marginLeft = 15.0;

                          if (index == 9) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: marginLeft, right: marginRight),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                            );
                          } else if (index == 10) {
                            index = 0;
                          } else if (index == 11) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: marginLeft, right: marginRight),
                              child: FlatButton(
                                onPressed: () => _pop(),
                                color: Colors.transparent,
                                shape: CircleBorder(),
                                child: Icon(Icons.backspace, color: Theme.of(context).primaryTextTheme.caption.color),
                              ),
                            );
                          } else {
                            index++;
                          }

                          return Container(
                            margin: EdgeInsets.only(
                                left: marginLeft, right: marginRight),
                            child: FlatButton(
                              onPressed: () => _push(index),
                              color: Colors.transparent,
                              shape: CircleBorder(),
                              child: Text('$index',
                                  style: TextStyle(
                                      fontSize: 23.0, color: Theme.of(context).primaryTextTheme.caption.color)),
                            ),
                          );
                        }),
                      )
                    : null))
      ]),
    ));
  }

  void _push(int num) {
    if (currentPinLength() >= pinLength) {
      return;
    }

    for (var i = 0; i < pin.length; i++) {
      if (pin[i] == null) {
        setState(() => pin[i] = num);
        break;
      }
    }

    final _currentPinLength = currentPinLength();

    if (_currentPinLength == pinLength) {
      onPinCodeEntered(this);
    }
  }

  void _pop() {
    if (currentPinLength() == 0) {
      return;
    }

    for (var i = pin.length - 1; i >= 0; i--) {
      if (pin[i] != null) {
        setState(() => pin[i] = null);
        break;
      }
    }
  }

  int currentPinLength() {
    return pin.fold(0, (v, e) {
      if (e != null) {
        return v + 1;
      }

      return v;
    });
  }

  String _changePinLengthText() {
    return S.current.use +
        (pinLength == PinCodeState.fourPinLength
            ? '${PinCodeState.sixPinLength}'
            : '${PinCodeState.fourPinLength}') +
        S.current.digit_pin;
  }
}
