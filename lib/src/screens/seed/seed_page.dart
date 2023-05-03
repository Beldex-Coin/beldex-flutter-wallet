import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:provider/provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/stores/wallet_seed/wallet_seed_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';

class SeedPage extends BasePage {
  SeedPage({this.onCloseCallback});

  // static final image = Image.asset('assets/images/seed_image.png');
  static final image =
      Image.asset('assets/images/avatar4.png', height: 124, width: 400);

  @override
  bool get isModalBackButton => true;

  @override
  String get title => S.current.seed_title;

  final VoidCallback onCloseCallback;

  @override
  void onClose(BuildContext context) =>
      onCloseCallback != null ? onCloseCallback() : Navigator.of(context).pop();

  @override
  Widget leading(BuildContext context) {
    return onCloseCallback != null ? Offstage() : super.leading(context);
  }



 @override
 Widget trailing(BuildContext context){
  return Container();
 }


  @override
  Widget body(BuildContext context) {
    final walletSeedStore = Provider.of<WalletSeedStore>(context);
    String _seed;
 final settingsStore = Provider.of<SettingsStore>(context);
    return 
    
    
    
    
    
    
    
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
               /* Image.asset(
                  'assets/images/avatar4.png',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),*/ //image,
                SizedBox(height:MediaQuery.of(context).size.height*0.40/3),
                Container(
                  //margin: EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0,bottom: 90.0),
                  child: Observer(builder: (_) {
                    _seed = walletSeedStore.seed;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Row(
                        //   children: <Widget>[
                        //     Expanded(
                        //         child: Container(
                        //       padding: EdgeInsets.only(bottom: 10.0),
                        //       margin: EdgeInsets.only(bottom: 10.0),
                        //       child: Text(
                        //         walletSeedStore.name ?? '',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //             fontSize: 18.0,
                        //             fontWeight: FontWeight.bold,
                        //             color: Theme.of(context).primaryTextTheme.caption.color,//Theme.of(context).primaryTextTheme.button.color
                        //         ),
                        //       ),
                        //     ))
                        //   ],
                        // ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                          text: 'Note : ',
                          style: TextStyle(  
                            color: Color(0xffFF3131),
                            fontFamily: 'Poppins',
                             fontSize:14,
                             fontWeight: FontWeight.w800
                          ),
                          children:[
                            TextSpan(text:'Never share your seed to anyone! Check your surroundings to ensure no one is overlooking',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize:14,
                              fontWeight: FontWeight.w800,
                              color:settingsStore.isDarkTheme ? Color(0xff909090): Color(0xffD9D9D9)))
                          ]
                        ),
                    
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.10/3,
                        ),
                       
                       Container(
                        height:MediaQuery.of(context).size.height*0.50/3,
                       padding:EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child:Text(walletSeedStore.seed,textAlign: TextAlign.center,style:TextStyle(
                          fontSize:15, color:settingsStore.isDarkTheme ? Color(0xffE2E2E2): Color(0xff373737)))
                       ),
                       //SizedBox(height:15),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.10/3,
                        ),
                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                 Clipboard.setData(
                                                ClipboardData(text: _seed));
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
                                                                milliseconds: 1500),));
                              },
                              child: Container(
                                height: 46,width:MediaQuery.of(context).size.height*0.60/3,
                                decoration: BoxDecoration(   
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff0BA70F)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [ 
                                    Text('Copy seed',style:TextStyle(fontSize:16,fontWeight:FontWeight.w800,color:Colors.white)),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Icon(Icons.copy,color: Colors.white,),
                                    )
                                ],),
                              ),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                               onTap: () {
                                            Share.text(
                                                S.of(context).seed_share,
                                                _seed,
                                                'text/plain');
                                          },
                              child: Container(
                                height: 46,width:MediaQuery.of(context).size.height*0.40/3,
                                decoration: BoxDecoration(   
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff2979FB)
                                ),
                                child:Center(
                                  child:Text(S.of(context).save,style:TextStyle(fontSize:16,fontWeight:FontWeight.w800,color:Colors.white))
                                )
                              ),
                            )
                          ],
                         ),
                       ),
                       
                       
                       
                        // Card(
                        //   color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                        //   elevation: 3,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         top: 35.0,
                        //         bottom: 35.0,
                        //         left: 25.0,
                        //         right: 25.0),
                        //     child: Column(
                        //       children: [
                        //         Text(
                        //           walletSeedStore.seed,
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //               fontSize: 14.0,
                        //               color: Theme.of(context)
                        //                   .primaryTextTheme
                        //                   .headline6
                        //                   .color),
                        //         ),
                        //         Container(
                        //           margin: EdgeInsets.only(top: 30.0),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: <Widget>[
                        //               Flexible(
                        //                 child: GestureDetector(
                        //                   onTap: () {
                        //                     Share.text(
                        //                         S.of(context).seed_share,
                        //                         _seed,
                        //                         'text/plain');
                        //                   },
                        //                   child: Container(
                        //                     width: 95,
                        //                     height: 43,
                        //                     decoration: BoxDecoration(
                        //                       gradient: LinearGradient(
                        //                         colors: [
                        //                           Theme.of(context).accentIconTheme.color,//Colors.black,
                        //                           Theme.of(context).primaryTextTheme.subtitle2.backgroundColor,// Colors.grey[900],
                        //                         ],
                        //                         begin: Alignment.topLeft,
                        //                         end: Alignment.bottomRight,
                        //                       ),
                        //                       borderRadius:
                        //                           BorderRadius.circular(10),
                        //                       boxShadow: [
                        //                         BoxShadow(
                        //                           color: Colors.black38,
                        //                           offset: Offset(5, 5),
                        //                           blurRadius: 5,
                        //                         )
                        //                       ],
                        //                     ),
                        //                     child: Center(
                        //                       child: Text(
                        //                         S.of(context).save,
                        //                         style: TextStyle(
                        //                           color:Colors.yellow,
                        //                           //  Theme.of(context)
                        //                           //     .accentTextTheme
                        //                           //     .caption
                        //                           //     .decorationColor,
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ), /*Container(
                        //                 decoration: BoxDecoration(
                        //                   */ /*boxShadow: [
                        //                     BoxShadow(
                        //                       color: Colors.black12,
                        //                       offset: Offset(5, 5),
                        //                       blurRadius: 10,
                        //                     )
                        //                   ],*/ /*
                        //                   borderRadius: BorderRadius.circular(10),
                        //                   gradient: LinearGradient(
                        //                     colors: [
                        //                       Colors.black45,
                        //                       Colors.black38,
                        //                     ],
                        //                     begin: Alignment.topLeft,
                        //                     end: Alignment.bottomRight,
                        //                   ),
                        //                 ),
                        //                 padding: EdgeInsets.only(right: 8.0),
                        //                 child: PrimaryButton(
                        //                     onPressed: () => Share.text(
                        //                         S.of(context).seed_share,
                        //                         _seed,
                        //                         'text/plain'),
                        //                     color: Colors
                        //                         .transparent */ /*Theme.of(context)
                        //                             .primaryTextTheme
                        //                             .button
                        //                             .backgroundColor*/ /*
                        //                     ,
                        //                     borderColor: Colors
                        //                         .transparent */ /*Theme.of(context)
                        //                             .primaryTextTheme
                        //                             .button
                        //                             .decorationColor*/ /*
                        //                     ,
                        //                     text: S.of(context).save),
                        //               )*/
                        //               ),
                        //               Flexible(
                        //                 child: GestureDetector(
                        //                   onTap: () {
                        //                     Clipboard.setData(
                        //                         ClipboardData(text: _seed));
                        //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //                       elevation: 5,
                        //                       shape: RoundedRectangleBorder(
                        //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                        //                       ),
                        //                       content: Text(S
                        //                           .of(context)
                        //                           .copied_to_clipboard,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                        //                       backgroundColor: Color.fromARGB(255, 46, 113, 43),
                        //                       duration: Duration(
                        //                           milliseconds: 1500),
                        //                     ),);
                        //                     /*Scaffold.of(context).showSnackBar(
                        //                       SnackBar(
                        //                         content: Text(S
                        //                             .of(context)
                        //                             .copied_to_clipboard),
                        //                         backgroundColor: Colors.green,
                        //                         duration: Duration(
                        //                             milliseconds: 1500),
                        //                       ),
                        //                     );*/
                        //                   },
                        //                   child: Container(
                        //                     width: 95,
                        //                     height: 43,
                        //                     decoration: BoxDecoration(
                        //                       gradient: LinearGradient(
                        //                         colors: [
                        //                           Theme.of(context).accentIconTheme.color,//Colors.black,
                        //                           Theme.of(context).primaryTextTheme.subtitle2.backgroundColor,//Colors.grey[900],
                        //                         ],
                        //                         begin: Alignment.topLeft,
                        //                         end: Alignment.bottomRight,
                        //                       ),
                        //                       borderRadius:
                        //                           BorderRadius.circular(10),
                        //                       boxShadow: [
                        //                         BoxShadow(
                        //                           color: Colors.black38,
                        //                           offset: Offset(5, 5),
                        //                           blurRadius: 5,
                        //                         )
                        //                       ],
                        //                     ),
                        //                     child: Center(
                        //                       child: Text(
                        //                         S.of(context).copy,
                        //                         style: TextStyle(
                        //                           color: Theme.of(context)
                        //                               .primaryTextTheme
                        //                               .button
                        //                               .backgroundColor,
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ), /*Container(
                        //                       padding:
                        //                           EdgeInsets.only(left: 8.0),
                        //                       child: Builder(
                        //                         builder: (context) =>
                        //                             PrimaryButton(
                        //                                 onPressed: () {
                        //                                   Clipboard.setData(
                        //                                       ClipboardData(
                        //                                           text:
                        //                                               _seed));
                        //                                   Scaffold.of(context)
                        //                                       .showSnackBar(
                        //                                     SnackBar(
                        //                                       content: Text(S
                        //                                           .of(context)
                        //                                           .copied_to_clipboard),
                        //                                       backgroundColor:
                        //                                           Colors
                        //                                               .green,
                        //                                       duration: Duration(
                        //                                           milliseconds:
                        //                                               1500),
                        //                                     ),
                        //                                   );
                        //                                 },
                        //                                 text: S
                        //                                     .of(context)
                        //                                     .copy,
                        //                                 color: Theme.of(
                        //                                         context)
                        //                                     .accentTextTheme
                        //                                     .caption
                        //                                     .backgroundColor,
                        //                                 borderColor: Theme.of(
                        //                                         context)
                        //                                     .accentTextTheme
                        //                                     .caption
                        //                                     .decorationColor),
                        //                       ))*/
                        //               )
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  }),
                ),
                /*Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          child: Container(
                        padding: EdgeInsets.only(right: 8.0),
                        child: PrimaryButton(
                            onPressed: () => Share.text(
                                S.of(context).seed_share,
                                _seed,
                                'text/plain'),
                            color: Theme.of(context)
                                .primaryTextTheme
                                .button
                                .backgroundColor,
                            borderColor: Theme.of(context)
                                .primaryTextTheme
                                .button
                                .decorationColor,
                            text: S.of(context).save),
                      )),
                      Flexible(
                          child: Container(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Builder(
                                builder: (context) => PrimaryButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: _seed));
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .copied_to_clipboard),
                                          backgroundColor: Colors.green,
                                          duration:
                                              Duration(milliseconds: 1500),
                                        ),
                                      );
                                    },
                                    text: S.of(context).copy,
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .caption
                                        .backgroundColor,
                                    borderColor: Theme.of(context)
                                        .accentTextTheme
                                        .caption
                                        .decorationColor),
                              )))
                    ],
                  ),
                )*/



                // onCloseCallback != null
                //     ? SizedBox(
                //         width: 250,
                //         child: PrimaryButton(
                //             onPressed: () => onClose(context),
                //             text: S.of(context).restore_next,
                //             color: Theme.of(context)
                //                 .primaryTextTheme
                //                 .button
                //                 .backgroundColor,
                //             borderColor: Palette.darkGrey),
                //       )
                //     : Offstage()
              ],
            ),
          ),
        ),
      ],
    );
  }
}













































