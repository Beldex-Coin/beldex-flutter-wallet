import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
//import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class WelcomePage extends BasePage {
  static const _baseWidth = 411.43;

  @override
  Widget build(BuildContext context) {
   final settingsStore = Provider.of<SettingsStore>(context);
    return Scaffold(
        backgroundColor: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: body(context)));
  }

  @override
  Widget body(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = _screenWidth < _baseWidth ? 0.76 : 1.0;
   final settingsStore = Provider.of<SettingsStore>(context);
    return Stack(
      children: [
       Center(
         child: Container(
          height: _screenHeight*1.9/3,
          width:double.infinity,margin: EdgeInsets.all(_screenHeight*0.10/3),
          decoration: BoxDecoration(
           color:  settingsStore.isDarkTheme ? Color(0xff21212D) :Color(0xffEDEDED),
           borderRadius: BorderRadius.circular(20.0)
          ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: _screenHeight*0.10/3),
              child: Image.asset('assets/images/new-images/beldex_logo2.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(tr(context).wallet_list_title,
               style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textScaleFactor: textScaleFactor,
                        textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: _screenHeight*0.60/3,
              //color: Colors.green,
              child:SvgPicture.asset(settingsStore.isDarkTheme ? 'assets/images/new-images/Empty_screen_image.svg': 'assets/images/new-images/Empty_screen_image_white.svg')
            ),
            Text(
            tr(context).welcomeToBeldexWallet,
            style: TextStyle(
              fontSize: _screenHeight*0.05/3,
              fontWeight: FontWeight.w700,
              color: settingsStore.isDarkTheme ? Color(0xffAFAFBE) : Color(0xff303030),
            ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(
                tr(context).selectAnOptionBelowToCreateOrnRecoverExistingWallet,
                textAlign: TextAlign.center,
              style: TextStyle(
               
                fontSize: _screenHeight*0.05/3,
                color: settingsStore.isDarkTheme ? Color(0xffFFFFFF) : Color(0xff060606),

              ),
              ),
            ),
            SizedBox(height: 15.0,),
             SizedBox(
                      width: 230,
                      child: ElevatedButton.icon(
                        icon: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.transparent,
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: Colors.grey[900],
                                //       offset: Offset(0.0, 2.0),
                                //       blurRadius: 2.0)
                                // ]
                                ),
                           // child:SvgPicture.asset('assets/images/create_svg.svg',color: Colors.transparent,width: 15,height: 15,)
                            ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context,  Routes.restoreOptions);
                        },
                        label: Padding( padding: const EdgeInsets.only(left:12.0),child: Text(tr(context).restore_wallet,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)),
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            primary: Color(0xff2979FB), //.fromARGB(255, 46, 160, 33),
                            padding: EdgeInsets.all(13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ) /*PrimaryIconButton(
                      iconBackgroundColor: Colors.grey,
                      iconColor: Colors.white,
                      iconData: Icons.transform,
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.newWalletFromWelcome);
                      },
                      text: S.of(context).create_new,
                      color:
                      Theme.of(context).primaryTextTheme.button.backgroundColor,
                      borderColor:
                      Theme.of(context).primaryTextTheme.button.decorationColor),*/
                      ),
                      SizedBox(height: 10.0,),
                      SizedBox(
                      width: 230,
                      child: ElevatedButton.icon(
                        icon: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.transparent,
                                ),
                           // child: SvgPicture.asset('assets/images/create_svg.svg',color: Colors.transparent,width: 15,height: 15,)
                            ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.newWalletFromWelcome);
                        },
                        label: Padding( padding: const EdgeInsets.only(left:12.0),child: Text(tr(context).create_new,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)),
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            primary: Color(0xff0BA70F),  //Color.fromARGB(255, 46, 160, 33),
                            padding: EdgeInsets.all(13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ) /*PrimaryIconButton(
                      iconBackgroundColor: Colors.grey,
                      iconColor: Colors.white,
                      iconData: Icons.transform,
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.newWalletFromWelcome);
                      },
                      text: S.of(context).create_new,
                      color:
                      Theme.of(context).primaryTextTheme.button.backgroundColor,
                      borderColor:
                      Theme.of(context).primaryTextTheme.button.decorationColor),*/
                      ),
          ],
        ),
         ),
       ),
      Positioned(
        left:10.0,top:215.0,
        child:Container(
          height:65,width:65,
          child: Image.asset('assets/images/new-images/green_coin.png')) //Image.asset('assets/images/new-images/coin.png'),
      ),
      Positioned(
        right:2.0,bottom:260.0,
        child:Container(
          height:50,width:55,
          child: Image.asset('assets/images/new-images/blue_coin.png'))
      ),
      ],
    );
  }
}

// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//     Path path = Path();

//     // Path number 1

//     paint.color = Color(0xff2ea021).withOpacity(1.0);
//     path = Path();
//     path.lineTo(size.width / 2, size.height * 0.87);
//     path.cubicTo(size.width * 0.22, size.height * 0.87, 0, size.height * 0.64,
//         0, size.height * 0.37);
//     path.cubicTo(
//         0, size.height * 0.09, size.width * 0.22, -0.13, size.width / 2, -0.13);
//     path.cubicTo(size.width * 0.77, -0.13, size.width, size.height * 0.09,
//         size.width, size.height * 0.37);
//     path.cubicTo(size.width, size.height * 0.64, size.width * 0.77,
//         size.height * 0.87, size.width / 2, size.height * 0.87);
//     path.cubicTo(size.width / 2, size.height * 0.87, size.width / 2,
//         size.height * 0.87, size.width / 2, size.height * 0.87);
//     canvas.drawPath(path, paint);

//     // Path number 2

//     paint.color = Color(0xff048bf1).withOpacity(1.0);
//     path = Path();
//     path.lineTo(size.width, size.height * 0.63);
//     path.cubicTo(size.width * 0.81, size.height * 0.56, size.width * 0.71,
//         size.height / 3, size.width * 0.79, size.height * 0.11);
//     path.cubicTo(size.width * 0.86, -0.11, size.width * 1.07, -0.24,
//         size.width * 1.26, -0.17);
//     path.cubicTo(size.width * 1.46, -0.1, size.width * 1.55, size.height * 0.13,
//         size.width * 1.48, size.height * 0.35);
//     path.cubicTo(size.width * 1.4, size.height * 0.57, size.width * 1.19,
//         size.height * 0.7, size.width, size.height * 0.63);
//     path.cubicTo(size.width, size.height * 0.63, size.width, size.height * 0.63,
//         size.width, size.height * 0.63);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
