

import 'dart:ui';

import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future showSimpleConfirmDialog(BuildContext context, String title, String body,String fee,String address,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => ConfirmSending(title, body,fee,address,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}





Future showSimpleSentTrans(BuildContext context, String title, String body,String fee,String address,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => SendTransactionSuccessfully(title, body,fee,address,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}






Future showSimpleSentTransDetails(BuildContext context, String title, String body,String fee,String address,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => SendTransactionSuccessfully(title, body,fee,address,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}



Future showDetailsAfterSendSuccessfully(BuildContext context, String title, String body,String fee,String address,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => SendDetailsAfterTransaction(title, body,fee,address,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}




class SendDetailsAfterTransaction extends StatelessWidget {
  const SendDetailsAfterTransaction(this.title, this.body, this.fee,this.address,
      {this.buttonText, this.onPressed, this.onDismiss,});// : super(key: key);

      final String title;
  final String body;
  final String fee;
  final String address;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  Widget build(BuildContext context) {
      final settingsStore = Provider.of<SettingsStore>(context);
   return  GestureDetector(
     // onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            margin: EdgeInsets.all(15),
           // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme ? Color(0xff272733) : Colors.white, //Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: MediaQuery.of(context).size.height*1.4/3,
                      padding: EdgeInsets.only(top: 15.0,left:20,right: 20),
                      child: Column(
                        children: [
                             Padding(
                               padding: const EdgeInsets.only(bottom:10.0),
                               child: Text(title,style:TextStyle(fontSize:18,fontWeight: FontWeight.w800)),
                             ),
                             Container(
                              height:50,
                              //padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffEDEDED)
                              ),
                              child:Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Amount',style: TextStyle(fontSize:16,fontWeight:FontWeight.w700),),
                                  ),
                                  VerticalDivider(

                                  ),
                                  Expanded(child: Container(
                                     padding: const EdgeInsets.all(10.0),
                                    child: Text('body',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontFamily: 'Poppinsbold'),),
                                  )),
                                  Container(
                                    width:70,
                                    padding: EdgeInsets.all(10),
                                    child: Container(  
                                      height:40,width:40,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(  
                                        color: Color(0xff00B116),
                                        shape: BoxShape.circle,
                                      ),
                                      child:SvgPicture.asset('assets/images/new-images/beldex.svg')
                                    ),
                                  )
                                ],
                              )
                             ),
                             Container(
                              margin:EdgeInsets.only(top:10),
                              padding: EdgeInsets.all(10),
                              height:MediaQuery.of(context).size.height*0.60/3,
                              decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffEDEDED),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Address'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(  
                                      color:settingsStore.isDarkTheme ? Color(0xff47475E): Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(address)),
                                    Text('Fee: fee'),

                                ],
                              )
                             ),
                             Container(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10/3),
                               child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height:45,width:120,
                                    decoration: BoxDecoration(
                                      color:settingsStore.isDarkTheme ? Color(0xff383848) :Color(0xffEDEDED),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                         if (onDismiss!= null) onDismiss(context);
                                      },
                                      child: Center(child:Text('Cancel',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800)))),
                                  ),
                                  SizedBox(width:20 ),
                                  Container(
                                    height:45,width:120,
                                    decoration: BoxDecoration(
                                      color:Color(0xff0BA70F),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: GestureDetector(
                                       onTap: (){
                                    if (onPressed != null) onPressed(context);
                                  },
                                      child: Center(child:Text('OK',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800,color: Colors.white),))),
                                  )
                               ],),
                             )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}































class TransactionSendDetails extends StatelessWidget {
  const TransactionSendDetails(this.title, this.body, this.fee,this.address,
      {this.buttonText, this.onPressed, this.onDismiss,});// : super(key: key);

