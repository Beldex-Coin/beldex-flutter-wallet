

import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_state.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_store.dart';
import 'package:beldex_wallet/src/stores/subaddress_list/subaddress_list_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress_list.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class SubAddressAlert extends StatefulWidget {

final SubaddressListStore subaddressListStore;

  const SubAddressAlert({Key key, this.subaddressListStore}) : super(key: key);

  @override
  SubAddressAlertState createState() => SubAddressAlertState();
}

class SubAddressAlertState extends State<SubAddressAlert> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
 List<String> subAddressList =[];
 bool isLoading = false;
bool validateInput(String input) {
  if (input.trim().isEmpty || input.startsWith(' ')) {
    // Value consists only of spaces or contains a leading space
    return false;
  }
  // Other validation rules can be applied here
  return true;
}



 @override
   void initState() {
     getSubAddressList();
     super.initState();
   }



   void getSubAddressList(){
     
     setState(() {
             for(var i =0;i< widget.subaddressListStore.subaddresses.length;i++){
             subAddressList.add(widget.subaddressListStore.subaddresses[i].label);
     } 
          });
    
   }


bool checkSubAddressAlreadyExist(String label){
  return subAddressList.contains(label);
}







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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                     final regex = RegExp(r'^[a-zA-Z0-9]+$');
                     if(!(regex.hasMatch(value)) || !validateInput(value)){
                       return 'Enter a valid sub address';
                     }else if(checkSubAddressAlreadyExist(value)){
                      return 'Subaddress already exist';
                     }else {
                        subaddressCreationStore.validateSubaddressName(value);
                        return subaddressCreationStore.errorMessage;
                     }
                      }
              ),
              SizedBox(height: 10,),
              LoadingPrimaryButton(onPressed: ()async{
                 if (_formKey.currentState.validate()) {
                    setState(() {
                        isLoading = true;                  
                                        });
                    await subaddressCreationStore.add(label: _labelController.text);
                    setState(() {
                            isLoading = false;              
                                        });
                    Navigator.of(context).pop();
                  }
              }, text: 'Create', color: Color(0xff0BA70F), borderColor: Color(0xff0BA70F),
              isLoading: isLoading
              )
              // MaterialButton(onPressed: () async {
              //     if (_formKey.currentState.validate()) {
              //       await subaddressCreationStore.add(label: _labelController.text);
              //       Navigator.of(context).pop();
              //     }
              //   },
              //   elevation: 0,
              // color: Color(0xff0BA70F),
              // height: MediaQuery.of(context).size.height*0.20/3,
              // minWidth: double.infinity,
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              // child:(subaddressCreationStore.state is SubaddressIsCreating) ? CupertinoActivityIndicator(animating: true) : Text('Create',style: TextStyle(fontSize:17,color:Colors.white,fontWeight:FontWeight.w800),),
              // )
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