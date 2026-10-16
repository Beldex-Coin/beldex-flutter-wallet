import 'package:beldex_wallet/src/screens/nodes/test_mainnet_node.dart';
import 'package:beldex_wallet/src/screens/nodes/test_node.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/nospaceformatter.dart';
import 'package:flutter/material.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/node_list/node_list_store.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewNodePage extends BasePage {
  @override
  String getTitle(AppLocalizations t) => t.nodes;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
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
  bool isMainnet = false;

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
        return PopScope(
          // Prevent closing the dialog when the user presses the back button
          canPop: false,
          child: AlertDialog(
            surfaceTintColor: Colors.transparent,
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
                  padding: const EdgeInsetsDirectional.all(13.0),
                  child: Text(tr(context).checkingNodeConnection,
                      textAlign: TextAlign.center,
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
    var newNodePageChangeNotifier =
        Provider.of<NewNodePageChangeNotifier>(context);
    return GestureDetector(
     onTap: (){
       FocusScope.of(context).unfocus();
     },
      child: ScrollableWithBottomSection(
        contentPadding: EdgeInsets.all(0),
        content: Form(
            key: _formKey,
            child: Container(
                margin: EdgeInsetsDirectional.only(top: 50, start: 15, end: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: settingsStore.isDarkTheme
                            ? Colors.transparent
                            : Color(0xffDADADA)),
                    borderRadius: BorderRadius.circular(10),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff24242F)
                        : Color(0xffEDEDED)),
                padding: EdgeInsetsDirectional.only(
                  top: 10,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsetsDirectional.all(15.0),
                      child: Text(tr(context).addNode,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontWeight: FontWeight.bold, fontSize: 19)),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                      child: TextFormField(
                          controller: _nodeAddressController,
                          decoration: InputDecoration(
                              fillColor: settingsStore.isDarkTheme
                                  ? Color(0xff333343)
                                  : Color(0xffFFFFFF),
                              filled: true,
                              hintText: tr(context).node_address,
                              hintStyle: TextStyle(backgroundColor: Colors.transparent,color: Color(0xff77778B)),
                              contentPadding: const EdgeInsetsDirectional.only(
                                start: 8,
                                end: 8,
                                top: 12,
                                bottom: 12,
                              ),
                              errorStyle: const TextStyle(
                                backgroundColor: Colors.transparent,
                                color: Colors.red,
                                fontSize: 12,
                                height: 1.3,
                              ),
                              errorMaxLines: 3,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                            nodeList.validateNodeAddress(value!,tr(context));
                            return nodeList.errorMessage;
                          }),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 8.0, start: 20, end: 20),
                      child: TextFormField(
                          controller: _nodePortController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            NoSpaceFormatter(),
                            FilteringTextInputFormatter.deny(RegExp('[-,. ]'))
                          ],
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              fillColor: settingsStore.isDarkTheme
                                  ? Color(0xff333343)
                                  : Color(0xffFFFFFF),
                              filled: true,
                              hintText: tr(context).node_port,
                              hintStyle: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff77778B)
                                      : Color(0xff77778B)),
                              contentPadding: const EdgeInsetsDirectional.only(
                                start: 8,
                                end: 8,
                                top: 12,
                                bottom: 12,
                              ),
                              errorStyle: const TextStyle(
                                backgroundColor: Colors.transparent,
                                color: Colors.red,
                                fontSize: 12,
                                height: 1.3,
                              ),
                              errorMaxLines: 3,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                            nodeList.validateNodePort(value!,tr(context));
                            return nodeList.errorMessage;
                          }),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 8.0, start: 20, end: 20),
                      child: TextFormField(
                          controller: _nodenameController,
                          decoration: InputDecoration(
                            hintText: tr(context).nodeNameOptional,
                            hintMaxLines: 2,
                            maintainHintSize: false,
                            hintStyle: TextStyle(
                                backgroundColor: Colors.transparent,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff77778B)
                                    : Color(0xff77778B)),
                            contentPadding:
                                EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 10),
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
                          const EdgeInsetsDirectional.only(top: 8.0, start: 20, end: 20),
                      child: TextFormField(
                          controller: _loginController,
                          decoration: InputDecoration(
                            hintText: tr(context).userNameOptional,
                            hintMaxLines: 2,
                            maintainHintSize: false,
                            hintStyle: TextStyle(
                                backgroundColor: Colors.transparent,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff77778B)
                                    : Color(0xff77778B)),
                            contentPadding:
                                EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 10),
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
                          const EdgeInsetsDirectional.only(top: 8.0, start: 20, end: 20),
                      child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: tr(context).passwordOptional,
                            hintStyle: TextStyle(
                                backgroundColor: Colors.transparent,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff77778B)
                                    : Color(0xff77778B)),
                            contentPadding:
                                EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 10),
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
                    newNodePageChangeNotifier.testMode == null ||
                            newNodePageChangeNotifier.testMode == ''
                        ? Container(
                            height: 10,
                          )
                        : Container(
                      padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                      margin: const EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      height: MediaQuery.sizeOf(context).height * 0.20 / 3,
                      decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? const Color(0xff333343)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tr(context).testResult,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: MediaQuery.sizeOf(context).height * 0.06 / 3,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: newNodePageChangeNotifier.canLoad
                                ? Text(
                              tr(context).checking,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                backgroundColor: Colors.transparent,
                                color: const Color(0xff2979FB),
                                fontWeight: FontWeight.w800,
                                fontSize: MediaQuery.sizeOf(context).height * 0.06 / 3,
                              ),
                            )
                                : Text(
                              newNodePageChangeNotifier.isNodeChecked
                                  ? tr(context).success
                                  : tr(context).connectionFailed,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: newNodePageChangeNotifier.isNodeChecked
                                    ? const Color(0xff1AB51E)
                                    : Colors.red,
                                fontWeight: FontWeight.w800,
                                fontSize: MediaQuery.sizeOf(context).height * 0.06 / 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.26 / 3,
                      padding: const EdgeInsetsDirectional.only(
                        start: 15.0,
                        end: 15.0,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? const Color(0xff333343)
                            : Colors.white,
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(10),
                          bottomEnd: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Test button
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: GestureDetector(
                                onTap: () async {
                                  if (!(_formKey.currentState?.validate() ?? false)) {
                                    return;
                                  }

                                  _loading(true);
                                  try {
                                    newNodePageChangeNotifier.setTestMode('testing');
                                    newNodePageChangeNotifier.setCanLoad(true);

                                    final nodeWithPort =
                                        '${_nodeAddressController.text}:${_nodePortController.text}';

                                    final isMainnet = await TestMainNetNode(
                                      uri: nodeWithPort,
                                      login: _loginController.text,
                                      password: _passwordController.text,
                                    ).isMainNet();

                                    final isNodeChecked1 =
                                    await NodeForTest().isWorkingNode(nodeWithPort);

                                    newNodePageChangeNotifier.setIsMainnet(isMainnet);
                                    newNodePageChangeNotifier.setTestMode('done');
                                    newNodePageChangeNotifier
                                        .setIsNodeChecked(isNodeChecked1);
                                    newNodePageChangeNotifier.setCanLoad(false);
                                  } finally {
                                    newNodePageChangeNotifier.setCanLoad(false);
                                    _loading(false);
                                  }
                                },
                                child: Text(
                                  tr(context).test,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.sizeOf(context).height * 0.07 / 3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Cancel button
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _nodeAddressController.clear();
                              _nodePortController.clear();
                              _loginController.clear();
                              _passwordController.clear();
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.all(10.0),
                              child: Text(
                                tr(context).cancel,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: settingsStore.isDarkTheme
                                      ? const Color(0xffB9B9B9)
                                      : const Color(0xff9292A7),
                                  fontSize: MediaQuery.sizeOf(context).height * 0.07 / 3,
                                ),
                              ),
                            ),
                          ),

                          // Add button
                          GestureDetector(
                            onTap: newNodePageChangeNotifier.isNodeChecked
                                ? () async {
                              if (!(_formKey.currentState?.validate() ?? false)) {
                                return;
                              }
                              if (newNodePageChangeNotifier
                                  .isMainnet) {
                                var status = false;
                                for (var i = 0;
                                i < nodeList.nodes!.length;
                                i++) {
                                  if (nodeList.nodes![i].uri.contains(
                                      '${_nodeAddressController.text}:${_nodePortController.text}')) {
                                    status = true;
                                    await Fluttertoast.showToast(msg: tr(context).nodeAlreadyExists,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: settingsStore.isDarkTheme ? Colors.black : Colors.white,
                                      backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,
                                    );
                                    return;
                                  }
                                }
                                if (!status) {
                                  await nodeList.addNode(
                                      address:
                                      _nodeAddressController.text,
                                      port: _nodePortController.text,
                                      login: _loginController.text,
                                      password:
                                      _passwordController.text);
                                }
                                Navigator.of(context).pop();
                              } else {
                                await Fluttertoast.showToast(
                                  msg: tr(context).pleaseAddAMainnetNode,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM, // Toast gravity (top, center, or bottom)
                                  textColor: Colors.white, // Text color // Background color
                                );
                              }
                            }
                                : null,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(end:5.0, top: 10.0, bottom: 10.0),
                              child: Text(
                                tr(context).add,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.sizeOf(context).height * 0.07 / 3,
                                  fontWeight: FontWeight.bold,
                                  color: newNodePageChangeNotifier.isNodeChecked
                                      ? const Color(0xff1AB51E)
                                      : settingsStore.isDarkTheme
                                      ? const Color(0xffB9B9B9)
                                      : const Color(0xff9292A7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}

class NewNodePageChangeNotifier with ChangeNotifier {
  bool canLoad = false;
  String testMode = '';
  bool isMainnet = false;
  bool isNodeChecked = false;

  void setCanLoad(bool status) {
    canLoad = status;
    notifyListeners();
  }

  void setTestMode(String status) {
    testMode = status;
    notifyListeners();
  }

  void setIsMainnet(bool status) {
    isMainnet = status;
    notifyListeners();
  }

  void setIsNodeChecked(bool status) {
    isNodeChecked = status;
    notifyListeners();
  }
}
