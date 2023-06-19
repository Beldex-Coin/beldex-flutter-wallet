

import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/account_list/account_list_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountDialog extends StatefulWidget {
  
  
   CreateAccountDialog({ Key key, this.account }) : super(key: key);
   final Account account;
  @override
  State<CreateAccountDialog> createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog> {

final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

@override
  void initState() {
    if (widget.account != null) _textController.text = widget.account.label;
    super.initState();
  }


 @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    
     final walletService = Provider.of<WalletService>(context);
     return 
    Provider(create: (_) =>
                    AccountListStore(walletService: walletService),
                    
      builder:(context,child){
         final accountListStore = Provider.of<AccountListStore>(context);
    //     final subaddressCreationStore =
    //     Provider.of<SubadrressCreationStore>(context,listen: false);
        return  AlertDialog(
        //contentPadding: EdgeInsets.all(12),
       // insetPadding: EdgeInsets.symmetric(horizontal: 5),
        backgroundColor:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('Add Account',style: TextStyle(fontWeight:FontWeight.w800))),
        content: Form(
          key: _formKey,
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _textController,
               decoration: InputDecoration(
                hintText: 'Account name',
                hintStyle: TextStyle(
                  color:Color(0xff77778B)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                 border: OutlineInputBorder(
                  
                  borderRadius:BorderRadius.circular(8),
                 
                 ),
            
               ),
                  validator: (value) {
                       accountListStore.validateAccountName(value);
                      return accountListStore.errorMessage;
                      }
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(onPressed: ()=> Navigator.pop(context),
              // async {
              //     if (_formKey.currentState.validate()) {
              //       await subaddressCreationStore.add(label: _labelController.text);
              //       Navigator.of(context).pop();
              //     }
              //   },
                elevation: 0,
              color: Color(0xffE8E8E8),
              height: MediaQuery.of(context).size.height*0.18/3,
              minWidth: MediaQuery.of(context).size.width*0.89/3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              child: Text('Cancel',style: TextStyle(fontSize:17,color:settingsStore.isDarkTheme ? Colors.white : Colors.black,fontWeight:FontWeight.w800),),
              ),
              
                  MaterialButton(onPressed:()async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    if (widget.account != null) {
                      await accountListStore.renameAccount(
                          index: widget.account.id, label: _textController.text);
                    } else {
                      await accountListStore.addAccount(
                          label: _textController.text);
                    }
                    Navigator.of(context).pop(_textController.text);
                  },
              // async {
              //     if (_formKey.currentState.validate()) {
              //       await subaddressCreationStore.add(label: _labelController.text);
              //       Navigator.of(context).pop();
              //     }
              //   },
                elevation: 0,
              color: Color(0xff0BA70F),
              height: MediaQuery.of(context).size.height*0.18/3,
              minWidth: MediaQuery.of(context).size.width*0.89/3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              child: Text(widget.account != null ? 'Rename' : 'Add',style: TextStyle(fontSize:17,color:Colors.white,fontWeight:FontWeight.w800),),
              )
                ],
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