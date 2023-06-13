
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:beldex_wallet/generated/l10n.dart';
// import 'package:beldex_wallet/src/screens/base_page.dart';
// import 'package:beldex_wallet/src/stores/node_list/node_list_store.dart';
// import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
// import 'package:beldex_wallet/src/widgets/primary_button.dart';
// import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
// import 'package:provider/provider.dart';

// class NewNodePage extends BasePage {
//   @override
//   String get title => S.current.node_new;


// @override
// Widget trailing(BuildContext context){
//   return Container();
// }

//   @override
//   Widget body(BuildContext context) => NewNodePageForm();
// }

// class NewNodePageForm extends StatefulWidget {
//   @override
//   NewNodeFormState createState() => NewNodeFormState();
// }

// class NewNodeFormState extends State<NewNodePageForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nodeAddressController = TextEditingController();
//   final _nodePortController = TextEditingController();
//   final _loginController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _nodeAddressController.dispose();
//     _nodePortController.dispose();
//     _loginController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final nodeList = Provider.of<NodeListStore>(context);

//     return ScrollableWithBottomSection(
//       contentPadding: EdgeInsets.all(0),
//       content: Form(
//           key: _formKey,
//           child: Container(
//               padding:
//                   EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
//               child: Column(
//                 children: <Widget>[
//                   BeldexTextField(
//                     hintText: S.of(context).node_address,
//                     controller: _nodeAddressController,
//                     validator: (value) {
//                       nodeList.validateNodeAddress(value);
//                       return nodeList.errorMessage;
//                     },
//                   ),
//                   Padding(
//                       padding: EdgeInsets.only(top: 20),
//                       child: BeldexTextField(
//                         hintText: S.of(context).node_port,
//                         controller: _nodePortController,
//                         keyboardType: TextInputType.numberWithOptions(
//                             signed: false, decimal: false),
//                         validator: (value) {
//                           nodeList.validateNodePort(value);
//                           return nodeList.errorMessage;
//                         },
//                       )),
//                   Padding(
//                       padding: EdgeInsets.only(top: 20),
//                       child: BeldexTextField(
//                         hintText: S.of(context).login,
//                         controller: _loginController,
//                         validator: (value) => null,
//                       )),
//                   Padding(
//                       padding: EdgeInsets.only(top: 20),
//                       child: BeldexTextField(
//                         hintText: S.of(context).password,
//                         controller: _passwordController,
//                         validator: (value) => null,
//                       )),
//                 ],
//               ))),
//       bottomSection: Container(
//         child: Row(
//           children: <Widget>[
//             Flexible(
//                 child: Container(
//               padding: EdgeInsets.only(right: 8.0),
//               child: PrimaryButtonNode(
//                   onPressed: () {
//                     _nodeAddressController.text = '';
//                     _nodePortController.text = '';
//                     _loginController.text = '';
//                     _passwordController.text = '';
//                   },
//                   text: S.of(context).reset,
//                   color:
//                       Theme.of(context).accentTextTheme.caption.backgroundColor,
//                   borderColor:
//                       Theme.of(context).accentTextTheme.caption.decorationColor),
//             )),
//             Flexible(
//                 child: Container(
//               padding: EdgeInsets.only(left: 8.0),
//               child: PrimaryButton(
//                 onPressed: () async {
//                   if (!_formKey.currentState.validate()) {
//                     return;
//                   }

//                   await nodeList.addNode(
//                       address: _nodeAddressController.text,
//                       port: _nodePortController.text,
//                       login: _loginController.text,
//                       password: _passwordController.text);

