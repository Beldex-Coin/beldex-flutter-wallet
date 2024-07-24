import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_store.dart';
import 'package:beldex_wallet/src/stores/subaddress_list/subaddress_list_store.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n.dart';

class SubAddressAlert extends StatefulWidget {
  const SubAddressAlert({Key? key, required this.subAddressListStore}) : super(key: key);
  final SubaddressListStore subAddressListStore;

  @override
  SubAddressAlertState createState() => SubAddressAlertState();
}

class SubAddressAlertState extends State<SubAddressAlert> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  List<String> subAddressList = [];
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

  void getSubAddressList() {
    setState(() {
      for (var i = 0; i < widget.subAddressListStore.subaddresses.length; i++) {
        subAddressList.add(widget.subAddressListStore.subaddresses[i].label);
      }
    });
  }

  bool checkSubAddressAlreadyExist(String label) {
    return subAddressList.contains(label);
  }

  @override
  Widget build(BuildContext context) {
    final walletService = Provider.of<WalletService>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    return Provider(
        create: (_) => SubadrressCreationStore(walletService: walletService),
        builder: (context, child) {
          final subAddressCreationStore =
              Provider.of<SubadrressCreationStore>(context, listen: false);
          return Dialog(
            surfaceTintColor: Colors.transparent,
            insetPadding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor:settingsStore.isDarkTheme ?Color(0xff272733) : Color(0xffFFFFFF),
            child: Form(
              key: _formKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tr(context).subAddress,style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _labelController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: tr(context).labelName,
                          hintStyle: TextStyle(backgroundColor:Colors.transparent,color: Color(0xff77778B)),
                          errorStyle: TextStyle(backgroundColor: Colors.transparent,color: Colors.red),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
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
                        validator: (value) {
                          final regex = RegExp(r'^[a-zA-Z0-9]+$');
                          if (!(regex.hasMatch(value!)) || !validateInput(value)) {
                            return tr(context).enterAValidSubAddress;
                          } else if (checkSubAddressAlreadyExist(value)) {
                            return tr(context).subaddressAlreadyExist;
                          } else {
                            subAddressCreationStore.validateSubaddressName(value);
                            return subAddressCreationStore.errorMessage;
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    LoadingPrimaryButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() {
                              isLoading = true;
                            });
                            await subAddressCreationStore.add(
                                label: _labelController.text);
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        text: tr(context).new_subaddress_create,
                        color: Color(0xff0BA70F),
                        borderColor: Color(0xff0BA70F),
                        isLoading: isLoading)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
