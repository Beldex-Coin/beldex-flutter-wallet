import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/node_list/node_list_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

class NewNodePage extends BasePage {
  @override
  String get title => S.current.node_new;

  @override
  Widget body(BuildContext context) => NewNodePageForm();
}

class NewNodePageForm extends StatefulWidget {
  @override
  NewNodeFormState createState() => NewNodeFormState();
}

class NewNodeFormState extends State<NewNodePageForm> {
  final _formKey = GlobalKey<FormState>();
  final _nodeAddressController = TextEditingController();
  final _nodePortController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nodeAddressController.dispose();
    _nodePortController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nodeList = Provider.of<NodeListStore>(context);

    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.all(0),
      content: Form(
          key: _formKey,
          child: Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
              child: Column(
                children: <Widget>[
                  BeldexTextField(
                    hintText: S.of(context).node_address,
                    controller: _nodeAddressController,
                    validator: (value) {
                      nodeList.validateNodeAddress(value);
                      return nodeList.errorMessage;
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: BeldexTextField(
                        hintText: S.of(context).node_port,
                        controller: _nodePortController,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        validator: (value) {
                          nodeList.validateNodePort(value);
                          return nodeList.errorMessage;
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: BeldexTextField(
                        hintText: S.of(context).login,
                        controller: _loginController,
                        validator: (value) => null,
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: BeldexTextField(
                        hintText: S.of(context).password,
                        controller: _passwordController,
                        validator: (value) => null,
                      )),
                ],
              ))),
      bottomSection: Container(
        child: Row(
          children: <Widget>[
            Flexible(
                child: Container(
              padding: EdgeInsets.only(right: 8.0),
              child: PrimaryButtonNode(
                  onPressed: () {
                    _nodeAddressController.text = '';
                    _nodePortController.text = '';
                    _loginController.text = '';
                    _passwordController.text = '';
                  },
                  text: S.of(context).reset,
                  color:
                      Theme.of(context).accentTextTheme.caption.backgroundColor,
                  borderColor:
                      Theme.of(context).accentTextTheme.caption.decorationColor),
            )),
            Flexible(
                child: Container(
              padding: EdgeInsets.only(left: 8.0),
              child: PrimaryButton(
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  await nodeList.addNode(
                      address: _nodeAddressController.text,
                      port: _nodePortController.text,
                      login: _loginController.text,
                      password: _passwordController.text);

                  Navigator.of(context).pop();
                },
                text: S.of(context).save,
                color:
                    Theme.of(context).primaryTextTheme.button.backgroundColor,
                borderColor:
                    Theme.of(context).primaryTextTheme.button.backgroundColor,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
