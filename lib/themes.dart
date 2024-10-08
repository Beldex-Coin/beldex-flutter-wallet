import 'package:flutter/material.dart';
import 'palette.dart';

class Themes {

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'OpenSans',
    brightness: Brightness.light,
    dialogBackgroundColor: Palette.lightThemeBackground,
    scaffoldBackgroundColor: Palette.lightThemeBlack,
    hintColor: Colors.grey[500],
    focusColor: Palette.lightGrey, // focused and enabled border color for text fields
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        color: BeldexPalette.black
      ),
      bodySmall: TextStyle(
        color: BeldexPalette.black,
      ),
      labelLarge: TextStyle(
        color: Colors.white,//BeldexPalette.black,
          backgroundColor: BeldexPalette.tealWithOpacity,
          decorationColor: BeldexPalette.teal
      ),
      titleMedium: TextStyle(
        color: Palette.darkThemeGrey,
        //color: BeldexPalette.black // account list tile, contact page
      ),
      /*subtitle2: TextStyle(
        color: Palette.wildDarkBlue, // filters
        backgroundColor:Palette.saveAndCopyButtonColor1
      ),
      subtitle1: TextStyle(
        color: BeldexPalette.black // transaction raw, trade raw
      ),
      overline: TextStyle(
        color: PaletteDark.darkThemeCloseButton // standard list row, transaction details
      )*/
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      selectedColor: BeldexPalette.teal,
      disabledColor: Palette.wildDarkBlue,
      color: Palette.switchBackground,
      borderColor: Palette.switchBorder
    ),
    dividerColor: Colors.black,//Palette.lightGrey,
    dividerTheme: DividerThemeData(
      color: Colors.grey,//Palette.lightGrey
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Palette.backPressButtonColor,
        //color: Colors.grey,
        backgroundColor: Palette.receiveCardBackgroundColor,
        //backgroundColor: Palette.creamyGrey // pin button color
      ),
      bodySmall: TextStyle(
        color: Palette.wildDarkBlue, // clear button color, exchange page
        backgroundColor: Palette.lightThemeBlack, // button blue background color
        decorationColor: Palette.buttonColor, // button blue border color
      ),
      labelLarge: TextStyle(
        backgroundColor: Colors.transparent, // button indigo background color
        decorationColor: Palette.deepIndigo // button indigo border color
      ),
      /*subtitle2: TextStyle(
        color: BeldexPalette.black,
        backgroundColor: Palette.lightLavender // send page border color
      ),*/
      titleMedium: TextStyle(
        color: Colors.black, // receive page
        backgroundColor: Colors.transparent, // restore button background color
        decorationColor: Palette.dashBoardBorderColor,//Palette.darkGrey, // restore button border color
      ),
      /*subtitle1: TextStyle(
        color: Palette.lightBlue, // restore button description
        backgroundColor: Palette.lightGrey2 // change language background color
      ),
      overline: TextStyle(
        color: Colors.black,//BeldexPalette.blue, // send page text
        backgroundColor: Palette.primaryButtonBackgroundColor,//BeldexPalette.blue, // send page text
        decorationColor: Palette.manatee // send page text
      )*/
    ),
    cardColor: Palette.cardBackgroundColor,
    //cardColor: Palette.lavender,
    cardTheme: CardTheme(
      color: Palette.cardColor,
      shadowColor: Palette.cardButtonColor,
      //color: Palette.cadetBlue
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Palette.darkGrey,
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.white
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Palette.saveAndCopyButtonColor,//Colors.white
    )
  );


  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'OpenSans',
    brightness: Brightness.dark,
    dialogBackgroundColor: PaletteDark.darkThemeBackground,
    scaffoldBackgroundColor: PaletteDark.darkThemeBlack,
    hintColor: PaletteDark.darkThemeGrey,
    focusColor: PaletteDark.darkThemeGreyWithOpacity, // focused and enabled border color for text fields
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white
      ),
      bodySmall: TextStyle(
        color: Colors.white
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        backgroundColor: BeldexPalette.tealWithOpacity, // button indigo background color
        decorationColor: BeldexPalette.tealWithOpacity // button indigo border color
      ),
      titleMedium: TextStyle(
        color: PaletteDark.darkThemeGrey // account list tile, contact page
      ),
      titleSmall: TextStyle(
          color: Palette.blueGrey // transaction raw, trade raw
      ),
      /*subtitle2: TextStyle(
        color: PaletteDark.darkThemeGrey ,// filters
        backgroundColor:PaletteDark.saveAndCopyButtonColor1
      ),
      overline: TextStyle(
        color: PaletteDark.darkThemeGrey // standard list row, transaction details
      )*/
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      selectedColor: BeldexPalette.teal,
      disabledColor: Palette.wildDarkBlue,
      color: PaletteDark.switchBackground,
      borderColor: PaletteDark.darkThemeMidGrey
    ),
    dividerColor: Colors.white,//PaletteDark.darkThemeDarkGrey,
    dividerTheme: DividerThemeData(
      color: PaletteDark.darkThemeGreyWithOpacity
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: PaletteDark.backPressButtonColor,
        //color: PaletteDark.darkThemeTitle,
        backgroundColor:PaletteDark.receiveCardBackgroundColor,
        //backgroundColor: PaletteDark.darkThemePinDigitButton // pin button color
      ),
      bodySmall: TextStyle(
        color: PaletteDark.darkThemeTitleViolet, // clear button color, exchange page
        backgroundColor: PaletteDark.darkThemeBlueButton, // button blue background color
        decorationColor: PaletteDark.buttonColor, // button blue border color
      ),
      labelLarge: TextStyle(
        backgroundColor: Colors.transparent, // button indigo background color
        decorationColor: PaletteDark.darkThemeIndigoButtonBorder // button indigo border color
      ),
      /*subtitle2: TextStyle(
        color: PaletteDark.wildDarkBlueWithOpacity,
        backgroundColor: PaletteDark.darkThemeDarkGrey // send page border color
      ),*/
      titleMedium: TextStyle(
        color: Colors.white, // receive page
        backgroundColor: Colors.transparent, // restore button background color
        decorationColor: PaletteDark.darkGrey,//PaletteDark.darkThemeDarkGrey, // restore button border color
      ),
      titleSmall: TextStyle(
        color: Palette.wildDarkBlue, // restore button description
        backgroundColor: PaletteDark.darkThemeMidGrey // change language background color
      ),
      /*overline: TextStyle(
        color: PaletteDark.darkThemeTitle, // send page text
        backgroundColor: PaletteDark.primaryButtonBackgroundColor,//PaletteDark.darkThemeGrey, // send page text
        decorationColor: PaletteDark.darkThemeTitle // send page text
      )*/
    ),
    cardColor: PaletteDark.cardBackgroundColor,
    //cardColor: PaletteDark.darkThemeMidGrey,
    cardTheme: CardTheme(
      color: PaletteDark.cardColor,
      shadowColor: PaletteDark.cardButtonColor,
      //color: PaletteDark.darkThemeGrey
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: PaletteDark.darkThemePinButton,
    ),
    primaryIconTheme: IconThemeData(
      color: PaletteDark.darkThemeViolet
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: PaletteDark.saveAndCopyButtonColor,//PaletteDark.darkThemeIndigoButtonBorder
    )
  );

}