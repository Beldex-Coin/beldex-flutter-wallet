import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/src/screens/restore/widgets/restore_button.dart';
import 'package:beldex_wallet/src/screens/restore/widgets/image_widget.dart';
import 'package:beldex_wallet/src/screens/restore/widgets/base_restore_widget.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/generated/l10n.dart';

class RestoreOptionsPage extends BasePage {
  static const _aspectRatioImage = 2.086;

  @override
  String get title => S.current.restore_restore_wallet;

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
  Color get backgroundColor => Palette.creamyGrey;

  //final _imageSeedKeys = Image.asset('assets/images/seedKeys.png');
  //final _imageRestoreSeed = Image.asset('assets/images/restoreSeed.png');

  @override
  Widget body(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.height > largeHeight;

    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(left: 40,right: 40,top: 50),
          elevation: 5,
          color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child:Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).restore_title_from_seed_keys,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(height: 15),
                      Text(S.of(context).restore_description_from_seed_keys,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                        context, Routes.restoreWalletOptionsFromWelcome);
                  },
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).primaryTextTheme.button.backgroundColor,size: 35,),
                  ),
                )
              ],
            ),
          ),
        ),
        /*Card(
          margin: EdgeInsets.only(left: 40,right: 40,top: 20),
          elevation: 5,
          color: Color.fromARGB(255, 40, 42, 51),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child:Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).restore_title_from_seed_keys,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(S.of(context).restore_description_from_seed_keys,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).accentTextTheme.caption.decorationColor,size: 35,),
                  ),
                )
              ],
            ),
          ),
        ),*/
      ],
    )/*BaseRestoreWidget(
      firstRestoreButton: RestoreButton(
        onPressed: () =>
          Navigator.pushNamed(
              context, Routes.restoreWalletOptionsFromWelcome),
        imageWidget: ImageWidget(
          image: _imageSeedKeys,
          aspectRatioImage: _aspectRatioImage,
          isLargeScreen: isLargeScreen,
        ),
        titleColor: Palette.lightViolet,
        color: Palette.lightViolet,
        title: S.of(context).restore_title_from_seed_keys,
        description: S.of(context).restore_description_from_seed_keys,
        textButton: S.of(context).restore_next,
      ),
      secondRestoreButton: RestoreButton(
        onPressed: () {},
        imageWidget: ImageWidget(
          image: _imageRestoreSeed,
          aspectRatioImage: _aspectRatioImage,
          isLargeScreen: isLargeScreen,
        ),
        titleColor: BeldexPalette.teal,
        color: BeldexPalette.teal,
        title: S.of(context).restore_title_from_backup,
        description: S.of(context).restore_description_from_backup,
        textButton: S.of(context).restore_next,
      ),
      isLargeScreen: isLargeScreen,
    )*/;
  }
}