// import 'package:provider/provider.dart';
// import 'package:esys_flutter_share/esys_flutter_share.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:beldex_wallet/palette.dart';
// import 'package:beldex_wallet/generated/l10n.dart';
// import 'package:beldex_wallet/src/widgets/primary_button.dart';
// import 'package:beldex_wallet/src/stores/wallet_seed/wallet_seed_store.dart';
// import 'package:beldex_wallet/src/screens/base_page.dart';

// class SeedPage extends BasePage {
//   SeedPage({this.onCloseCallback});

//   // static final image = Image.asset('assets/images/seed_image.png');
//   static final image =
//       Image.asset('assets/images/avatar4.png', height: 124, width: 400);

//   @override
//   bool get isModalBackButton => true;

//   @override
//   String get title => S.current.seed_title;

//   final VoidCallback onCloseCallback;

//   @override
//   void onClose(BuildContext context) =>
//       onCloseCallback != null ? onCloseCallback() : Navigator.of(context).pop();

//   @override
//   Widget leading(BuildContext context) {
//     return onCloseCallback != null ? Offstage() : super.leading(context);
//   }



//  @override
//  Widget trailing(BuildContext context){
//   return Container();
//  }


//   @override
//   Widget body(BuildContext context) {
//     final walletSeedStore = Provider.of<WalletSeedStore>(context);
//     String _seed;

