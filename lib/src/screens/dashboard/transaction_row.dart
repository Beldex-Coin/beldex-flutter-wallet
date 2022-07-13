import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_direction.dart';

class TransactionRow extends StatelessWidget {
  TransactionRow(
      {this.direction,
      this.formattedDate,
      this.formattedAmount,
      this.formattedFiatAmount,
      this.isPending,
      @required this.onTap});

  final VoidCallback onTap;
  final TransactionDirection direction;
  final String formattedDate;
  final String formattedAmount;
  final String formattedFiatAmount;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 20),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).accentTextTheme.headline5.decorationColor,//PaletteDark.darkGrey
                      width: 0.5,
                      style: BorderStyle.solid))),
          child: Row(children: <Widget>[
            Container(
              height: 27,
              width: 27,
              child: Icon(
                direction == TransactionDirection.incoming
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded,
                color: direction == TransactionDirection.incoming
                    ? Colors.green
                    : Colors.red,
              ),
              decoration: BoxDecoration(
                color: direction == TransactionDirection.incoming
                    ? Colors.transparent
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            (direction == TransactionDirection.incoming
                                    ? S.of(context).received
                                    : S.of(context).sent) +
                                (isPending ? S.of(context).pending : ''),
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1
                                    .color)),
                        Text(formattedAmount,
                            style: const TextStyle(
                                fontSize: 16, color: Palette.purpleBlue))
                      ]),
                  SizedBox(height: 6),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(formattedDate,
                            style: const TextStyle(
                                fontSize: 13, color: Palette.blueGrey)),
                        Text(formattedFiatAmount,
                            style: const TextStyle(
                                fontSize: 14, color: Palette.blueGrey))
                      ]),
                ],
              ),
            ))
          ]),
        ));
  }
}
