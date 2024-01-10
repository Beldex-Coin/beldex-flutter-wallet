import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/account_list/account_list_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n.dart';

class CreateAccountDialog extends StatefulWidget {
  CreateAccountDialog({Key? key, this.account, required this.accList, required this.accountListStore}) : super(key: key);
  final Account? account;
  final List<Account> accList;
  final AccountListStore accountListStore;

  @override
  State<CreateAccountDialog> createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  List<String> accnameList = [];

  @override
  void initState() {
    if (widget.account != null) _textController.text = widget.account!.label;
    WidgetsBinding.instance.addObserver(this);
    getAccList(context);
   // newValueAssigned(context);
    super.initState();
  }

  void getAccList(BuildContext context){
    setState(() {
      if(widget.accountListStore.accounts != null){
        for(var i=0;i< widget.accountListStore.accounts.length;i++){
             accnameList.add(widget.accountListStore.accounts[i].label);
        }
      }
      widget.accountListStore.updateAccountList();
    });
   print(accnameList);
  }

  // void getAccList() {
  //   setState(() {
  //     if (widget.accList != null) {
  //       for (var i = 0; i < widget.accList.length; i++) {
  //         accnameList.add(widget.accList[i].label);
  //       }
  //     }
  //   });
  //   print(accnameList);
  // }

  bool checkNameAlreadyExist(String accName) {
    return accnameList.contains(accName);
  }

  @override
  void dispose() {
    _textController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      FocusManager.instance.primaryFocus?.unfocus();
    } else if (state == AppLifecycleState.resumed) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  bool validateInput(String input) {
    if (input.trim().isEmpty || input.startsWith(' ')) {
      // Value consists only of spaces or contains a leading space
      return false;
    }
    // Other validation rules can be applied here
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final walletService = Provider.of<WalletService>(context);
    getAccList(context);
    return Provider(
        create: (_) => AccountListStore(walletService: walletService),
        builder: (context, child) {
          final accountListStore = Provider.of<AccountListStore>(context);
          return Dialog(
            insetPadding: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: settingsStore.isDarkTheme
                ? Color(0xff272733)
                : Color(0xffFFFFFF),
            surfaceTintColor: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tr(context).addAccount,
                      style:
                          TextStyle(backgroundColor: Colors.transparent,fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _textController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: tr(context).accountName,
                          hintStyle: TextStyle(backgroundColor:Colors.transparent,color: Color(0xff77778B)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          errorStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.red),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff2979FB),
                            ),
                          ),
                        ),
                        style: TextStyle(backgroundColor: Colors.transparent,),
                        validator: (value) {
                          if (!validateInput(value!) || value.length > 15) {
                            return tr(context).enterValidNameUpto15Characters;
                          } else if (checkNameAlreadyExist(value)) {
                            return tr(context).accountAlreadyExist;
                          } else {
                            accountListStore.validateAccountName(value);
                            if(accountListStore.errorMessage?.isNotEmpty ?? false) {
                              return accountListStore.errorMessage;
                            }else{
                              return null;
                            }
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () => Navigator.pop(context),
                            elevation: 0,
                            color: settingsStore.isDarkTheme
                                ? Color(0xff383848)
                                : Color(0xffE8E8E8),
                            height:
                                MediaQuery.of(context).size.height * 0.18 / 3,
                            minWidth: MediaQuery.of(context).size.width / 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              tr(context).cancel,
                              style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  fontSize: 17,
                                  color: settingsStore.isDarkTheme
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              if (!(_formKey.currentState?.validate() ?? false)) {
                                return;
                              }
                              if (widget.account != null &&
                                  !checkNameAlreadyExist(
                                      _textController.text)) {
                                accountListStore.renameAccount(
                                    index: widget.account!.id,
                                    label: _textController.text);
                              } else if (checkNameAlreadyExist(
                                  _textController.text)) {
                                //return tr(context).accountAlreadyExist;
                              } else {
                                accountListStore.addAccount(
                                    label: _textController.text);
                              }
                              Navigator.of(context).pop();
                            },
                            elevation: 0,
                            color: Color(0xff0BA70F),
                            height:
                                MediaQuery.of(context).size.height * 0.18 / 3,
                            minWidth: MediaQuery.of(context).size.width / 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              widget.account != null
                                  ? tr(context).rename
                                  : tr(context).add,
                              style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
