import 'package:flutter/material.dart';

class StandartSwitch extends StatefulWidget {
  const StandartSwitch({@required this.value, @required this.onTaped});

  final bool value;
  final VoidCallback onTaped;

  @override
  StandartSwitchState createState() => StandartSwitchState();
}

class StandartSwitchState extends State<StandartSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTaped,
      child: AnimatedContainer(
        padding: EdgeInsets.only(left: 0.0, right: 0.0),
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        duration: Duration(milliseconds: 250),
        width: 53.0,
        height: 20.0,
        decoration: BoxDecoration(
            //color: Theme.of(context).toggleButtonsTheme.color,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).accentTextTheme.headline6.backgroundColor,//Colors.black,
                Theme.of(context).accentTextTheme.headline6.backgroundColor,//Colors.grey[900],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
                color: Colors.grey,width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(100.0))),
        child: Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
              color: widget.value
                  ? Theme.of(context).primaryTextTheme.button.backgroundColor
                  : Theme.of(context).accentTextTheme.caption.decorationColor,
              borderRadius: BorderRadius.all(Radius.circular(100.0))),
          child: Icon(
            widget.value ? Icons.check : Icons.close,
            color: Colors.white,
            size: 12.0,
          ),
        ),
      ),
    );
  }
}
