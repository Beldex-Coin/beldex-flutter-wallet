import 'dart:ui';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_state.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import '../../../l10n.dart';

WalletService? walletService;

Future addSubAddressDialog(
    BuildContext context, String title, String body, String fee, String address,
    {String? buttonText,
    required void Function(BuildContext context) onPressed,
    void Function(BuildContext context)? onDismiss}) {
  return showDialog<void>(
      builder: (_) => Provider<dynamic>(
          create: (_) => SubadrressCreationStore(walletService: walletService!),
          child: AddSubAddress()),
      context: context);
}

class AddSubAddress extends StatelessWidget {
  const AddSubAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _labelController = TextEditingController();
    final subAddressCreationStore =
        Provider.of<SubadrressCreationStore>(context);

    reaction((_) => subAddressCreationStore.state,
        (SubaddressCreationState state) {
      if (state is SubaddressCreatedSuccessfully) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => Navigator.of(context).pop());
      }
    });

    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 1 / 3,
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff272733),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 40),
                            child: Form(
                                key: _formKey,
                                child: Stack(children: <Widget>[
                                  Center(
                                    child: BeldexTextField(
                                        controller: _labelController,
                                        hintText: tr(context).name,
                                        //tr(context).new_subaddress_label_name,
                                        validator: (value) {
                                          subAddressCreationStore
                                              .validateSubaddressName(value!);
                                          return subAddressCreationStore
                                              .errorMessage;
                                        }),
                                  ),
                                ])),
                          ),
                          Observer(
                            builder: (_) => SizedBox(
                              width: 250,
                              child: LoadingPrimaryButton(
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      await subAddressCreationStore.add(
                                          label: _labelController.text);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  text: 'Create',
                                  color: Color.fromARGB(255,46, 160, 33),
                                  borderColor: Color.fromARGB(255,46, 160, 33),
                                  isLoading: subAddressCreationStore.state
                                      is SubaddressIsCreating),
                            ),
                          )
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
