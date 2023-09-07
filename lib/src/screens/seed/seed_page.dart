import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
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



  final _copyKey = GlobalKey();
  final _continuekey= GlobalKey();
class SeedPage extends BasePage {
  SeedPage({this.onCloseCallback});

  // static final image = Image.asset('assets/images/seed_image.png');
  static final image =
      Image.asset('assets/images/avatar4.png', height: 124, width: 400);



  @override
  bool get isModalBackButton => true;

  @override
  String get title => S.current.recoverySeed;

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

// void setPageSecure()async{
//    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
// }

  @override
  Widget body(BuildContext context) {
  //  setPageSecure();
  //   final walletSeedStore = Provider.of<WalletSeedStore>(context);
  //   String _seed;
  //   String _isSeed;
  //  bool canCopy=false;
  //  bool issaved = false;
 final settingsStore = Provider.of<SettingsStore>(context);
    return SeedDisplayWidget(onCloseCallback: onCloseCallback, );
  }
}



class SeedDisplayWidget extends StatefulWidget {
   SeedDisplayWidget({ Key key,this.onCloseCallback }) : super(key: key);

   VoidCallback onCloseCallback;
   
  @override
  State<SeedDisplayWidget> createState() => _SeedDisplayWidgetState();
}

class _SeedDisplayWidgetState extends State<SeedDisplayWidget> {



