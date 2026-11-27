import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumberStepper extends StatelessWidget {
  const NumberStepper({
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

  final double width;
  final int totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = width > 0
            ? width.clamp(0.0, constraints.maxWidth)
            : constraints.maxWidth;

        return Container(
          padding: const EdgeInsetsDirectional.all(5),
          width: availableWidth,
          child: Row(
            children: _steps(context),
          ),
        );
      },
    );
  }

  Color getCircleColor(int i) {
    final Color color;
    if (i + 1 < curStep) {
      color = const Color(0xff32324A); //currentStepColor; //stepCompleteColor;
    } else if (i + 1 == curStep) {
      color = const Color(0xff32324A); //currentStepColor;
    } else {
      color = const Color(0xff32324A); // Colors.white;
    }
    return color;
  }

  Color getBorderColor(int i) {
    final Color color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      color = const Color(0xff32324A); //currentStepColor;
    } else {
      color = const Color(0xff32324A); //inactiveColor;
    }

    return color;
  }

  Color? getLineColor(int i) {
    final color =
        curStep > i + 1 ? Colors.blue.withValues(alpha: 0.4) : Colors.grey[200];
    return color;
  }
  List<String> _titles(AppLocalizations t) =>
      [t.exchangePair, t.walletAddress, t.payment, t.exchange];
  List<Widget> _steps(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      final circleColor = getCircleColor(i);

      // step circles
      list.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 23.0,
              height: 23.0,
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: circleColor,
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(
                  color: const Color(0xff32324A), //borderColor,
                  width: 1.0,
                ),
              ),
              child: getInnerElementOfStepper(i, settingsStore),
            ),
            if ((i + 1) == curStep)
              Flexible(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 5.0),
                  child: Text(
                    _titles(tr(context))[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      backgroundColor: Colors.transparent,
                      color: settingsStore.isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
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
        margin: EdgeInsetsDirectional.all(3),

        child: Icon(
          Icons.check,
          color:settingsStore.isDarkTheme ? Color(0xff32324A)  : Colors.white,
          size: 10.0,
        ),
      );
    }
    // else if(index == curStep){
    //   return Container(
    //     margin: EdgeInsetsDirectional.all(3),
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
          margin: EdgeInsetsDirectional.all(5),
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