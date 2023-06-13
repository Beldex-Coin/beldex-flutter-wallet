

import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_state.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class SubAddressAlert extends StatefulWidget {
  @override
  SubAddressAlertState createState() => SubAddressAlertState();
}

class SubAddressAlertState extends State<SubAddressAlert> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final walletService = Provider.of<WalletService>(context);
    final settingsStore = Provider.of<SettingsStore>(context);


//  reaction((_) => subaddressCreationStore.state,
//         (SubaddressCreationState state) {
//       if (state is SubaddressCreatedSuccessfully) {
//         WidgetsBinding.instance
//             .addPostFrameCallback((_) => Navigator.of(context).pop());
//       }
//     });




    return 
    Provider(create: (_) =>
                    SubadrressCreationStore(walletService: walletService),
                    
      builder:(context,child){
        final subaddressCreationStore =
        Provider.of<SubadrressCreationStore>(context,listen: false);
        return  AlertDialog(
        //contentPadding: EdgeInsets.all(12),
       // insetPadding: EdgeInsets.symmetric(horizontal: 5),
        backgroundColor:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('Sub Address',style: TextStyle(fontWeight:FontWeight.w800))),
        content: Form(
          key: _formKey,
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _labelController,
               decoration: InputDecoration(
                hintText: 'Label name',
                hintStyle: TextStyle(
                  color:Color(0xff77778B)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                 border: OutlineInputBorder(
                  
                  borderRadius:BorderRadius.circular(8),
                 
                 ),
            
               ),
                  validator: (value) {
                        subaddressCreationStore.validateSubaddressName(value);
                        return subaddressCreationStore.errorMessage;
                      }
              ),
              SizedBox(height: 10,),
              MaterialButton(onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await subaddressCreationStore.add(label: _labelController.text);
                    Navigator.of(context).pop();
                  }
                },
                elevation: 0,
              color: Color(0xff0BA70F),
              height: MediaQuery.of(context).size.height*0.20/3,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              child:(subaddressCreationStore.state is SubaddressIsCreating) ? CupertinoActivityIndicator(animating: true) : Text('Create',style: TextStyle(fontSize:17,color:Colors.white,fontWeight:FontWeight.w800),),
              )
            //  Container(
            //   alignment: Alignment.center,
            //   padding: EdgeInsets.all(15),

            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //      color: Color(0xff0BA70F),
            //      borderRadius: BorderRadius.circular(10),
            //   ),
               
            //      child:Text('Add')
            //  ),
            ],
          ),
        ),
         
      );
      } 
     
    );
  }

}