import 'package:beldex_wallet/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';

import 'beldex_dialog.dart';

Future<T?> presentPicker<T extends Object>(
    BuildContext context, List<T> list) async {
  var _value = list[0];

  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BeldexDialog(
            body: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(tr(context).please_select,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .caption!
                                  .color))),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 30),
                    child: Container(
                      height: 150.0,
                      child: CupertinoPicker(
                          backgroundColor: Theme.of(context).backgroundColor,
                          itemExtent: 45.0,
                          onSelectedItemChanged: (int index) =>
                              _value = list[index],
                          children: List.generate(
                              list.length,
                              (index) => Center(
                                    child: Text(
                                      list[index].toString(),
                                      style: TextStyle(
                                          backgroundColor: Colors.transparent,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .caption!
                                              .color),
                                    ),
                                  ))),
                    ),
                  ),
                  PrimaryButton(
                    text: tr(context).ok,
                    color: Theme.of(context)
                        .primaryTextTheme
                        .button!
                        .backgroundColor!,
                    borderColor: Theme.of(context)
                        .primaryTextTheme
                        .button!
                        .decorationColor!,
                    onPressed: () => Navigator.of(context).pop(_value),
                  )
                ],
              ),
            ));
      });
}