      final String title;
  final String body;
  final String fee;
  final String address;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  Widget build(BuildContext context) {
      final settingsStore = Provider.of<SettingsStore>(context);
   return  GestureDetector(
     // onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            margin: EdgeInsets.all(15),
           // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme ? Color(0xff272733) : Colors.white, //Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: MediaQuery.of(context).size.height*1.4/3,
                      padding: EdgeInsets.only(top: 15.0,left:20,right: 20),
                      child: Column(
                        children: [
                             Padding(
                               padding: const EdgeInsets.only(bottom:10.0),
                               child: Text(title,style:TextStyle(fontSize:18,fontWeight: FontWeight.w800)),
                             ),
                             Container(
                              height:50,
                              //padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffEDEDED)
                              ),
                              child:Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Amount',style: TextStyle(fontSize:16,fontWeight:FontWeight.w700),),
                                  ),
                                  VerticalDivider(

                                  ),
                                  Expanded(child: Container(
                                     padding: const EdgeInsets.all(10.0),
                                    child: Text(body,style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontFamily: 'Poppinsbold'),),
                                  )),
                                  Container(
                                    width:70,
                                    padding: EdgeInsets.all(10),
                                    child: Container(  
                                      height:40,width:40,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(  
                                        color: Color(0xff00B116),
                                        shape: BoxShape.circle,
                                      ),
                                      child:SvgPicture.asset('assets/images/new-images/beldex.svg')
                                    ),
                                  )
                                ],
                              )
                             ),
                             Container(
                              margin:EdgeInsets.only(top:10),
                              padding: EdgeInsets.all(10),
                              height:MediaQuery.of(context).size.height*0.60/3,
                              decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffEDEDED),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Address'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(  
                                      color:settingsStore.isDarkTheme ? Color(0xff47475E): Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(address)),
                                    Text('Fee: $fee'),

                                ],
                              )
                             ),
                             Container(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10/3),
                               child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height:45,width:120,
                                    decoration: BoxDecoration(
                                      color:settingsStore.isDarkTheme ? Color(0xff383848) :Color(0xffEDEDED),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                         if (onDismiss!= null) onDismiss(context);
                                      },
                                      child: Center(child:Text('Cancel',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800)))),
                                  ),
                                  SizedBox(width:20 ),
                                  Container(
                                    height:45,width:120,
                                    decoration: BoxDecoration(
                                      color:Color(0xff0BA70F),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: GestureDetector(
                                       onTap: (){
                                    if (onPressed != null) onPressed(context);
                                  },
                                      child: Center(child:Text('OK',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800,color: Colors.white),))),
                                  )
                               ],),
                             )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}










class SendTransactionSuccessfully extends StatefulWidget {
  const SendTransactionSuccessfully(this.title, this.body, this.fee,this.address,
      {this.buttonText, this.onPressed, this.onDismiss,});// : super(key: key);

      final String title;
  final String body;
  final String fee;
  final String address;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  _SendTransactionSuccessfullyState createState() => _SendTransactionSuccessfullyState();
}

class _SendTransactionSuccessfullyState extends State<SendTransactionSuccessfully> {




@override
  void initState() {
    callFuture();
    super.initState();
  }

void callFuture()async{
  Future.delayed(Duration(seconds: 3),(){
     Navigator.of(context)..pop()..pop();
  });
}