//     return Container(
//       padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
//       child: Column(
//         children: <Widget>[
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                  /* Image.asset(
//                     'assets/images/avatar4.png',
//                     height: 70,
//                     width: 70,
//                     fit: BoxFit.cover,
//                   ),*/ //image,
//                   Container(
//                     margin: EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0,bottom: 90.0),
//                     child: Observer(builder: (_) {
//                       _seed = walletSeedStore.seed;
//                       return Column(
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Expanded(
//                                   child: Container(
//                                 padding: EdgeInsets.only(bottom: 10.0),
//                                 margin: EdgeInsets.only(bottom: 10.0),
//                                 child: Text(
//                                   walletSeedStore.name ?? '',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontSize: 18.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: Theme.of(context).primaryTextTheme.caption.color,//Theme.of(context).primaryTextTheme.button.color
//                                   ),
//                                 ),
//                               ))
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Card(
//                             color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
//                             elevation: 3,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 35.0,
//                                   bottom: 35.0,
//                                   left: 25.0,
//                                   right: 25.0),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     walletSeedStore.seed,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontSize: 14.0,
//                                         color: Theme.of(context)
//                                             .primaryTextTheme
//                                             .headline6
//                                             .color),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(top: 30.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Flexible(
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               Share.text(
//                                                   S.of(context).seed_share,
//                                                   _seed,
//                                                   'text/plain');
//                                             },
//                                             child: Container(
//                                               width: 95,
//                                               height: 43,
//                                               decoration: BoxDecoration(
//                                                 gradient: LinearGradient(
//                                                   colors: [
//                                                     Theme.of(context).accentIconTheme.color,//Colors.black,
//                                                     Theme.of(context).primaryTextTheme.subtitle2.backgroundColor,// Colors.grey[900],
//                                                   ],
//                                                   begin: Alignment.topLeft,
//                                                   end: Alignment.bottomRight,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black38,
//                                                     offset: Offset(5, 5),
//                                                     blurRadius: 5,
//                                                   )
//                                                 ],
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   S.of(context).save,
//                                                   style: TextStyle(
//                                                     color:Colors.yellow,
//                                                     //  Theme.of(context)
//                                                     //     .accentTextTheme
//                                                     //     .caption
//                                                     //     .decorationColor,
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ), /*Container(
//                                           decoration: BoxDecoration(
//                                             */ /*boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black12,
//                                                 offset: Offset(5, 5),
//                                                 blurRadius: 10,
//                                               )
//                                             ],*/ /*
//                                             borderRadius: BorderRadius.circular(10),
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 Colors.black45,
//                                                 Colors.black38,
//                                               ],
//                                               begin: Alignment.topLeft,
//                                               end: Alignment.bottomRight,
//                                             ),
//                                           ),
//                                           padding: EdgeInsets.only(right: 8.0),
//                                           child: PrimaryButton(
//                                               onPressed: () => Share.text(
//                                                   S.of(context).seed_share,
//                                                   _seed,
//                                                   'text/plain'),
//                                               color: Colors
//                                                   .transparent */ /*Theme.of(context)
//                                                       .primaryTextTheme
//                                                       .button
//                                                       .backgroundColor*/ /*
//                                               ,
//                                               borderColor: Colors
//                                                   .transparent */ /*Theme.of(context)
//                                                       .primaryTextTheme
//                                                       .button
//                                                       .decorationColor*/ /*
//                                               ,
//                                               text: S.of(context).save),
//                                         )*/
//                                         ),
//                                         Flexible(
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               Clipboard.setData(
//                                                   ClipboardData(text: _seed));
//                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                                 elevation: 5,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
//                                                 ),
//                                                 content: Text(S
//                                                     .of(context)
//                                                     .copied_to_clipboard,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
//                                                 backgroundColor: Color.fromARGB(255, 46, 113, 43),
//                                                 duration: Duration(
//                                                     milliseconds: 1500),
//                                               ),);
//                                               /*Scaffold.of(context).showSnackBar(
//                                                 SnackBar(
//                                                   content: Text(S
//                                                       .of(context)
//                                                       .copied_to_clipboard),
//                                                   backgroundColor: Colors.green,
//                                                   duration: Duration(
//                                                       milliseconds: 1500),
//                                                 ),
//                                               );*/
//                                             },
//                                             child: Container(
//                                               width: 95,
//                                               height: 43,
//                                               decoration: BoxDecoration(
//                                                 gradient: LinearGradient(
//                                                   colors: [
//                                                     Theme.of(context).accentIconTheme.color,//Colors.black,
//                                                     Theme.of(context).primaryTextTheme.subtitle2.backgroundColor,//Colors.grey[900],
//                                                   ],
//                                                   begin: Alignment.topLeft,
//                                                   end: Alignment.bottomRight,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black38,
//                                                     offset: Offset(5, 5),
//                                                     blurRadius: 5,
//                                                   )
//                                                 ],
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   S.of(context).copy,
//                                                   style: TextStyle(
//                                                     color: Theme.of(context)
//                                                         .primaryTextTheme
//                                                         .button
//                                                         .backgroundColor,
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ), /*Container(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8.0),
//                                                 child: Builder(
//                                                   builder: (context) =>
//                                                       PrimaryButton(
//                                                           onPressed: () {
//                                                             Clipboard.setData(
//                                                                 ClipboardData(
//                                                                     text:
//                                                                         _seed));
//                                                             Scaffold.of(context)
//                                                                 .showSnackBar(
//                                                               SnackBar(
//                                                                 content: Text(S
//                                                                     .of(context)
//                                                                     .copied_to_clipboard),
//                                                                 backgroundColor:
//                                                                     Colors
//                                                                         .green,
//                                                                 duration: Duration(
//                                                                     milliseconds:
//                                                                         1500),
//                                                               ),
//                                                             );
//                                                           },
//                                                           text: S
//                                                               .of(context)
//                                                               .copy,
//                                                           color: Theme.of(
//                                                                   context)
//                                                               .accentTextTheme
//                                                               .caption
//                                                               .backgroundColor,
//                                                           borderColor: Theme.of(
//                                                                   context)
//                                                               .accentTextTheme
//                                                               .caption
//                                                               .decorationColor),
//                                                 ))*/
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                   /*Container(
//                     margin: EdgeInsets.only(top: 30.0),
//                     child: Row(
//                       children: <Widget>[
//                         Flexible(
//                             child: Container(
//                           padding: EdgeInsets.only(right: 8.0),
//                           child: PrimaryButton(
//                               onPressed: () => Share.text(
//                                   S.of(context).seed_share,
//                                   _seed,
//                                   'text/plain'),
//                               color: Theme.of(context)
//                                   .primaryTextTheme
//                                   .button
//                                   .backgroundColor,
//                               borderColor: Theme.of(context)
//                                   .primaryTextTheme
//                                   .button
//                                   .decorationColor,
//                               text: S.of(context).save),
//                         )),
//                         Flexible(
//                             child: Container(
//                                 padding: EdgeInsets.only(left: 8.0),
//                                 child: Builder(
//                                   builder: (context) => PrimaryButton(
//                                       onPressed: () {
//                                         Clipboard.setData(
//                                             ClipboardData(text: _seed));
//                                         Scaffold.of(context).showSnackBar(
//                                           SnackBar(
//                                             content: Text(S
//                                                 .of(context)
//                                                 .copied_to_clipboard),
//                                             backgroundColor: Colors.green,
//                                             duration:
//                                                 Duration(milliseconds: 1500),
//                                           ),
//                                         );
//                                       },
//                                       text: S.of(context).copy,
//                                       color: Theme.of(context)
//                                           .accentTextTheme
//                                           .caption
//                                           .backgroundColor,
//                                       borderColor: Theme.of(context)
//                                           .accentTextTheme
//                                           .caption
//                                           .decorationColor),
//                                 )))
//                       ],
//                     ),
//                   )*/
//                   onCloseCallback != null
//                       ? SizedBox(
//                           width: 250,
//                           child: PrimaryButton(
//                               onPressed: () => onClose(context),
//                               text: S.of(context).restore_next,
//                               color: Theme.of(context)
//                                   .primaryTextTheme
//                                   .button
//                                   .backgroundColor,
//                               borderColor: Palette.darkGrey),
//                         )
//                       : Offstage()
//                 ],
//               ),
//             ),
//           ),
//           /*onCloseCallback != null
//               ? PrimaryButton(
//                   onPressed: () => onClose(context),
//                   text: S.of(context).restore_next,
//                   color: Palette.darkGrey,
//                   borderColor: Palette.darkGrey)
//               : Offstage()*/
//         ],
//       ),
//     );
//   }
// }
