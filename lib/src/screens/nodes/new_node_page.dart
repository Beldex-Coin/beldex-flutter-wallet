import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/node_list/node_list_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewNodePage extends BasePage {
  @override
  String get title => 'Nodes';



@override
Widget trailing(BuildContext context){
  return Container();
}

// @override
// Widget middle(BuildContext context){
//   return Text('Nodes');
// }

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
 final settingsStore = Provider.of<SettingsStore>(context);
    return ScrollableWithBottomSection(
      contentPadding: EdgeInsets.all(0),
      content: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(top:50,left:15,right:15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffDADADA)
            ),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Add Node',style:TextStyle(fontWeight:FontWeight.w800,fontSize:19)),
                  ),
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
                        color: Color(0xff333343),
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
                final prefs = await SharedPreferences.getInstance();
                
               



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