//                   Navigator.of(context).pop();
//                 },
//                 text: S.of(context).save,
//                 color:
//                     Theme.of(context).primaryTextTheme.button.backgroundColor,
//                 borderColor:
//                     Theme.of(context).primaryTextTheme.button.backgroundColor,
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }































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
  final _nodenameController = TextEditingController();
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
              color:settingsStore.isDarkTheme ? Color(0xff24242F) : Color(0xffDADADA)
            ),
              padding:
                  EdgeInsets.only( top: 10,),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Add Node',style:TextStyle(fontWeight:FontWeight.w800,fontSize:19)),
                  ),
                 
                 Padding(
                   padding: const EdgeInsets.only(left: 20, right: 20),
                   child: TextFormField(
                controller: _nodeAddressController,
               decoration: InputDecoration(
                fillColor: settingsStore.isDarkTheme ? Color(0xff333343):Color(0xffFFFFFF),
                filled: true,
                hintText: S.of(context).node_address,
                hintStyle: TextStyle(
                    color:Color(0xff77778B)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 10 ),
                   border: OutlineInputBorder(
                    borderSide: BorderSide(color:settingsStore.isDarkTheme ? Color(0xff333343): Color(0xffFFFFFF)),
                    borderRadius:BorderRadius.circular(8),
                   
                   ),
            
               ),
                    validator: (value) {
                         nodeList.validateNodeAddress(value);
                         return nodeList.errorMessage;
                        }
              ),
                 ),
                  // BeldexTextField(
                  //   hintText: S.of(context).node_address,
                  //   controller: _nodeAddressController,
                  //   validator: (value) {
                  //     nodeList.validateNodeAddress(value);
                  //     return nodeList.errorMessage;
                  //   },
                  // ),
                   Padding(
                     padding: const EdgeInsets.only(top:8.0,left: 20,right: 20),
                     child: TextFormField(
                controller: _nodePortController,
               decoration: InputDecoration(
                fillColor: settingsStore.isDarkTheme ? Color(0xff333343):Color(0xffFFFFFF),
                filled: true,
                hintText: S.of(context).node_port,
                hintStyle: TextStyle(
                  color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 10 ),
                 border: OutlineInputBorder(
                  
                  borderRadius:BorderRadius.circular(8),
                 
                 ),
            
               ),
                  validator: (value) {
                        nodeList.validateNodePort(value);
                        return nodeList.errorMessage;
                        }
              ),
                   ),
                  // Padding(
                  //     padding: EdgeInsets.only(top: 20),
                  //     child: BeldexTextField(
                  //       color: Color(0xff333343),
                  //       hintText: S.of(context).node_port,
                  //       controller: _nodePortController,
                  //       keyboardType: TextInputType.numberWithOptions(
                  //           signed: false, decimal: false),
                  //       validator: (value) {
                  //         nodeList.validateNodePort(value);
                  //         return nodeList.errorMessage;
                  //       },
                  //     )),

                   Padding(
                     padding: const EdgeInsets.only(top:8.0,left:20,right:20),
                     child: TextFormField(
                controller: _nodenameController,
               decoration: InputDecoration(
                // fillColor: settingsStore.isDarkTheme ? Color(0xff333343):Color(0xffFFFFFF),
                // filled: true,
                hintText: 'Node name (optional)',
                hintStyle: TextStyle(
                  color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 10 ),
                 border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: settingsStore.isDarkTheme ? Color(0xff3F3F4D) : Color(0xffDADADA)
                  ),
                  borderRadius:BorderRadius.circular(8),
                 
                 ),
            
               ),
                  validator: (value)=>null
              ),
                   ),


                   Padding(
                     padding: const EdgeInsets.only(top:8.0,left:20,right:20),
                     child: TextFormField(
                controller: _loginController,
               decoration: InputDecoration(
                // fillColor: settingsStore.isDarkTheme ? Color(0xff333343):Color(0xffFFFFFF),
                // filled: true,
                hintText: 'User name (optional)',
                hintStyle: TextStyle(
                  color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 10 ),
                 border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: settingsStore.isDarkTheme ? Color(0xff3F3F4D) : Color(0xffDADADA)
                  ),
                  borderRadius:BorderRadius.circular(8),
                 
                 ),
            
               ),
                  validator: (value)=>null
              ),
                   ),
                  // Padding(
                  //     padding: EdgeInsets.only(top: 20),
                  //     child: BeldexTextField(
                  //       hintText: S.of(context).login,
                  //       controller: _loginController,
                  //       validator: (value) => null,
                  //     )),
                  Padding(
                     padding: const EdgeInsets.only(top:8.0,left:20,right:20),
                     child: TextFormField(
                controller: _passwordController,
               decoration: InputDecoration(
                // fillColor: settingsStore.isDarkTheme ? Color(0xff333343):Color(0xffFFFFFF),
                // filled: true,
                hintText: '${S.of(context).password} (optional)',
                hintStyle: TextStyle(
                  color:settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xff77778B)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 10 ),
                 border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: settingsStore.isDarkTheme ? Color(0xff3F3F4D) : Color(0xffDADADA)
                  ),
                  borderRadius:BorderRadius.circular(8),
                 
                 ),
            
               ),
                  validator: (value)=>null
              ),
                   ),


                   Container(
                    padding: EdgeInsets.only(left:20,right:20),
                    height: MediaQuery.of(context).size.height*0.30/3,
                    child: Row(
                      children: [
                       Text('Test Result',style: TextStyle(fontSize: 18),),
                       Padding(
                         padding: const EdgeInsets.only(left:10.0),
                         child: Text('Connection Failed',style: TextStyle(color: Colors.red)),
                       )
                      ],
                    ),
                   ),
                   Container(
                    height: MediaQuery.of(context).size.height*0.30/3,
                    padding: EdgeInsets.only(left: 15.0,right:15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:settingsStore.isDarkTheme ? Color(0xff333343) : Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight:Radius.circular(10 )),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Test'),
                        Row(
                          children:[
                             Text('cancel'),
                             Text('Add')
                          ]
                        )
                      ],
                    ),
                   )
                  // Padding(
                  //     padding: EdgeInsets.only(top: 20),
                  //     child: BeldexTextField(
                  //       hintText: S.of(context).password,
                  //       controller: _passwordController,
                  //       validator: (value) => null,
                  //     )),
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
               // final prefs = await SharedPreferences.getInstance();
                
               



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
