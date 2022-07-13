import 'package:flutter/material.dart';
import 'palette.dart';

class Themes {

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Lato',
    brightness: Brightness.light,
    backgroundColor: Palette.lightThemeBackground,
    scaffoldBackgroundColor: Palette.lightThemeBlack,
    hintColor: Colors.grey[500],
    focusColor: Palette.lightGrey, // focused and enabled border color for text fields
    primaryTextTheme: TextTheme(
      headline6: TextStyle(
        color: BeldexPalette.black
      ),
      caption: TextStyle(
        color: BeldexPalette.black,
      ),
      button: TextStyle(
        color: Colors.white,//BeldexPalette.black,
          backgroundColor: BeldexPalette.tealWithOpacity,
          decorationColor: BeldexPalette.teal
      ),
      headline5: TextStyle(
        color: Palette.darkThemeGrey,
        //color: BeldexPalette.black // account list tile, contact page
      ),
      subtitle2: TextStyle(
        color: Palette.wildDarkBlue, // filters
        backgroundColor:Palette.saveAndCopyButtonColor1
      ),
      subtitle1: TextStyle(
        color: BeldexPalette.black // transaction raw, trade raw
      ),
      overline: TextStyle(
        color: PaletteDark.darkThemeCloseButton // standard list row, transaction details
      )
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      selectedColor: BeldexPalette.teal,
      disabledColor: Palette.wildDarkBlue,
      color: Palette.switchBackground,
      borderColor: Palette.switchBorder
    ),
    selectedRowColor: Colors.grey,//BeldexPalette.tealWithOpacity,
    dividerColor: Colors.black,//Palette.lightGrey,
    dividerTheme: DividerThemeData(
      color: Colors.grey,//Palette.lightGrey
    ),
    accentTextTheme: TextTheme(
      headline6: TextStyle(
        color: Palette.backPressButtonColor,
        //color: Colors.grey,
        backgroundColor: Palette.receiveCardBackgroundColor,
        //backgroundColor: Palette.creamyGrey // pin button color
      ),
      caption: TextStyle(
        color: Palette.wildDarkBlue, // clear button color, exchange page
        backgroundColor: Palette.lightThemeBlack, // button blue background color
        decorationColor: Palette.buttonColor, // button blue border color
      ),
      button: TextStyle(
        backgroundColor: Palette.indigo, // button indigo background color
        decorationColor: Palette.deepIndigo // button indigo border color
      ),
      subtitle2: TextStyle(
        color: BeldexPalette.black,
        backgroundColor: Palette.lightLavender // send page border color
      ),
      headline5: TextStyle(
        color: Palette.lightGrey2, // receive page
        backgroundColor: Colors.white, // restore button background color
        decorationColor: Palette.dashBoardBorderColor,//Palette.darkGrey, // restore button border color
      ),
      subtitle1: TextStyle(
        color: Palette.lightBlue, // restore button description
        backgroundColor: Palette.lightGrey2 // change language background color
      ),
      overline: TextStyle(
        color: Colors.black,//BeldexPalette.blue, // send page text
        backgroundColor: Palette.primaryButtonBackgroundColor,//BeldexPalette.blue, // send page text
        decorationColor: Palette.manatee // send page text
      )
    ),
    cardColor: Palette.cardBackgroundColor,
    //cardColor: Palette.lavender,
    cardTheme: CardTheme(
      color: Palette.cardColor,
      shadowColor: Palette.cardButtonColor,
      //color: Palette.cadetBlue
    ),
    buttonColor: Palette.darkGrey,
    primaryIconTheme: IconThemeData(
      color: Colors.white
    ),
    accentIconTheme: IconThemeData(
      color: Palette.saveAndCopyButtonColor,//Colors.white
    )
  );


  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Lato',
    brightness: Brightness.dark,
    backgroundColor: PaletteDark.darkThemeBackground,
    scaffoldBackgroundColor: PaletteDark.darkThemeBlack,
    hintColor: PaletteDark.darkThemeGrey,
    focusColor: PaletteDark.darkThemeGreyWithOpacity, // focused and enabled border color for text fields
    primaryTextTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white
      ),
      caption: TextStyle(
        color: Colors.white
      ),
      button: TextStyle(
        color: Colors.white,
        backgroundColor: BeldexPalette.tealWithOpacity, // button indigo background color
        decorationColor: BeldexPalette.tealWithOpacity // button indigo border color
      ),
      headline5: TextStyle(
        color: PaletteDark.darkThemeGrey // account list tile, contact page
      ),
      subtitle2: TextStyle(
        color: PaletteDark.darkThemeGrey ,// filters
        backgroundColor:PaletteDark.saveAndCopyButtonColor1
      ),
        subtitle1: TextStyle(
        color: Palette.blueGrey // transaction raw, trade raw
      ),
      overline: TextStyle(
        color: PaletteDark.darkThemeGrey // standard list row, transaction details
      )
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      selectedColor: BeldexPalette.teal,
      disabledColor: Palette.wildDarkBlue,
      color: PaletteDark.switchBackground,
      borderColor: PaletteDark.darkThemeMidGrey
    ),
    selectedRowColor: Colors.grey,//BeldexPalette.tealWithOpacity,
    dividerColor: Colors.white,//PaletteDark.darkThemeDarkGrey,
    dividerTheme: DividerThemeData(
      color: PaletteDark.darkThemeGreyWithOpacity
    ),
    accentTextTheme: TextTheme(
      headline6: TextStyle(
        color: PaletteDark.backPressButtonColor,
        //color: PaletteDark.darkThemeTitle,
        backgroundColor:PaletteDark.receiveCardBackgroundColor,
        //backgroundColor: PaletteDark.darkThemePinDigitButton // pin button color
      ),
      caption: TextStyle(
        color: PaletteDark.darkThemeTitleViolet, // clear button color, exchange page
        backgroundColor: PaletteDark.darkThemeBlueButton, // button blue background color
        decorationColor: PaletteDark.buttonColor, // button blue border color
      ),
      button: TextStyle(
        backgroundColor: PaletteDark.darkThemeIndigoButton, // button indigo background color
        decorationColor: PaletteDark.darkThemeIndigoButtonBorder // button indigo border color
      ),
      subtitle2: TextStyle(
        color: PaletteDark.wildDarkBlueWithOpacity,
        backgroundColor: PaletteDark.darkThemeDarkGrey // send page border color
      ),
      headline5: TextStyle(
        color: PaletteDark.darkThemeBlack, // receive page
        backgroundColor: PaletteDark.darkThemeMidGrey, // restore button background color
        decorationColor: PaletteDark.darkGrey,//PaletteDark.darkThemeDarkGrey, // restore button border color
      ),
      subtitle1: TextStyle(
        color: Palette.wildDarkBlue, // restore button description
        backgroundColor: PaletteDark.darkThemeMidGrey // change language background color
      ),
      overline: TextStyle(
        color: PaletteDark.darkThemeTitle, // send page text
        backgroundColor: PaletteDark.primaryButtonBackgroundColor,//PaletteDark.darkThemeGrey, // send page text
        decorationColor: PaletteDark.darkThemeTitle // send page text
      )
    ),
    cardColor: PaletteDark.cardBackgroundColor,
    //cardColor: PaletteDark.darkThemeMidGrey,
    cardTheme: CardTheme(
      color: PaletteDark.cardColor,
      shadowColor: PaletteDark.cardButtonColor,
      //color: PaletteDark.darkThemeGrey
    ),
    buttonColor: PaletteDark.darkThemePinButton,
    primaryIconTheme: IconThemeData(
      color: PaletteDark.darkThemeViolet
    ),
    accentIconTheme: IconThemeData(
      color: PaletteDark.saveAndCopyButtonColor,//PaletteDark.darkThemeIndigoButtonBorder
    )
  );

}