  @override
  Widget build(BuildContext context) {
      final settingsStore = Provider.of<SettingsStore>(context);
      print('${widget.body}----------> amount');
   return  GestureDetector(
     // onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: 
 
         Container(
            margin: EdgeInsets.all(15),
           // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme ? Color(0xff272733) : Colors.white, //Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.80/3,
                      padding: EdgeInsets.only( //top: 15.0,
                      left:10,right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                               GestureDetector(
                                onTap: () {
                                    if (widget.onDismiss!= null) widget.onDismiss(context);
                                    // setState(() {
                                    //   canChangeWidget= true;                                        
                                    // });
                                    },
                                 child: Container(
                                 // color: Colors.yellow,
                                      //height: 14,width:15,
                                      child: Icon(Icons.close,size: 20,), 
                                     ),
                               )
                            ],
                          ),
                         
                            Container(
                              height:70,width:70,
                              decoration: BoxDecoration(
                               // color:Color(0xff0BA70F),
                                shape: BoxShape.circle,
                              ),child:Image.asset('assets/images/new-images/process_completed.gif') //Icon(Icons.check,color: Colors.white,size:30),
                            ),
                             Text('Transaction initiated successfully',style: TextStyle(fontSize:18,fontWeight:FontWeight.w900),)
                             
                            //  Container(
                            //   margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10/3),
                            //    child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Container(
                            //         height:45,width:120,
                            //         decoration: BoxDecoration(
                            //           color:settingsStore.isDarkTheme ? Color(0xff383848) :Color(0xffEDEDED),
                            //           borderRadius: BorderRadius.circular(8)
                            //         ),
                            //         child: GestureDetector(
                            //           onTap: (){
                            //              if (onDismiss!= null) onDismiss(context);
                            //           },
                            //           child: Center(child:Text('Cancel',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800)))),
                            //       ),
                            //       SizedBox(width:20 ),
                            //       Container(
                            //         height:45,width:120,
                            //         decoration: BoxDecoration(
                            //           color:Color(0xff0BA70F),
                            //           borderRadius: BorderRadius.circular(8)
                            //         ),
                            //         child: GestureDetector(
                            //            onTap: (){
                            //         if (onPressed != null) onPressed(context);
                            //       },
                            //           child: Center(child:Text('OK',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800,color: Colors.white),))),
                            //       )
                            //    ],),
                            //  )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String formatDateTime(){
   final  now = DateTime.now();
  final  formatter = DateFormat('MMM d, yyyy, hh:mm:ss a');
  final  formattedDate = formatter.format(now);
   return formattedDate;
  }
}






class ConfirmSending extends StatelessWidget {
  const ConfirmSending(this.title, this.body, this.fee,this.address,
      {this.buttonText, this.onPressed, this.onDismiss,});// : super(key: key);

      final String title;
  final String body;
  final String fee;
  final String address;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  Widget build(BuildContext context) {
      final settingsStore = Provider.of<SettingsStore>(context);
   return  GestureDetector(
     // onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            margin: EdgeInsets.all(15),
           // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme ? Color(0xff272733) : Colors.white, //Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: MediaQuery.of(context).size.height*1.4/3,
                      padding: EdgeInsets.only(top: 15.0,left:20,right: 20),
                      child: Column(
                        children: [
                             Padding(
                               padding: const EdgeInsets.only(bottom:10.0),
                               child: Text(title,style:TextStyle(fontSize:18,fontWeight: FontWeight.w800)),
                             ),
                             Container(
                              height:50,
                              //padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffEDEDED)
                              ),
                              child:Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Amount',style: TextStyle(fontSize:16,fontWeight:FontWeight.w700),),
                                  ),
                                  VerticalDivider(

                                  ),
                                  Expanded(child: Container(
                                     padding: const EdgeInsets.all(10.0),
                                    child: Text(body,style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontFamily: 'Poppinsbold'),),
                                  )),
                                  Container(
                                    width:70,
                                    padding: EdgeInsets.all(10),
                                    child: Container(  
                                      height:40,width:40,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(  
                                        color: Color(0xff00B116),
                                        shape: BoxShape.circle,
                                      ),
                                      child:SvgPicture.asset('assets/images/new-images/beldex.svg')
                                    ),
                                  )
                                ],
                              )
                             ),
                             Container(
                              margin:EdgeInsets.only(top:10),
                              padding: EdgeInsets.all(10),
                              height:MediaQuery.of(context).size.height*0.60/3,
                              decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffEDEDED),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Address'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(  
                                      color:settingsStore.isDarkTheme ? Color(0xff47475E): Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(address)),
                                    Text('Fee: $fee'),

                                ],
                              )
                             ),
                             Container(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10/3),
                               child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height:45,width:120,
                                    decoration: BoxDecoration(
                                      color:settingsStore.isDarkTheme ? Color(0xff383848) :Color(0xffEDEDED),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                         if (onDismiss!= null) onDismiss(context);
                                      },
                                      child: Center(child:Text('Cancel',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800)))),
                                  ),
                                  SizedBox(width:20 ),
                                  Container(
                                    height:45,width:120,
                                    decoration: BoxDecoration(
                                      color:Color(0xff0BA70F),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: GestureDetector(
                                       onTap: (){
                                    if (onPressed != null) onPressed(context);
                                  },
                                      child: Center(child:Text('OK',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800,color: Colors.white),))),
                                  )
                               ],),
                             )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// class TransactionSendDetails extends StatelessWidget {
