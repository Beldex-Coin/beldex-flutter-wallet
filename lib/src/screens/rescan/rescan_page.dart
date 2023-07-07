import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/blockchain_height_widget.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/stores/rescan/rescan_wallet_store.dart';
import 'package:beldex_wallet/generated/l10n.dart';

class RescanPage extends BasePage {
  final blockchainKey = GlobalKey<BlockchainHeightState>();
  @override
  String get title => '${S.current.rescan} wallet';
 
 @override
 Widget trailing(BuildContext context){
  return Container();
 }

  final dateController = TextEditingController();
  final restoreHeightController = TextEditingController();
  int get height => _height;
  int _height = 0;
  bool isRestoreByHeight = true;




  @override
  Widget body(BuildContext context) {
    final rescanWalletStore = Provider.of<RescanWalletStore>(context);

    return ScrollableWithBottomSection(
      content: 
      // Padding(
      //   padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      //   child:
            Column(mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*0.60/3),
          Center(child:BlockchainHeightWidget(key: blockchainKey)
          ),
          
        ]),
      //),
      bottomSection: Observer(
              builder: (_) => LoadingPrimaryButton(
                  isLoading:
                      rescanWalletStore.state == RescanWalletState.rescaning,
                  text: S.of(context).rescan,
                  onPressed: () async {
                   
                    await rescanWalletStore.rescanCurrentWallet(
                        restoreHeight: blockchainKey.currentState.height);
                    Navigator.of(context).pop();
                  },
                  color:
                      Theme.of(context).primaryTextTheme.button.backgroundColor,
                  borderColor:
                      Theme.of(context).primaryTextTheme.button.backgroundColor
                  )
                  ),
    );
  }

// Widget restoreWidgets(BuildContext context){
//    final settingsStore = Provider.of<SettingsStore>(context);
//   return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
      
//       isRestoreByHeight ?  Row(
//           children: <Widget>[
//             Flexible(
//                 child: Card(
//                   elevation:0, //5,
//                   color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   margin: EdgeInsets.only(top: 20.0),
//                   child: Container(
//                     padding: EdgeInsets.only(left: 30,top:5,bottom: 5),
//               child: TextFormField(
//                   style: TextStyle(fontSize: 14.0),
//                   controller: restoreHeightController,
//                   keyboardType: TextInputType.numberWithOptions(
//                       signed: false, decimal: false),
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                       hintStyle: TextStyle(color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)),
//                       hintText: S.of(context).widgets_restore_from_blockheight,
//                       /*focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: BeldexPalette.teal, width: 2.0)),
//                       enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Theme.of(context).focusColor, width: 1.0))*/),
//               ),
//             ),
//                 ))
//           ],
//         ):
//         // Padding(
//         //   padding: EdgeInsets.only(top: 25,bottom: 5),
//         //   child: Center(
//         //     child: Text(
//         //       S.of(context).widgets_or,
//         //       textAlign: TextAlign.center,
//         //       style: TextStyle(
//         //           fontSize: 16.0,
//         //           fontWeight: FontWeight.normal,
//         //           color: Theme.of(context).primaryTextTheme.headline6.color),
//         //     ),
//         //   ),
//         // ),
//         Row(
//           children: <Widget>[
//             Flexible(
//                 child: Card(
//                   elevation:0, //5,
//                   color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   margin: EdgeInsets.only(top: 20.0),
//                   child: Container(
//                     padding: EdgeInsets.only(left: 30,top:5,bottom:5,right:10),
//               child: InkWell(
//                   onTap: (){}, //_selectDate(context),
//                   child: IgnorePointer(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 130,
//                           child: TextFormField(
                            
//                             style: TextStyle(fontSize: 14.0),
//                             decoration: InputDecoration(
//                               //suffix:Icon(Icons.calendar_today,), //SvgPicture.asset('assets/images/new-images/calendar.svg',color:Colors.black),
//                               border: InputBorder.none,
//                                 hintStyle:
//                                     TextStyle(color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)),
//                                 hintText: S.of(context).widgets_restore_from_date,
//                                 /*focusedBorder: UnderlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: BeldexPalette.teal,
//                                         width: 2.0)),
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: Theme.of(context).focusColor,
//                                         width: 1.0))*/),
                            
//                             controller: dateController,
//                             validator: (value) {
//                               return null;
//                             },
//                           ),
//                         ),
//                         Icon(Icons.calendar_today,color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xffB5B5C1))
//                       ],
//                     ),
//                   ),
//               ),
//             ),
//                 ))
//           ],
//         ),

//       Center(
//         child: Observer(builder: (_){
//           return InkWell(
//             onTap: (){
//               // setState(() {
//                       isRestoreByHeight = isRestoreByHeight ? false:true;
//                         //  });
//             },
//             child: Container(
//               height:50,width: isRestoreByHeight ? 160: 220,
//               margin: EdgeInsets.only(top:20),
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color:Color(0xff2979FB),
//                 borderRadius: BorderRadius.circular(10)
//               ),
//               child:Row(
//                 children: [
//                   Text(isRestoreByHeight ? S.of(context).widgets_restore_from_date : S.of(context).widgets_restore_from_blockheight,style:TextStyle( color:Color(0xffffffff),fontSize:14,fontWeight:FontWeight.w700)),
//                   Icon(Icons.arrow_right_alt_rounded,color: Color(0xffffffff),)
//                 ],
//               )
//             ),
//           );
//         })
//       )







//       ],
//     );
// }

// Future _selectDate(BuildContext context) async {
//     final now = DateTime.now();
//     final date = await showDatePicker(
//         context: context,
//         initialDate: now.subtract(Duration(days: 1)),
//         firstDate: DateTime(2014, DateTime.april),
//         lastDate: now);

//     if (date != null) {
//       setState(() {
              
//             });
//       final height = getHeightByDate(date: date);

//       setState(() {
//         dateController.text = DateFormat('yyyy-MM-dd').format(date);
//         restoreHeightController.text = '$height';
//         _height = height;
//       });
//     }
//   }



}