  bool isCopied = false;

@override
  void initState() {
    super.initState();
  }

@override
  void dispose() {
    isCopied = false;
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
      final walletSeedStore = Provider.of<WalletSeedStore>(context);
    String _seed;
    String _isSeed;
   
 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
          child: Container(
            child: 
            Observer(builder: (_){
                _isSeed = walletSeedStore.seed;
           
           return Center(
              child: 
             _isSeed == '' || _isSeed == null ?
              Padding(
               padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*1/3),
               child: Container(
                child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                              text: 'Note : ',
                              style: TextStyle(  
                                color: Color(0xffFF3131),
                                 fontSize:15,
                                 fontWeight: FontWeight.w400
                              ),
                              children:[
                                TextSpan(text:S.of(context).youCantViewTheSeedBecauseYouveRestoredUsingKeys,style: TextStyle(
                                  fontSize:15,
                                  fontWeight: FontWeight.w400,
                                  color:settingsStore.isDarkTheme ? Color(0xffD9D9D9) : Color(0xff909090)))
                              ]
                            ),
                      
                            ),

               ),
             ) 
             
             : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height:MediaQuery.of(context).size.height*0.20/3),
                  Container(
                    child: Observer(builder: (_) {
                      _seed = walletSeedStore.seed;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,right:10.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                              text: 'Note : ',
                              style: TextStyle(  
                                color: Color(0xffFF3131),
                                 fontSize:15,
                                 fontWeight: FontWeight.w400
                              ),
                              children:[
                                TextSpan(text:S.of(context).neverShareYourSeedToAnyoneCheckYourSurroundingsTo,style: TextStyle(
                                  fontSize:15,
                                  fontWeight: FontWeight.w400,
                                  color:settingsStore.isDarkTheme ? Color(0xffD9D9D9) : Color(0xff909090)))
                              ]
                            ),
                      
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.10/3,
                          ),
                         Container(
                           child:Text(walletSeedStore.name, style: TextStyle(fontWeight:FontWeight.w800,fontSize:20,),maxLines: 1,overflow: TextOverflow.ellipsis,)
                         ),
                         SizedBox(height: 15,),
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.10/3,
                          ),
                         Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: widget.onCloseCallback != null
                           ? Row(
                            children: [
                              InkWell(
                                onTap: !isCopied ? (){
                                  setState(() {
                                         isCopied = true;                              
                                                                    });
                                  
                                   print(' copied value $isCopied');
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
                                }:null,
                                child: Container(
                                  height: 46,width:MediaQuery.of(context).size.height*0.60/3,
                                  decoration: BoxDecoration(   
                                    borderRadius: BorderRadius.circular(10),
                                    color:isCopied ? settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffE8E8E8)  : Color(0xff0BA70F)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [ 
                                      Text(S.of(context).copySeed,style:TextStyle(fontSize:16,fontWeight:FontWeight.bold,color: isCopied ? settingsStore.isDarkTheme ? Color(0xff6C6C78) : Color(0xffB2B2B6) : Colors.white,)),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Icon(Icons.copy,color:  isCopied ? settingsStore.isDarkTheme ? Color(0xff6C6C78) : Color(0xffB2B2B6) : Colors.white,),
                                      )
                                  ],),
                                ),
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                 onTap:() {
                                              Share.text(
                                                  S.of(context).seed_share,
                                                  _seed,
                                                  'text/plain');
                                            },
                                child: Container(
                                  height: 46,width:MediaQuery.of(context).size.height*0.40/3,
                                  decoration: BoxDecoration(   
                                    borderRadius: BorderRadius.circular(10),
                                    color:  Color(0xff2979FB) //(0xffE8E8E8)
                                  ),
                                  child:Center(
                                    child:Text(S.of(context).save,style:TextStyle(fontSize:16,fontWeight:FontWeight.bold,color: Colors.white))
                                  )
                                ),
                              )
                            ],
                           ):
                           Row(
                            children: [
                                 InkWell(
                                onTap: (){
                                  setState(() {
                                         isCopied = true;                              
                                                                    });
                                  
                                   print(' copied value $isCopied');
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
                                      Text('Copy seed',style:TextStyle(fontSize:16,fontWeight:FontWeight.bold,color: Colors.white,)),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Icon(Icons.copy,color: Colors.white,),
                                      )
                                  ],),
                                ),
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                 onTap:() {
                                              Share.text(
                                                  S.of(context).seed_share,
                                                  _seed,
                                                  'text/plain');
                                            },
                                child: Container(
                                  height: 46,width:MediaQuery.of(context).size.height*0.40/3,
                                  decoration: BoxDecoration(   
                                    borderRadius: BorderRadius.circular(10),
                                    color:  Color(0xff2979FB) //(0xffE8E8E8)
                                  ),
                                  child:Center(
                                    child:Text(S.of(context).save,style:TextStyle(fontSize:16,fontWeight:FontWeight.bold,color: Colors.white))
                                  )
                                ),
                              )
                            ],
                           ),
                         ),
                        ],
                      );
                    }),
                  ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.54/3,
                 ),
               
            widget.onCloseCallback != null && !isCopied ?  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Copy and save the seed to continue',style: TextStyle(fontSize:15),),
              ): Container(),



               widget.onCloseCallback != null
                      ? 
               
                 InkWell(
                        onTap: isCopied ? () {
                          widget.onCloseCallback != null ? widget.onCloseCallback() : Navigator.of(context).pop();
                        } : null,
                        child: Container(
                            width: MediaQuery.of(context).size.width*2.6/3, //290,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: isCopied ? 
                              Color(0xff0BA70F) : settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffE8E8E8) , //,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child:Text(S.of(context).continue_text,
                              style:TextStyle(
                              color: isCopied ?
                               Color(0xffffffff) 
                              :  settingsStore.isDarkTheme ? Color(0xff6C6C78) : Color(0xffB2B2B6) ,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                              
                              )
                              )
                            )
                            // PrimaryButton(
                            //     onPressed: () => onClose(context),
                            //     text: S.of(context).restore_next,
                            //     color: Theme.of(context)
                            //         .primaryTextTheme
                            //         .button
                            //         .backgroundColor,
                            //     borderColor: Palette.darkGrey),
                          ),
                      )
               
                  // onCloseCallback != null
                  //     ? 

                      
                     : InkWell(
                        onTap: () {
                         Navigator.of(context).pop();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width*2.6/3, //290,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: 
                              Color(0xff0BA70F)  , //,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child:Text(S.of(context).ok,
                              style:TextStyle(
                              color: 
                               Color(0xffffffff), 
                             
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                              
                              )
                              )
                            )
                            // PrimaryButton(
                            //     onPressed: () => onClose(context),
                            //     text: S.of(context).restore_next,
                            //     color: Theme.of(context)
                            //         .primaryTextTheme
                            //         .button
                            //         .backgroundColor,
                            //     borderColor: Palette.darkGrey),
                          ),
                      )
                ],
              ),
            );
   },)
          ),
        ),
      ],
    );
  }
}









































