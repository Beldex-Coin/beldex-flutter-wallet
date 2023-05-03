import 'dart:convert';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/receive/qr_image.dart';
import 'package:beldex_wallet/src/stores/subaddress_list/subaddress_list_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/util/constants.dart' as constants;
import 'dart:ui' as ui;

import 'package:wc_flutter_share/wc_flutter_share.dart';

class ReceivePage extends BasePage {
  @override
  bool get isModalBackButton => false;

  @override
  String get title => S.current.wallet_list_title;

  @override
  Color get textColor => Colors.white;

  @override
  Widget leading(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 12.0, left: 10),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10),
          //color: Colors.black,
        ),
        child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  }

  /*@override
  Widget leading(BuildContext context) {
    final walletStore = Provider.of<WalletStore>(context);

    return Padding(
      padding: const EdgeInsets.only(top:20.0,bottom: 5,left: 10),
      child: Container(
        width: 25,
        height: 25,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: ButtonTheme(
          minWidth: double.minPositive,
          child: FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.all(0),
              onPressed: () => Share.text(
                  'Share address', walletStore.subaddress.address, 'text/plain'),
              child: SvgPicture.asset('assets/images/share_svg.svg',color: Colors.white,)),
        ),
      ),
    );
  }*/

  @override
  Widget body(BuildContext context) =>
      SingleChildScrollView(child: ReceiveBody());
}

class ReceiveBody extends StatefulWidget {
  @override
  ReceiveBodyState createState() => ReceiveBodyState();
}

