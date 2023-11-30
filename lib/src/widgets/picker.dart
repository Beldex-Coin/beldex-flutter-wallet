import 'dart:ui';

import 'package:flutter/material.dart';

import '../../routes.dart';

class Picker<Item extends Object> extends StatelessWidget {
  Picker(
      {@required this.selectedAtIndex,
      @required this.items,
      @required this.title,
      this.pickerHeight = 300,
      this.onItemSelected});

  final int selectedAtIndex;
  final List<Item> items;
  final String title;
  final double pickerHeight;
  final Function(Item) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => null,
                  child: Container(
                      width: double.infinity,
                      height: pickerHeight,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: ListView.separated(
                        itemCount: items.length + 1,
                        separatorBuilder: (_, index) => index == 0
                            ? SizedBox()
                            : Divider(
                                height: 1,
                                thickness: 2,
                                color: Theme.of(context).accentTextTheme.headline5.decorationColor,//Color.fromRGBO(235, 238, 242, 1.0)
                        ),
                        itemBuilder: (_, index) {
                          if (index == 0) {
                            return Container(
                              height: 100,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .caption
                                          .color),
                                ),
                              ),
                            );
                          }

                          index -= 1;
                          final item = items[index];

                          return GestureDetector(
                            onTap: () {
                              if (onItemSelected == null) {
                                return;
                              }
                              Navigator.of(context).pop();
                              onItemSelected(item);
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(top: 18, bottom: 18),
                              child: Center(
                                  child: Text(
                                item.toString(),
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: index == selectedAtIndex
                                        ? Color.fromRGBO(138, 80, 255, 1.0)
                                        : Theme.of(context)
                                            .primaryTextTheme
                                            .caption
                                            .color),
                              )),
                            ),
                          );
                        },
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
