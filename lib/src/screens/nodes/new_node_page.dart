import 'package:beldex_wallet/src/screens/nodes/test_node.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/node_list/node_list_store.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

class NewNodePage extends BasePage {
  @override
  String get title => S.current.nodes;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

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
  final _nodenameController = TextEditingController();

  bool isNodeChecked = false;
  dynamic testMode;

  bool canLoad = false;

  void _loading(bool _canLoad) {
    if (_canLoad) {
      // Show the HUD progress loader
      showHUDLoader(context);
    } else {
      Navigator.pop(context);
    }
  }

  void showHUDLoader(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          // Prevent closing the dialog when the user presses the back button
          onWillPop: () async => false,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(S.of(context).checkingNodeConnection,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nodeAddressController.dispose();
    _nodePortController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    isNodeChecked = false;
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
              margin: EdgeInsets.only(top: 50, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: settingsStore.isDarkTheme
                          ? Colors.transparent
                          : Color(0xffDADADA)),
                  borderRadius: BorderRadius.circular(10),
                  color: settingsStore.isDarkTheme
                      ? Color(0xff24242F)
                      : Color(0xffEDEDED)),
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(S.of(context).addNode,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                        controller: _nodeAddressController,
                        decoration: InputDecoration(
                            fillColor: settingsStore.isDarkTheme
                                ? Color(0xff333343)
                                : Color(0xffFFFFFF),
                            filled: true,
                            hintText: S.of(context).node_address,
                            hintStyle: TextStyle(color: Color(0xff77778B)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            )),
                        validator: (value) {
                          nodeList.validateNodeAddress(value);
                          return nodeList.errorMessage;
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                    child: TextFormField(
                        controller: _nodePortController,
                        decoration: InputDecoration(
                            fillColor: settingsStore.isDarkTheme
                                ? Color(0xff333343)
                                : Color(0xffFFFFFF),
                            filled: true,
                            hintText: S.of(context).node_port,
                            hintStyle: TextStyle(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff77778B)
                                    : Color(0xff77778B)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            )),
                        validator: (value) {
                          nodeList.validateNodePort(value);
                          return nodeList.errorMessage;
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                    child: TextFormField(
                        controller: _nodenameController,
                        decoration: InputDecoration(
                          hintText: S.of(context).nodeNameOptional,
                          hintStyle: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff3F3F4D)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff3F3F4D)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) => null),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                    child: TextFormField(
                        controller: _loginController,
                        decoration: InputDecoration(
                          hintText: S.of(context).userNameOptional,
                          hintStyle: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff3F3F4D)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff3F3F4D)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) => null),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                    child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: S.of(context).passwordOptional,
                          hintStyle: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff3F3F4D)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff3F3F4D)
                                    : Color(0xffDADADA)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) => null),
                  ),
                  testMode == null || testMode == ''
                      ? Container(
                          height: 10,
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          height: MediaQuery.of(context).size.height * 0.20 / 3,
                          decoration: BoxDecoration(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff333343)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).testResult,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.06 /
                                      3,
                                ),
                              ),
                              canLoad
                                  ? Center(
                                      child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(S.of(context).checking,
                                          style: TextStyle(
                                            color: Color(0xff2979FB),
                                            fontWeight: FontWeight.w800,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06 /
                                                3,
                                          )),
                                    ))
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                          isNodeChecked
                                              ? S.of(context).success
                                              : S.of(context).connectionFailed,
                                          style: TextStyle(
                                            color: !isNodeChecked
                                                ? Colors.red
                                                : Color(0xff1AB51E),
                                            fontWeight: FontWeight.w800,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06 /
                                                3,
                                          )),
                                    )
                            ],
                          )
                          //}),

                          ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.26 / 3,
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff333343)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                                onTap: () async {
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  } else {
                                    _loading(true);
                                    setState(() {});
                                    testMode = 'testing';
                                    canLoad = true;
                                    await Future<void>.delayed(
                                        Duration(seconds: 1), () {
                                      setState(() {
                                        canLoad = false;
                                      });
                                    });
                                    final nodeWithPort =
                                        '${_nodeAddressController.text}:${_nodePortController.text}'; //'194.5.152.31:19091'
                                    print('Node with port value $nodeWithPort');
                                    setState(() {});
                                    final isNodeChecked1 = await NodeForTest()
                                        .isWorkingNode(nodeWithPort);
                                    testMode = 'done';
                                    setState(() {
                                      isNodeChecked = isNodeChecked1;
                                    });
                                    print(
                                        'isNodeChecked ------->   $isNodeChecked');
                                    _loading(false);
                                  }
                                },
                                child: Text(S.of(context).test,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.07 /
                                              3,
                                      fontWeight: FontWeight.bold,
                                    )))
                            //})
                            ),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {});
                                  _nodeAddressController.text = '';
                                  _nodePortController.text = '';
                                  _loginController.text = '';
                                  _passwordController.text = '';
                                },
                                child: Text(S.of(context).cancel,
                                    style: TextStyle(
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffB9B9B9)
                                            : Color(0xff9292A7),
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.07 /
                                                3))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                                onTap: isNodeChecked
                                    ? () async {
                                        if (!_formKey.currentState.validate()) {
                                          return;
                                        }

                                        await nodeList.addNode(
                                            address:
                                                _nodeAddressController.text,
                                            port: _nodePortController.text,
                                            login: _loginController.text,
                                            password: _passwordController.text);

                                        Navigator.of(context).pop();
                                      }
                                    : null,
                                child: Text(
                                  S.of(context).add,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.07 /
                                              3,
                                      fontWeight: FontWeight.bold,
                                      color: isNodeChecked
                                          ? Color(0xff1AB51E)
                                          : settingsStore.isDarkTheme
                                              ? Color(0xffB9B9B9)
                                              : Color(0xff9292A7)),
                                )),
                          )
                        ])
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
