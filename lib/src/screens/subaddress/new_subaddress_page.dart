import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_state.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

class NewSubaddressPage extends BasePage {
  @override
  String get title => S.current.receive;

  @override
  Widget leading(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.only(top: 12.0, left: 10),
        // decoration: BoxDecoration(
        //   //borderRadius: BorderRadius.circular(10),
        //   //color: Colors.black,
        // ),
        // child:SvgPicture.asset('assets/images/beldex_logo_foreground1.svg')
        );
  }

 @override
  Widget trailing(BuildContext context) {
    return Container();
  }

 @override
  Widget middle(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) => NewSubaddressForm();

  @override
  Widget build(BuildContext context) {
    final subaddressCreationStore =
        Provider.of<SubadrressCreationStore>(context);

    reaction((_) => subaddressCreationStore.state,
        (SubaddressCreationState state) {
      if (state is SubaddressCreatedSuccessfully) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => Navigator.of(context).pop());
      }
    });

    return super.build(context);
  }
}

class NewSubaddressForm extends StatefulWidget {
  @override
  NewSubaddressFormState createState() => NewSubaddressFormState();
}

class NewSubaddressFormState extends State<NewSubaddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final subaddressCreationStore =
        Provider.of<SubadrressCreationStore>(context);

    return Dialog(







      child: Container(
        height:150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:40.0,right: 40),
              child: Form(
                  key: _formKey,
                  child: Stack(children: <Widget>[
                    Center(
                      child: BeldexTextField(
                          controller: _labelController,
                          hintText: S.of(context).new_subaddress_label_name,
                          validator: (value) {
                            subaddressCreationStore.validateSubaddressName(value);
                            return subaddressCreationStore.errorMessage;
                          }),
                    ),
                  ])),
            ),
            Observer(
              builder: (_) => SizedBox(
                width: 250,
                child: LoadingPrimaryButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await subaddressCreationStore.add(label: _labelController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    text: S.of(context).new_subaddress_create,
                    color: Theme.of(context).primaryTextTheme.button.backgroundColor,
                    borderColor:
                    Theme.of(context).primaryTextTheme.button.backgroundColor,
                    isLoading: subaddressCreationStore.state is SubaddressIsCreating),
              ),
            )
          ],
        ),
      ),
    )/*ScrollableWithBottomSection(
      contentPadding: EdgeInsets.only(left:40,right:40,top: 50),
      content: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
                key: _formKey,
                child: Stack(children: <Widget>[
                  Center(
                    child: BeldexTextField(
                        controller: _labelController,
                        hintText: S.of(context).new_subaddress_label_name,
                        validator: (value) {
                          subaddressCreationStore.validateSubaddressName(value);
                          return subaddressCreationStore.errorMessage;
                        }),
                  ),
                ])),
            Observer(
              builder: (_) => SizedBox(
                width: 250,
                child: LoadingPrimaryButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await subaddressCreationStore.add(label: _labelController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    text: S.of(context).new_subaddress_create,
                    color: Theme.of(context).primaryTextTheme.button.backgroundColor,
                    borderColor:
                    Theme.of(context).primaryTextTheme.button.backgroundColor,
                    isLoading: subaddressCreationStore.state is SubaddressIsCreating),
              ),
            )
          ],
        ),
      ),
      *//*bottomSection: Observer(
        builder: (_) => SizedBox(
          width: 250,
          child: LoadingPrimaryButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  await subaddressCreationStore.add(label: _labelController.text);
                  Navigator.of(context).pop();
                }
              },
              text: S.of(context).new_subaddress_create,
              color: Theme.of(context).primaryTextTheme.button.backgroundColor,
              borderColor:
                  Theme.of(context).primaryTextTheme.button.backgroundColor,
              isLoading: subaddressCreationStore.state is SubaddressIsCreating),
        ),
      ),*//*
    )*/;
  }
}
