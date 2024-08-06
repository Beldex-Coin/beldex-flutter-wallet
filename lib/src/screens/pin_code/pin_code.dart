import 'dart:io' show Platform;
import 'package:beldex_wallet/src/domain/common/biometric_auth.dart';
import 'package:beldex_wallet/src/stores/auth/auth_store.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import '../../../l10n.dart';
import 'dart:math' as math;

abstract class PinCodeWidget extends StatefulWidget {
  PinCodeWidget(
      {Key? key,
        this.onPinCodeEntered,
        required this.hasLengthSwitcher,
        this.notifyParent,
        this.mainKey
      })
      : super(key: key);

  final Function(List<int> pin, PinCodeState state)? onPinCodeEntered;
  final bool hasLengthSwitcher;
  final Function()? notifyParent;
  final GlobalKey<ScaffoldState>? mainKey;
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
  int pinLength = defaultPinLength;
  List<int> pin = <int>[];
  String title ='';
  double _aspectRatio = 0;
  void setTitle(String title) => setState(() => this.title = title);

  void clear() => setState(() => pin.clear());

  void onPinCodeEntered(PinCodeState state) =>
      widget.onPinCodeEntered?.call(state.pin, this);

  void changePinLength(int length) {

    setState(() {
      pinLength = length;
      pin.clear();
    });
  }

  void setDefaultPinLength() {
    final settingsStore = context.read<SettingsStore>();

    pinLength = settingsStore.defaultPinLength;
    changePinLength(pinLength);
  }

  void calculateAspectRatio() {
    if (_gridViewKey.currentContext == null) {
      _aspectRatio = 0;
      return;
    }
    final renderBox =
    _gridViewKey.currentContext!.findRenderObject() as RenderBox;
    final cellWidth = renderBox.size.width / 3;
    final cellHeight = renderBox.size.height / 4;

    if (cellWidth > 0 && cellHeight > 0) {
      _aspectRatio = cellWidth / cellHeight;
    }

    setState(() {});
  }

  LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> _availableBiometrics = <BiometricType>[];

  @override
  void initState() {
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

  /*final kInnerDecoration = BoxDecoration(
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
  );*/


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
          padding: Platform.isIOS ? EdgeInsets.only(left: 40.0, right: 40.0)
          : EdgeInsets.only(left: 40.0, right: 40.0, bottom: 40.0),
          child: Column(children: <Widget>[
            Platform.isIOS ?
            SizedBox.shrink()
            : Spacer(
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
            Text(title.isNotEmpty ? title : tr(context).enterYourPin,
                style: TextStyle(
                    backgroundColor: Colors.transparent,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryTextTheme.caption?.color)),
            Spacer(flex: 1),
            Container(
              width: 190,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(pinLength, (index) {
                  const size = 20.0;
                  final isFilled = index < pin.length;

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
                      changePinLength(pinLength == 4 ? 6 : 4);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _changePinLengthText(tr(context)),
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w800,
                              color:
                              Theme.of(context).primaryTextTheme.caption?.color),
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
                              padding: Platform.isIOS ? EdgeInsets.only(bottom: 18,left:10,right:10) : EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  left: marginLeft, right: marginRight),
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
                                          biometricAuth.isAuthenticated(tr(context)).then((
                                              isAuth) {
                                            if (isAuth) {
                                              authStore.biometricAuth(tr(context));
                                              // Navigator.of(widget.mainKey.currentContext).pop();
                                            }
                                          });
                                        });
                                      }
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
                                              surfaceTintColor: Colors.transparent,
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
                                                      tr(context)
                                                          .biometricFeatureCurrenlyDisabledkindlyEnableAllowBiometricAuthenticationFeatureInside,
                                                      style: TextStyle(
                                                          backgroundColor: Colors.transparent,
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
                                                          tr(context).ok,
                                                          style: TextStyle(
                                                              backgroundColor: Colors.transparent,
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
                                    height: 20,width: 20,
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
                                    .caption!
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
                                    backgroundColor: Colors.transparent,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).primaryTextTheme.caption?.color)),
                          ),
                        );
                      }),
                    )
                        : null))
          ]),
        ));
  }

  void _push(int num) {
    if (pin.length >= pinLength) {
      return;
    }
    setState(() {
      pin.add(num);
    });

    if(pin.length == pinLength) {
      onPinCodeEntered(this);
    }
  }

  void _pop() {
    if (pin.isEmpty) {
      return;
    }

    setState(()=> pin.removeLast());
  }

  String _changePinLengthText(AppLocalizations t) {
    return t.use +
        (pinLength == 4
            ? '6'
            : '4') +
        t.digit_pin;
  }
}