class ReceiveBodyState extends State<ReceiveBody> {
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
  GlobalKey _globalKey = new GlobalKey();
  //final originalSize=800;
  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject() as RenderRepaintBoundary;
      //double pixelRatio = originalSize / MediaQuery.of(context).size.width;
      ui.Image image = await boundary.toImage(pixelRatio:3.0,);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }
  void _incrementCounter(String address, String text) async {
    try {
    final imageUint8List = await _capturePng();
      await WcFlutterShare.share(
          text: address,
          sharePopupTitle: 'share',
          fileName: 'share.png',
          mimeType: 'image/png',
          bytesOfFile: imageUint8List);
      setState(() {
      });
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    final walletStore = Provider.of<WalletStore>(context);
    final subaddressListStore = Provider.of<SubaddressListStore>(context);

    final currentColor = Theme.of(context).selectedRowColor;
    final notCurrentColor = Color.fromARGB(255, 40,42,51);//Theme.of(context).scaffoldBackgroundColor;

    amountController.addListener(() {
      if (_formKey.currentState.validate()) {
        walletStore.onChangedAmountValue(amountController.text);
      } else {
        walletStore.onChangedAmountValue('');
      }
    });

    return SafeArea(
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      S.current.receive,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.green),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: (){
                          _incrementCounter(walletStore.subaddress.address,amountController.text);
                          //Share.text('Share address', walletStore.subaddress.address, 'text/plain');
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.shadowColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: ButtonTheme(
                            minWidth: double.minPositive,
                            child: TextButton(
                                onPressed: () {
                                  _incrementCounter(walletStore.subaddress.address,amountController.text);
                                  //Share.text('Share address', walletStore.subaddress.address, 'text/plain');
                                  },
                                child: SvgPicture.asset('assets/images/share_svg.svg',color: Theme.of(context).primaryTextTheme.caption.color,)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top:35.0,left:35.0,right:35.0),
                          color: Theme.of(context).backgroundColor,
                          child: Column(
                            children: <Widget>[
                              Observer(builder: (_) {
                                return Row(
                                  children: <Widget>[
                                    Spacer(flex: 1),
                                    Flexible(
                                        flex: 2,
                                        child: AspectRatio(
                                          aspectRatio: 1.0,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            color: Colors.white,
                                            child: QrImage(
                                              data: walletStore.subaddress.address + walletStore.amountValue,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        )),
                                    Spacer(flex: 1)
                                  ],
                                );
                              }),
                              Observer(builder: (_) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            child: Center(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Clipboard.setData(ClipboardData(
                                                          text: walletStore.subaddress.address));
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                        elevation: 5,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                                        ),
                                                        content: Text(S
                                                            .of(context)
                                                            .copied_to_clipboard,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                                        backgroundColor: Color.fromARGB(255, 46, 113, 43),
                                                        duration: Duration(
                                                            milliseconds: 1500),
                                                      ));
                                                    },
                                                    child: Text(
                                                        walletStore.subaddress.address,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey,//Theme.of(context).primaryTextTheme.headline6.color
                                                        )
                                                    )
                                                )
                                            )
                                        ))
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(left: constants.leftPx,right: constants.rightPx),
                          elevation: 2,
                          color: Theme.of(context).accentTextTheme.headline6.backgroundColor,//Color.fromARGB(255, 31, 32, 39),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Form(
                                    key: _formKey,
                                    child: NewBeldexTextField(
                                        keyboardType:
                                        TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(RegExp('[- ]'))
                                        ],
                                        hintText: S.of(context).amount,
                                        validator: (value) {
                                          walletStore.validateAmount(value);
                                          return walletStore.errorMessage;
                                        },
                                        controller: amountController
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 10,right: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Container(
                                            //color: Theme.of(context).accentTextTheme.headline5.color,
                                            child: Column(
                                              children: <Widget>[
                                                ListTile(
                                                  title: Text(
                                                    S.of(context).subaddresses,
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Theme.of(context).primaryTextTheme.caption.color,//Colors.white,//Theme.of(context).primaryTextTheme.headline5.color
                                                    ),
                                                  ),
                                                  trailing: Container(
                                                    width: 28.0,
                                                    height: 28.0,
                                                    child: InkWell(
                                                      onTap: () => Navigator.of(context)
                                                          .pushNamed(Routes.newSubaddress),
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(14.0)),
                                                      child: SvgPicture.asset('assets/images/add.svg',color: Theme.of(context).accentTextTheme.caption.decorationColor,),
                                                    ),
                                                  ),
                                                ),
                                                /* Divider(
                                                color: Theme.of(context).dividerTheme.color,
                                                height: 1.0,
                                              )*/
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Observer(builder: (_) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: subaddressListStore.subaddresses.length,
                                      separatorBuilder: (context, i) {
                                        return Divider(
                                          color: Colors.transparent,//Theme.of(context).dividerTheme.color,
                                          height: 1.0,
                                        );
                                      },
                                      itemBuilder: (context, i) {
                                        return Observer(builder: (_) {
                                          final subaddress =
                                          subaddressListStore.subaddresses[i];
                                          final isCurrent = walletStore.subaddress.address ==
                                              subaddress.address;
                                          final label = subaddress.label.isNotEmpty
                                              ? subaddress.label
                                              : subaddress.address;

                                          return InkWell(
                                            onTap: () => walletStore.setSubaddress(subaddress),
                                            child: isCurrent ? Card(
                                              elevation: 2,
                                              color: Theme.of(context).accentTextTheme.overline.backgroundColor,//Color.fromARGB(255, 40,42,51),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.only(left: 10),
                                                padding: EdgeInsets.all(15),
                                                child: Text(
                                                  label,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Theme.of(context).primaryTextTheme.caption.color,//Colors.white,//Theme.of(context).primaryTextTheme.headline5.color
                                                  ),
                                                ),
                                              ),
                                            ):Container(
                                              margin: EdgeInsets.only(left: 10),
                                              padding: EdgeInsets.all(15),
                                              child: Text(
                                                label,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Theme.of(context).primaryTextTheme.caption.color,//Colors.white,//Theme.of(context).primaryTextTheme.headline5.color
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      });
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               /* Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      color: Theme.of(context).accentTextTheme.headline5.color,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              S.of(context).subaddresses,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline5
                                      .color),
                            ),
                            trailing: Container(
                              width: 28.0,
                              height: 28.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).selectedRowColor,
                                  shape: BoxShape.circle),
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(Routes.newSubaddress),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                                child: Icon(
                                  Icons.add,
                                  color: BeldexPalette.teal,
                                  size: 22.0,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).dividerTheme.color,
                            height: 1.0,
                          )
                        ],
                      ),
                    ))
                  ],
                ),
                Observer(builder: (_) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: subaddressListStore.subaddresses.length,
                      separatorBuilder: (context, i) {
                        return Divider(
                          color: Theme.of(context).dividerTheme.color,
                          height: 1.0,
                        );
                      },
                      itemBuilder: (context, i) {
                        return Observer(builder: (_) {
                          final subaddress =
                              subaddressListStore.subaddresses[i];
                          final isCurrent = walletStore.subaddress.address ==
                              subaddress.address;
                          final label = subaddress.label.isNotEmpty
                              ? subaddress.label
                              : subaddress.address;

                          return InkWell(
                            onTap: () => walletStore.setSubaddress(subaddress),
                            child: Container(
                              color: isCurrent ? currentColor : notCurrentColor,
                              child: Column(children: <Widget>[
                                ListTile(
                                  title: Text(
                                    label,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline5
                                            .color),
                                  ),
                                )
                              ]),
                            ),
                          );
                        });
                      });
                })*/
              ],
            ))));
  }
}
class NewBeldexTextField extends StatelessWidget {
  NewBeldexTextField(
      {this.enabled = true,
        this.hintText,
        this.keyboardType,
        this.controller,
        this.validator,
        this.inputFormatters,
        this.prefixIcon,
        this.suffixIcon,
        this.focusNode});

  final bool enabled;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String Function(String) validator;
  final List<TextInputFormatter> inputFormatters;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentTextTheme.headline6.backgroundColor,//Color.fromARGB(255, 31,32,39),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.5,color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:25.0),
        child: TextFormField(
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            enabled: enabled,
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).accentTextTheme.overline.color),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintStyle:
                TextStyle(fontSize: 16.0, color: Colors.grey,fontWeight: FontWeight.bold),
                hintText: hintText,
                /*focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: BeldexPalette.teal, width: 2.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor, width: 1.0)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: BeldexPalette.red, width: 1.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: BeldexPalette.red, width: 1.0)),*/
                errorStyle: TextStyle(color: BeldexPalette.red)),
            validator: validator),
      ),
    );
  }
}