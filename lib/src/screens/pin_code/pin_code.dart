import 'package:beldex_wallet/src/domain/common/biometric_auth.dart';
import 'package:beldex_wallet/src/stores/auth/auth_store.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'dart:math' as math;

abstract class PinCodeWidget extends StatefulWidget {
  PinCodeWidget(
      {Key key,
        this.onPinCodeEntered,
        this.hasLengthSwitcher,
        this.notifyParent,
        this.mainKey
      })
      : super(key: key);

  final Function(List<int> pin, PinCodeState state) onPinCodeEntered;
  final bool hasLengthSwitcher;
  final Function() notifyParent;
  final GlobalKey<ScaffoldState> mainKey;
}

class PinCode extends PinCodeWidget {
  PinCode(
      Function(List<int> pin, PinCodeState state) onPinCodeEntered,
      bool hasLengthSwitcher,
      Key key,
      Function() notifyParent, GlobalKey<ScaffoldState> mainKey,
      ) : super(
    key: key,
    onPinCodeEntered: onPinCodeEntered,
    hasLengthSwitcher: hasLengthSwitcher,
    notifyParent: notifyParent,
    mainKey: mainKey
  );

  @override
  PinCodeState createState() => PinCodeState();
}

class PinCodeState<T extends PinCodeWidget> extends State<T> {
  static const defaultPinLength = 4;
  static const sixPinLength = 6;
  static const fourPinLength = 4;
  static final deleteIcon = Icon(Icons.backspace, color: Colors.white);
  final _gridViewKey = GlobalKey();
  bool isUnlockScreen = false;
  int pinLength = defaultPinLength;
  List<int> pin = List<int>.filled(defaultPinLength, null);
  String title = S.current.enterYourPin;
  double _aspectRatio = 0;
  void setTitle(String title) => setState(() => this.title = title);

  void clear() => setState(() => pin = List<int>.filled(pinLength, null));

  void onPinCodeEntered(PinCodeState state) =>
      widget.onPinCodeEntered.call(state.pin, this);

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
    // _getAvailableBiometrics();
    //_checkBiometric();
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
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(32),
  );


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);

    return Scaffold(
        backgroundColor:
        settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
        resizeToAvoidBottomInset: false,
        body: body(context,true));
  }

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

  Widget body(BuildContext context,bool status) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final authStore = Provider.of<AuthStore>(context);


    return SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 40.0),
          child: Column(children: <Widget>[
            Spacer(
              flex: 2,
            ),
            Container(
              padding:
              EdgeInsets.only(top: 10.0, bottom: 40.0, left: 40.0, right: 40.0),
              height: MediaQuery.of(context).size.height * 0.60 / 3,
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/images/new-images/Password.svg',
                width: 150,
              ),
            ),
            Text(title,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryTextTheme.caption.color)),
            Spacer(flex: 1),
            Container(
              width: 190,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(pinLength, (index) {
                  const size = 20.0;
                  final isFilled = pin[index] != null;

                  return Column(
                    children: [
                      Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFilled
                                ? settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Colors.black
                                : Colors.transparent,
                          )),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        width: 25,
                        child: Divider(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff77778B)
                              : Color(0xffDADADA),
                          thickness: 3,
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
            if (widget.hasLengthSwitcher) ...[
              Container(
                width: 220,
                margin: EdgeInsets.only(top: 8.0, left: 25, right: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff272733)
                        : Color(0xffEDEDED)),
                child: TextButton(
                  //FlatButton
                    onPressed: () {
                      changePinLength(pinLength == PinCodeState.fourPinLength
                          ? PinCodeState.sixPinLength
                          : PinCodeState.fourPinLength);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _changePinLengthText(),
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w800,
                              color:
                              Theme.of(context).primaryTextTheme.caption.color),
                        ),
                        Icon(Icons.keyboard_arrow_right,
                            color: settingsStore.isDarkTheme
                                ? Colors.white
                                : Colors.black)
                      ],
                    )),
              )
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
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  left: marginLeft, right: marginRight),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: GestureDetector(
                                  onTap: () {
                                    // final prefs = await SharedPreferences.getInstance();
                                    if (settingsStore
                                        .allowBiometricAuthentication) {
                                      _getAvailableBiometrics();
                                      if(status) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          final biometricAuth = BiometricAuth();
                                          biometricAuth.isAuthenticated().then((
                                              isAuth) {
                                            print('Biometric-> pincode 2');
                                            if (isAuth) {
                                              print('Biometric-> pincode 3');
                                              authStore.biometricAuth();
                                              // Navigator.of(widget.mainKey.currentContext).pop();
                                            }
                                            print('Biometric-> pincode 4');
                                          });
                                        });
                                      }
                                      showBiometricDialog(
                                          context,
                                          S
                                              .of(context)
                                              .biometric_auth_reason);

                                    } else {
                                      showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10)),
                                              backgroundColor:
                                              settingsStore.isDarkTheme
                                                  ? Color(0xff13131A)
                                                  : Color(0xffffffff),
                                              content: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      S
                                                          .of(context)
                                                          .biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside,
                                                      style: TextStyle(
                                                          color: settingsStore
                                                              .isDarkTheme
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 15),
                                                      textAlign:
                                                      TextAlign.center,
                                                    ),
                                                    SizedBox(height: 20),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          Navigator.of(
                                                              context)
                                                              .pop(),
                                                      child: Container(
                                                        height: 40,
                                                        width: 70,
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                          color: Color(
                                                              0xff0BA70F),
                                                        ),
                                                        alignment:
                                                        Alignment.center,
                                                        child: Text(
                                                          S.of(context).ok,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w800,
                                                              fontSize: 15),
                                                          textAlign: TextAlign
                                                              .center,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/new-images/fingerprint.svg',
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff060606),
                                    fit: BoxFit.contain,
                                  )));
                        } else if (index == 10) {
                          index = 0;
                        } else if (index == 11) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: marginLeft, right: marginRight),
                            child: TextButton(
                              //FlatButton
                                onPressed: () => _pop(),
                                child: SvgPicture.asset('assets/images/new-images/clear.svg', color:Theme.of(context)
                                    .primaryTextTheme
                                    .caption
                                    .color)
                              // Icon(Icons.backspace_outlined,
                              //     color: Theme.of(context)
                              //         .primaryTextTheme
                              //         .caption
                              //         .color),
                            ),
                          );
                        } else {
                          index++;
                        }

                        return Container(
                          margin: EdgeInsets.only(
                              left: marginLeft, right: marginRight),
                          child: TextButton(
                            onPressed: () => _push(index),
                            child: Text('$index',
                                style: TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .caption
                                        .color)),
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