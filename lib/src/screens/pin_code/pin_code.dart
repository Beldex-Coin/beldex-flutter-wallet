import 'dart:io';

import 'package:beldex_wallet/src/screens/pin_code/biometric_dialog.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import '../../../routes.dart';

abstract class PinCodeWidget extends StatefulWidget {
  PinCodeWidget(
      {Key key,
      this.onPinCodeEntered,
      this.hasLengthSwitcher,
      this.notifyParent})
      : super(key: key);

  final Function(List<int> pin, PinCodeState state) onPinCodeEntered;
  final bool hasLengthSwitcher;
  final Function() notifyParent;
}

class PinCode extends PinCodeWidget {
  PinCode(
    Function(List<int> pin, PinCodeState state) onPinCodeEntered,
    bool hasLengthSwitcher,
    Key key,
    Function() notifyParent,
  ) : super(
          key: key,
          onPinCodeEntered: onPinCodeEntered,
          hasLengthSwitcher: hasLengthSwitcher,
          notifyParent: notifyParent,
        );
//  bool canShowBackArrow = true;

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
    getSetupArrow();
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

  void getSetupArrow() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {});
    isUnlockScreen = prefs.getBool('removeArrow');
  }

  @override
  void dispose() {
    resetUnlockScreenValue();
    super.dispose();
  }

  void resetUnlockScreenValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('removeArrow', false);
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);

    return Scaffold(
        backgroundColor:
            settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
            resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   elevation: 0,
        //   title: Text(isUnlockScreen ? 'Enter pin' : S.of(context).settingup_pin,style: TextStyle(color:Theme.of(context).primaryTextTheme.caption.color,fontSize:26,fontWeight: FontWeight.w800),) ,
        //   centerTitle: true,
        //   backgroundColor: Colors.transparent,
        //   leading: Navigator.canPop(context) ? GestureDetector(
        //     onTap: ()=>Navigator.pop(context),
        //     child: Container(child: Icon(Icons.arrow_back,color:settingsStore.isDarkTheme ? Colors.white: Colors.black))): Container(),
        //   leadingWidth: 70.0,
        // ),
        body: body(context));
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

  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return SafeArea(
        child: Container(
      // color: Theme.of(context).backgroundColor,
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
          // color:Colors.yellow,
          child: SvgPicture.asset(
            'assets/images/new-images/Password.svg',
            width: 150,
          ),
        ),

        // ClipOval(
        //   clipBehavior: Clip.antiAlias,
        //   child: AnimatedContainer(
        //     duration: Duration(seconds: 2),
        //     onEnd: () {
        //       setState(() {
        //         index = index + 1;
        //         // animate the color
        //         bottomColor = colorList[index % colorList.length];
        //         topColor = colorList[(index + 1) % colorList.length];

        //         //// animate the alignment
        //         // begin = alignmentList[index % alignmentList.length];
        //         // end = alignmentList[(index + 2) % alignmentList.length];
        //       });
        //     },
        //     padding: EdgeInsets.all(19.0),
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: begin,
        //           end: end,
        //           colors: [bottomColor, topColor],
        //           transform: GradientRotation(math.pi / 4)),
        //       border: Border.all(
        //         color: Theme.of(context)
        //             .backgroundColor, //kHintColor, so this should be changed?
        //       ),
        //       borderRadius: BorderRadius.circular(100),
        //     ),
        //     child: ClipOval(
        //       clipBehavior: Clip.antiAlias,
        //       child: Container(
        //         width: 175,
        //         // this width forces the container to be a circle
        //         height: 175,
        //         padding: EdgeInsets.all(46),
        //         decoration: BoxDecoration(
        //           color: Theme.of(context).backgroundColor,
        //           border: Border.all(color: Theme.of(context).backgroundColor),
        //           borderRadius: BorderRadius.circular(100),
        //         ),
        //         // this height forces the container to be a circle
        //         child: InkWell(
        //             onTap: () {
        //               setState(() {
        //                 bottomColor = Colors.white;
        //               });
        //               widget.notifyParent();
        //              /* Navigator.of(context).pushNamed(Routes.auth1, arguments:
        //                   (bool isAuthenticatedSuccessfully,
        //                       AuthPageState auth) {
        //                 if (isAuthenticatedSuccessfully) {
        //                   if (Navigator.canPop(context)) {
        //                     Navigator.pop(context);
        //                   } else {
        //                     SystemNavigator.pop();
        //                   }
        //                   return Navigator.of(context).popAndPushNamed(
        //                       Routes.dashboard,
        //                       arguments:
        //                           (BuildContext setupPinContext, String _) =>
        //                               Navigator.of(context).pop());
        //                 } else {
        //                   return null;
        //                 }
        //               });*/
        //             },
        //             child: SvgPicture.asset(
        //               Platform.isAndroid?'assets/images/fingerprint_svg.svg':_availableBiometrics.contains(BiometricType.face)?'assets/images/face_id.svg':'assets/images/fingerprint_svg.svg',
        //               color: Theme.of(context).primaryTextTheme.caption.color,
        //             )),
        //       ),
        //     ),
        //   ),
        // ),
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
        //Spacer(flex: 4),
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
                        //border: Border.all(color: isFilled ? BeldexPalette.teal:Theme.of(context).primaryTextTheme.headline5.color),
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
                                  // color: Colors.pink,
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      if (settingsStore
                                          .allowBiometricAuthentication) {
                                        _getAvailableBiometrics();
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
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Biometric feature currenly disabled.Kindly enable allow biometric authentication feature inside the app settings',
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

                                                // actions: <Widget>[
                                                //   FlatButton(
                                                //       onPressed: () => Navigator.of(context).pop(),
                                                //       child: Text(S.of(context).ok))
                                                // ],
                                              );
                                            });

                                        //     ScaffoldMessenger.of(context).showSnackBar(
                                        //       SnackBar(
                                        //   elevation: 5,
                                        //   shape: RoundedRectangleBorder(
                                        //       borderRadius: BorderRadius.only(
                                        //           topLeft: Radius.circular(10),
                                        //           topRight: Radius.circular(10))),
                                        //   content: Text(
                                        //     'Biometric feature currenly diabled.Kindly enable allow biometric authentication feature inside the app settings',
                                        //     style: TextStyle(color: Colors.white),
                                        //     textAlign: TextAlign.center,
                                        //   ),
                                        //   backgroundColor:
                                        //       Color.fromARGB(255, 46, 113, 43),
                                        //   duration: Duration(milliseconds: 1500),
                                        // )
                                        //     );

                                      }
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/new-images/fingerprint.svg',
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff060606),
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
                                // color: Colors.transparent,
                                // shape: CircleBorder(),
                                child: Icon(Icons.backspace_outlined,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .caption
                                        .color),
                              ),
                            );
                          } else {
                            index++;
                          }

                          return Container(
                            margin: EdgeInsets.only(
                                left: marginLeft, right: marginRight),
                            //color:Colors.green,
                            child: TextButton(
                              onPressed: () => _push(index),
                              // color: Colors.transparent,
                              // shape: CircleBorder(),
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
