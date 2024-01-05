import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final int totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  NumberStepper({
    Key? key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
  })  : assert(curStep > 0 == true && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(5),
      // only(
      //   top: 20.0,
      //   left: 24.0,
      //   right: 24.0,
      // ),
      width: this.width,
      child: Row(
        children: _steps(context),
      ),
    );
  }

  Color getCircleColor(int i) {
    Color color;
    if (i + 1 < curStep) {
      color =Color(0xff32324A); //currentStepColor; //stepCompleteColor;
    } else if (i + 1 == curStep)
      color = Color(0xff32324A); //currentStepColor;
    else
      color = Color(0xff32324A); // Colors.white;
    return color;
  }

  Color getBorderColor(int i) {
    Color color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = Color(0xff32324A); //currentStepColor;
    else
      color = Color(0xff32324A);//inactiveColor;

    return color;
  }

  Color? getLineColor(int i) {
    var color =
    curStep > i + 1 ? Colors.blue.withOpacity(0.4) : Colors.grey[200];
    return color;
  }
  List<String> titles =['Exchange Pair','Wallet address','Payment','Exchange'];
  List<Widget> _steps(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Row(
          children: [
            Container(
              width: 23.0,
              height: 23.0,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: circleColor,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(
                  color:Color(0xff32324A), //borderColor,
                  width: 1.0,
                ),
              ),
              child: getInnerElementOfStepper(i,settingsStore),
            ),
            (i + 1) == curStep ? Padding(
              padding: const EdgeInsets.only(right:5.0),
              child: Text('${titles[i]}',style: TextStyle(backgroundColor: Colors.transparent,color:settingsStore.isDarkTheme ? Colors.white : Colors.black,fontSize:16 ,fontWeight: FontWeight.w800),),
            ) : SizedBox.shrink()
          ],
        ),
      );

      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
                height: lineWidth,
                color:Color(0xff3A3A45) //lineColor,
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(int index,SettingsStore settingsStore) {
    if (index + 1 < curStep) {
      return Container(
        height: 18,width: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff20D030),
        ),
        margin: EdgeInsets.all(3),

        child: Icon(
          Icons.check,
          color:settingsStore.isDarkTheme ? Color(0xff32324A)  : Colors.white,
          size: 10.0,
        ),
      );
    }
    // else if(index == curStep){
    //   return Container(
    //     margin: EdgeInsets.all(3),
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       color: Colors.grey,
    //     ),
    //   );
    //   Center(
    //   child: Text(
    //     '$curStep',
    //     style: TextStyle(
    //       backgroundColor: Colors.transparent,
    //       color: Colors.blue,
    //       fontWeight: FontWeight.bold,
    //       fontFamily: 'Roboto',
    //     ),
    //   ),
    // );
    // }
    else if (index + 1 == curStep) {
      return
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffA9A9CD),
          ),
        );
      //   Center(
      //   child: Text('s',
      //     //'$curStep',
      //     style: TextStyle(
      //       backgroundColor: Colors.transparent,
      //       color: Colors.blue,
      //       fontWeight: FontWeight.bold,
      //       fontFamily: 'Roboto',
      //     ),
      //   ),
      // );
    } else {
      return
        Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
              backgroundColor: Colors.transparent,
              color: Color(0xffA9A9CD),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        );
    } //Container();
  }
}