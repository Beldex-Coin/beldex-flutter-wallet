import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_direction.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TransactionRow extends StatelessWidget {
  TransactionRow(
      {this.direction,
      this.formattedDate,
      this.formattedAmount,
      this.formattedFiatAmount,
      this.isPending,
      @required this.onTap,
       //this.isStake
      });

  final VoidCallback onTap;
  final TransactionDirection direction;
  final String formattedDate;
  final String formattedAmount;
  final String formattedFiatAmount;
  final bool isPending;
  final bool flag = false;
 // final bool isStake;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(left:18,right: 18),
          padding: EdgeInsets.only(top: 14, bottom: 14, left: 10, right: 20),
          decoration: BoxDecoration(
            //color: Color(0xff24242F),
          color : settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED),
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).accentTextTheme.headline5.decorationColor,//PaletteDark.darkGrey
                      width: 0.5,
                      style: BorderStyle.solid))),
          child: Column(
            children: [
              Row(children: <Widget>[
                Container(
                  height: 27,
                  width: 27,
                 // margin: EdgeInsets.only(right:8.0),
                  // Icon(
                  //   direction == TransactionDirection.incoming
                  //       ? Icons.arrow_downward_rounded
                  //       : Icons.arrow_upward_rounded,
                  //   color: direction == TransactionDirection.incoming
                  //       ? Colors.green
                  //       : Colors.red,
                  // ),
                  decoration: BoxDecoration(
                   // color:Colors.yellow,
                    //  direction == TransactionDirection.incoming
                    //     ? Colors.transparent
                    //     : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    
                    direction == TransactionDirection.incoming ?
                    'assets/images/new-images/incoming.svg'
                    :'assets/images/new-images/outgoing.svg',
                     color: direction == TransactionDirection.incoming
                        ? Colors.green
                        : Colors.red,
                        //fit:BoxFit.cover
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
                            
                            Text(formattedAmount,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                    fontSize: 14, color: settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
                                    Text(
                                (direction == TransactionDirection.incoming
                                        ? S.of(context).received
                                        : S.of(context).sent) +
                                    (isPending ? S.of(context).pending : // isStake ? S.of(context).stake :
                                     ''),
                                style: TextStyle(
                                    fontSize: 14,
                                    color:settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
                          ]),
                      SizedBox(height: 6),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(formattedDate,
                                style: TextStyle(
                                    fontSize: 13, color: settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
                            // Text(formattedFiatAmount,
                            //     style: const TextStyle(
                            //         fontSize: 14, color: Palette.blueGrey))
                          ]),
                    ],
                  ),
                )),
                Icon(Icons.keyboard_arrow_down)
              ]),
            flag ? Container(
                height:200,
                child: Column(
                  children: [
                    Text('data'),
                  ],
                ),
              )
              : SizedBox.shrink(),
            ],
          ),
        ));
  }
}








// import 'package:flutter/material.dart';
// import 'package:beldex_wallet/generated/l10n.dart';
// import 'package:beldex_wallet/palette.dart';
// import 'package:beldex_wallet/src/wallet/transaction/transaction_direction.dart';

// class TransactionRow extends StatelessWidget {
//   TransactionRow(
//       {this.direction,
//       this.formattedDate,
//       this.formattedAmount,
//       this.formattedFiatAmount,
//       this.isPending,
//       @required this.onTap, //this.isStake
//       });

//   final VoidCallback onTap;
//   final TransactionDirection direction;
//   final String formattedDate;
//   final String formattedAmount;
//   final String formattedFiatAmount;
//   final bool isPending;
//  // final bool isStake;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: onTap,
//         child: Container(
//           padding: EdgeInsets.only(top: 14, bottom: 14, left: 20, right: 20),
//           decoration: BoxDecoration(
//               border: Border(
//                   bottom: BorderSide(
//                       color: Theme.of(context).accentTextTheme.headline5.decorationColor,//PaletteDark.darkGrey
//                       width: 0.5,
//                       style: BorderStyle.solid))),
//           child: Row(children: <Widget>[
//             Container(
//               height: 27,
//               width: 27,
//               child: Icon(
//                 direction == TransactionDirection.incoming
//                     ? Icons.arrow_downward_rounded
//                     : Icons.arrow_upward_rounded,
//                 color: direction == TransactionDirection.incoming
//                     ? Colors.green
//                     : Colors.red,
//               ),
//               decoration: BoxDecoration(
//                 color: direction == TransactionDirection.incoming
//                     ? Colors.transparent
//                     : Colors.transparent,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             Expanded(
//                 child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text(
//                             (direction == TransactionDirection.incoming
//                                     ? S.of(context).received
//                                     : S.of(context).sent) +
//                                 (isPending ? S.of(context).pending : // isStake ? S.of(context).stake :
//                                  ''),
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Theme.of(context)
//                                     .primaryTextTheme
//                                     .subtitle1
//                                     .color)),
//                         Text(formattedAmount,
//                             style: const TextStyle(
//                                 fontSize: 16, color: Palette.purpleBlue))
//                       ]),
//                   SizedBox(height: 6),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text(formattedDate,
//                             style: const TextStyle(
//                                 fontSize: 13, color: Palette.blueGrey)),
//                         Text(formattedFiatAmount,
//                             style: const TextStyle(
//                                 fontSize: 14, color: Palette.blueGrey))
//                       ]),
//                 ],
//               ),
//             ))
//           ]),
//         ));
//   }
// }