//   const TransactionSendDetails({ Key key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return  GestureDetector(
//      // onTap: () => _onDismiss(context),
//       child: Container(
//         color: Colors.transparent,
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
//           child: Container(
//             margin: EdgeInsets.all(15),
//            // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         color: Colors.white, //Theme.of(context).backgroundColor,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height*1.4/3,
//                       padding: EdgeInsets.only(top: 15.0,left:20,right: 20),
//                       child: Column(
//                         children: [
//                              Padding(
//                                padding: const EdgeInsets.only(bottom:10.0),
//                                child: Text('title',style:TextStyle(fontSize:18,fontWeight: FontWeight.w800)),
//                              ),
//                              Container(
//                               height:50,
//                               //padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color:Color(0xffEDEDED)
//                               ),
//                               child:Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Text('Amount',style: TextStyle(fontSize:16,fontWeight:FontWeight.w700),),
//                                   ),
//                                   VerticalDivider(

//                                   ),
//                                   Expanded(child: Container(
//                                      padding: const EdgeInsets.all(10.0),
//                                     child: Text('body',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontFamily: 'Poppinsbold'),),
//                                   )),
//                                   Container(
//                                     width:70,
//                                     padding: EdgeInsets.all(10),
//                                     child: Container(  
//                                       height:40,width:40,
//                                       padding: EdgeInsets.all(6),
//                                       decoration: BoxDecoration(  
//                                         color: Color(0xff00B116),
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child:SvgPicture.asset('assets/images/new-images/beldex.svg')
//                                     ),
//                                   )
//                                 ],
//                               )
//                              ),
//                              Container(
//                               margin:EdgeInsets.only(top:10),
//                               padding: EdgeInsets.all(10),
//                               height:MediaQuery.of(context).size.height*0.60/3,
//                               decoration: BoxDecoration(
//                                 color: Color(0xffEDEDED),
//                                 borderRadius: BorderRadius.circular(10)
//                               ),
//                               child:Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text('Address'),
//                                   Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(  
//                                       color:Colors.white,
//                                       borderRadius: BorderRadius.circular(10)
//                                     ),
//                                     child: Text('hacjsjbyafckjdblknbksjsjhvsjkbskbskbdlsdknscmbxjcbjkblklsknslklsjbjs')),
//                                     Text('Fee: fee'),

//                                 ],
//                               )
//                              ),
//                              Container(
//                               margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10/3),
//                                child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     height:45,width:120,
//                                     decoration: BoxDecoration(
//                                       color:Color(0xffEDEDED),
//                                       borderRadius: BorderRadius.circular(8)
//                                     ),
//                                     child: Center(child:Text('Cancel',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800))),
//                                   ),
//                                   SizedBox(width:20 ),
//                                   Container(
//                                     height:45,width:120,
//                                     decoration: BoxDecoration(
//                                       color:Color(0xff0BA70F),
//                                       borderRadius: BorderRadius.circular(8)
//                                     ),
//                                     child: GestureDetector(
//                                   //      onTap: (){
//                                   //   if (onPressed != null) onPressed(context);
//                                   // },
//                                       child: Center(child:Text('OK',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800,color: Colors.white),))),
//                                   )
//                                ],),
//                              )
//                         ],
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }