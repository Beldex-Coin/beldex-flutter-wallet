import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_info.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_direction.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TransactionRow extends StatelessWidget {
  TransactionRow(
      {this.direction,
      this.formattedDate,
      this.formattedAmount,
      this.formattedFiatAmount,
      this.isPending,
      @required this.onTap, this.transaction,
       //this.isStake
      });

  final VoidCallback onTap;
  final TransactionDirection direction;
  final String formattedDate;
  final String formattedAmount;
  final String formattedFiatAmount;
  final bool isPending;
  final bool flag = false;

  final TransactionInfo transaction;
 // final bool isStake;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return InkWell(
       // onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(left:18,right: 18),
          //padding: EdgeInsets.only(top: 14, bottom: 14, left: 10, right: 20),
          decoration: BoxDecoration(
            //color: Color(0xff24242F),
          color : settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED),
              // border: Border(
              //     bottom: BorderSide(
              //         color: Theme.of(context).accentTextTheme.headline5.decorationColor,//PaletteDark.darkGrey
              //         width: 0.5,
              //         style: BorderStyle.solid))
                      ),
          child: Theme(
                  data: Theme.of(context).copyWith(accentColor:settingsStore.isDarkTheme ? Colors.white : Colors.black,
                  dividerColor: Colors.transparent,
                  textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Colors.green
                  )),
            child: ExpansionTile(
             // initiallyExpanded: true,
              title:Container(
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
                        //color:Colors.yellow,
                        //  direction == TransactionDirection.incoming
                        //     ? Colors.transparent
                        //     : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: direction ==TransactionDirection.incoming ? SvgPicture.asset(
                        
                        // direction == TransactionDirection.incoming ?
                         'assets/images/new-images/incoming.svg',
                        // :
                        
                         color: direction == TransactionDirection.incoming
                            ? Colors.green
                            : Colors.red,
                            //fit:BoxFit.cover
                        ): Padding(padding: EdgeInsets.all(5),
                        child: SvgPicture.asset('assets/images/new-images/outgoing_red.svg',),
                        )
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
                    //Icon(Icons.keyboard_arrow_down)
                  ]),
                  ],
                ),
              ),
              
              
            //   Expanded(
            //     child: Container(
            //       child:
            //        Column(
            //     children: [
            //       Row(children: <Widget>[
            //         Container(
            //           height: 27,
            //           width: 27,
            //          // margin: EdgeInsets.only(right:8.0),
            //           // Icon(
            //           //   direction == TransactionDirection.incoming
            //           //       ? Icons.arrow_downward_rounded
            //           //       : Icons.arrow_upward_rounded,
            //           //   color: direction == TransactionDirection.incoming
            //           //       ? Colors.green
            //           //       : Colors.red,
            //           // ),
            //           decoration: BoxDecoration(
            //            // color:Colors.yellow,
            //             //  direction == TransactionDirection.incoming
            //             //     ? Colors.transparent
            //             //     : Colors.transparent,
            //             shape: BoxShape.circle,
            //           ),
            //           child: SvgPicture.asset(
                        
            //             direction == TransactionDirection.incoming ?
            //             'assets/images/new-images/incoming.svg'
            //             :'assets/images/new-images/outgoing.svg',
            //              color: direction == TransactionDirection.incoming
            //                 ? Colors.green
            //                 : Colors.red,
            //                 //fit:BoxFit.cover
            //             ),
            //         ),
            //         Expanded(
            //             child: Padding(
            //           padding: const EdgeInsets.only(left: 10, right: 10),
            //           child: Column(
            //             children: <Widget>[
            //               Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: <Widget>[
                                
            //                     Text(formattedAmount,
            //                         style: TextStyle(
            //                           fontWeight: FontWeight.w900,
            //                             fontSize: 14, color: settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
            //                             Text(
            //                         (direction == TransactionDirection.incoming
            //                                 ? S.of(context).received
            //                                 : S.of(context).sent) +
            //                             (isPending ? S.of(context).pending : // isStake ? S.of(context).stake :
            //                              ''),
            //                         style: TextStyle(
            //                             fontSize: 14,
            //                             color:settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
            //                   ]),
            //               SizedBox(height: 6),
            //               Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: <Widget>[
            //                     Text(formattedDate,
            //                         style: TextStyle(
            //                             fontSize: 13, color: settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
            //                     // Text(formattedFiatAmount,
            //                     //     style: const TextStyle(
            //                     //         fontSize: 14, color: Palette.blueGrey))
            //                   ]),
            //             ],
            //           ),
            //         )),
            //         //Icon(Icons.keyboard_arrow_down)
            //       ]),
         
            //     ],
            // ),
            //     ),
            //   ),

               children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text(S.of(context).transaction_details_transaction_id,style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900

                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Row(
                              children: [
                               Expanded(child: Text( transaction.id,
                               style: TextStyle(color: Color(0xffACACAC),
                               fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900
                               ),
                               )),
                               InkWell(
                                onTap: (){
                                  Clipboard.setData(ClipboardData(
                                                              text: transaction.id));
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                           margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.30/3,
                                                           left: MediaQuery.of(context).size.height*0.30/3,
                                                           right: MediaQuery.of(context).size.height*0.30/3
                                                           ),
                                                            elevation:0, //5,
                                                            behavior: SnackBarBehavior.floating,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0) //only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                                            ),
                                                            content: Text(S
                                                                .of(context)
                                                                .copied,style: TextStyle(color: Color(0xff0EB212),fontWeight:FontWeight.w700,fontSize:15) ,textAlign: TextAlign.center,),
                                                            backgroundColor: Color(0xff0BA70F).withOpacity(0.10), //.fromARGB(255, 46, 113, 43),
                                                            duration: Duration(
                                                                milliseconds: 1500),
                                                          ));
                                },
                                 child: Container(
                                  //height:20,width:40,
                                  padding: EdgeInsets.only(left:20.0,right:10,top:10,bottom:10),
                                  child:Icon(Icons.copy,size: 20,color: Color(0xff0BA70F),)
                                 ),
                               )
                            ],),
                          ),
                          Divider(
                            color:settingsStore.isDarkTheme ? Color(0xff8787A8) : Color(0xffC9C9C9),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date',style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900

                            )),
                            Container(
                              child:Text('${transaction.date}')
                            )
                              ],
                            ),
                          ),
                           Divider(
                            color:settingsStore.isDarkTheme ? Color(0xff8787A8) : Color(0xffC9C9C9),
                          ),
                       Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Height',style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900 

                            )),
                            Column(
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child:Text('${transaction.height}')
                                ),
                                // Container(
                                //   child:Text('height 1 block',style:TextStyle(color:Colors.blue))
                                // )
                              ],
                            )
                              ],
                            ),
                          ),
                           Divider(
                            color:settingsStore.isDarkTheme ? Color(0xff8787A8) : Color(0xffC9C9C9),
                          ),
                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Amount',style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900

                            )),
                            Container(
                              child:Text('$formattedAmount',style: TextStyle(color:Color(0xff0BA70F)),)
                            )
                              ],
                            ),
                          ),
                          //  Divider(
                          //   color:settingsStore.isDarkTheme ? Color(0xff8787A8) : Color(0xffC9C9C9),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text('Recipient Address',style: TextStyle(
                          //     fontSize: 14,
                          //     fontFamily: 'Poppins',
                          //     fontWeight: FontWeight.w900

                          //   )),
                          //   Container(
                          //     child:Text('${transaction.recipientAddress}',style: TextStyle(color:Color(0xff0BA70F)),)
                          //   )
                          //     ],
                          //   ),
                          // ),
                        ],
                       
                     ),
                   ),
               ]







               ),
          ),
          
          
          // Column(
          //   children: [
          //     Row(children: <Widget>[
          //       Container(
          //         height: 27,
          //         width: 27,
          //        // margin: EdgeInsets.only(right:8.0),
          //         // Icon(
          //         //   direction == TransactionDirection.incoming
          //         //       ? Icons.arrow_downward_rounded
          //         //       : Icons.arrow_upward_rounded,
          //         //   color: direction == TransactionDirection.incoming
          //         //       ? Colors.green
          //         //       : Colors.red,
          //         // ),
          //         decoration: BoxDecoration(
          //          // color:Colors.yellow,
          //           //  direction == TransactionDirection.incoming
          //           //     ? Colors.transparent
          //           //     : Colors.transparent,
          //           shape: BoxShape.circle,
          //         ),
          //         child: SvgPicture.asset(
                    
          //           direction == TransactionDirection.incoming ?
          //           'assets/images/new-images/incoming.svg'
          //           :'assets/images/new-images/outgoing.svg',
          //            color: direction == TransactionDirection.incoming
          //               ? Colors.green
          //               : Colors.red,
          //               //fit:BoxFit.cover
          //           ),
          //       ),
          //       Expanded(
          //           child: Padding(
          //         padding: const EdgeInsets.only(left: 10, right: 10),
          //         child: Column(
          //           children: <Widget>[
          //             Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: <Widget>[
                            
          //                   Text(formattedAmount,
          //                       style: TextStyle(
          //                         fontWeight: FontWeight.w900,
          //                           fontSize: 14, color: settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
          //                           Text(
          //                       (direction == TransactionDirection.incoming
          //                               ? S.of(context).received
          //                               : S.of(context).sent) +
          //                           (isPending ? S.of(context).pending : // isStake ? S.of(context).stake :
          //                            ''),
          //                       style: TextStyle(
          //                           fontSize: 14,
          //                           color:settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
          //                 ]),
          //             SizedBox(height: 6),
          //             Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: <Widget>[
          //                   Text(formattedDate,
          //                       style: TextStyle(
          //                           fontSize: 13, color: settingsStore.isDarkTheme ? Color(0xffACACAC) : Color(0xff626262))),
          //                   // Text(formattedFiatAmount,
          //                   //     style: const TextStyle(
          //                   //         fontSize: 14, color: Palette.blueGrey))
          //                 ]),
          //           ],
          //         ),
          //       )),
          //       Icon(Icons.keyboard_arrow_down)
          //     ]),
          //   flag ? Container(
          //       height:200,
          //       child: Column(
          //         children: [
          //           Text('data'),
          //         ],
          //       ),
          //     )
          //     : SizedBox.shrink(),
          //   ],
          // ),
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
