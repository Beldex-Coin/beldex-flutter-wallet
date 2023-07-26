

import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class FlashPage extends BasePage{
  String controller;

  @override
  String get title => 'Flash Transaction';

  @override
  Widget body(BuildContext context)=> FlashTransaction(controllerValue: controller,);

}


class FlashTransaction extends StatefulWidget {
  final String controllerValue;
  const FlashTransaction({Key key,@required this.controllerValue}):super(key: key);

  @override
  State<FlashTransaction> createState() => _FlashTransactionState();
}

class _FlashTransactionState extends State<FlashTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}