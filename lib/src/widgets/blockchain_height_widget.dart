import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/wallet/beldex/get_height_by_date.dart';
import 'package:beldex_wallet/palette.dart';

class BlockchainHeightWidget extends StatefulWidget {
  BlockchainHeightWidget({GlobalKey key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BlockchainHeightState();
}

class BlockchainHeightState extends State<BlockchainHeightWidget> {
  final dateController = TextEditingController();
  final restoreHeightController = TextEditingController();
  int get height => _height;
  int _height = 0;

  @override
  void initState() {
    restoreHeightController.addListener(() => _height =
        restoreHeightController.text != null
            ? int.parse(restoreHeightController.text,onError:(source) => 0)
            : 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
                child: Card(
                  elevation: 5,
                  color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
              child: TextFormField(
                  style: TextStyle(fontSize: 14.0),
                  controller: restoreHeightController,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                      hintText: S.of(context).widgets_restore_from_blockheight,
                      /*focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: BeldexPalette.teal, width: 2.0)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).focusColor, width: 1.0))*/),
              ),
            ),
                ))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 25,bottom: 5),
          child: Center(
            child: Text(
              S.of(context).widgets_or,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).primaryTextTheme.headline6.color),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
                child: Card(
                  elevation: 5,
                  color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
              child: InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: TextFormField(
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.6)),
                          hintText: S.of(context).widgets_restore_from_date,
                          /*focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: BeldexPalette.teal,
                                  width: 2.0)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor,
                                  width: 1.0))*/),
                      controller: dateController,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
              ),
            ),
                ))
          ],
        ),
      ],
    );
  }

  Future _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
        context: context,
        initialDate: now.subtract(Duration(days: 1)),
        firstDate: DateTime(2014, DateTime.april),
        lastDate: now);

    if (date != null) {
      final height = getHeightByDate(date: date);

      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(date);
        restoreHeightController.text = '$height';
        _height = height;
      });
    }
  }
}
