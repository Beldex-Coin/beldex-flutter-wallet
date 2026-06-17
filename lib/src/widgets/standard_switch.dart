import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class StandardSwitch extends StatefulWidget {
  

   StandardSwitch({this.boxWidth = 50.0, this.boxHeight = 20.0, this.iconWidth = 22.0, this.iconHeight = 22.0, this.enableGradient = true, this.backgroundColor, required this.value, required this.onTaped,required this.icon});

  final bool value;
  final VoidCallback onTaped;
  bool icon=false;
  double boxWidth;
  double boxHeight;
  double iconWidth;
  double iconHeight;
  final bool enableGradient;
  final backgroundColor;
  @override
  StandardSwitchState createState() => StandardSwitchState();
}

class StandardSwitchState extends State<StandardSwitch> {
  @override
  Widget build(BuildContext context) {
     final settingsStore = Provider.of<SettingsStore>(context);
    return GestureDetector(
      onTap: widget.onTaped,
      child: AnimatedContainer(
        padding: EdgeInsets.only(left: 0.0, right: 0.0),
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        duration: Duration(milliseconds: 250),
        width: widget.boxWidth,
        height: widget.boxHeight,
        decoration: BoxDecoration(
            color:widget.enableGradient ? settingsStore.isDarkTheme ? Color(0xff333343): Color(0xffEDEDED) : widget.backgroundColor,  //Theme.of(context).toggleButtonsTheme.color,
            gradient: widget.enableGradient ?LinearGradient(
              colors: [
                settingsStore.isDarkTheme?Color.fromARGB(255, 31, 32, 39):Color.fromARGB(
                    255, 235, 235, 235),//Colors.black,
                settingsStore.isDarkTheme?Color.fromARGB(255, 31, 32, 39):Color.fromARGB(
                    255, 235, 235, 235),//Colors.grey[900],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ) : null,
            // border: Border.all(
            //     color: Colors.grey,width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(100.0))),
        child: Container(
          width: widget.iconWidth,
          height: widget.iconHeight,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            //shape:BoxShape.circle,
              color:widget.icon ? widget.value ? Color(0xff0BA70F) : Color(0xff737373) :
               widget.value
                   ? Theme.of(context).primaryTextTheme.labelLarge?.backgroundColor
                   : Theme.of(context).textTheme.bodySmall?.decorationColor,
              borderRadius: BorderRadius.all(Radius.circular(100.0))),
          child:  widget.icon ? widget.value ?
         SvgPicture.asset('assets/images/new-images/moon_image.svg') :  SvgPicture.asset('assets/images/new-images/sun_image.svg') : Container()
        ),
      ),
    );
  }
}
