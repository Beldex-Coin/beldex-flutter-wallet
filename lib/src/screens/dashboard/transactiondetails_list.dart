import 'package:date_range_picker/date_range_picker.dart' as date_rage_picker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/dashboard/date_section_row.dart';
import 'package:beldex_wallet/src/screens/dashboard/transaction_row.dart';
import 'package:beldex_wallet/src/stores/action_list/action_list_store.dart';
import 'package:beldex_wallet/src/stores/action_list/date_section_item.dart';
import 'package:beldex_wallet/src/stores/action_list/transaction_list_item.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:provider/provider.dart';

class TransactionDetailsList extends BasePage {
  final _bodyKey = GlobalKey();

  @override
  Widget body(BuildContext context) =>
      TransactionDetailsListBody(key: _bodyKey);

}

class TransactionDetailsListBody extends StatefulWidget {
  TransactionDetailsListBody({Key key}) : super(key: key);

  @override
  TransactionDetailsListBodyState createState() =>
      TransactionDetailsListBodyState();
}

class TransactionDetailsListBodyState
    extends State<TransactionDetailsListBody> {
  final _listObserverKey = GlobalKey();
  final _listKey = GlobalKey();
  String syncStatus;
  IconData iconDataVal = Icons.arrow_upward_outlined;

  @override
  Widget build(BuildContext context) {
    final actionListStore = Provider.of<ActionListStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final transactionDateFormat = settingsStore.getCurrentDateFormat(
        formatUSA: 'MMMM d, yyyy, HH:mm', formatDefault: 'd MMMM yyyy, HH:mm');
    return Observer(
        key: _listObserverKey,
        builder: (_) {
          final items = actionListStore.items ?? <String>[];
          final itemsCount = items.length + 2;
          return Scaffold(
            backgroundColor: settingsStore.isDarkTheme
                ? Color(0xff171720)
                : Color(0xffffffff),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: settingsStore.isDarkTheme
                  ? Color(0xff171720)
                  : Color(0xffffffff),
              leading: Container(
                width: 60,
                padding: EdgeInsets.only(left: 15, top: 20, bottom: 5),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 30,
                  width: 40,
                  child: ButtonTheme(
                    buttonColor: Colors.transparent,
                    minWidth: double.minPositive,
                    child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'assets/images/new-images/back_button_white_theme.svg',
                          color: settingsStore.isDarkTheme
                              ? Colors.white
                              : Colors.black,
                          height: 80,
                          width: 50,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  S.of(context).transactions_text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              actions: [
                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 0, bottom: 15.0, top: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    //color: Colors.yellow,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Theme(
                                data: Theme.of(context).copyWith(
                                    accentColor: Colors.green,
                                    primaryColor: Colors.blue,
                                    backgroundColor: settingsStore.isDarkTheme
                                        ? Color(0xff292935)
                                        : Color(0xffffffff)),
                                child: Builder(
                                    builder: (context) => PopupMenuButton<int>(
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                  enabled: false,
                                                  value: -1,
                                                  child: Text(
                                                      'Filter by', // S.of(context).transactions,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .caption
                                                              .color))),
                                              PopupMenuItem(
                                                  value: 0,
                                                  child: Observer(
                                                      builder: (_) => Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(S
                                                                    .of(context)
                                                                    .incoming),
                                                                Theme(
                                                                  data: Theme.of(
                                                                          context)
                                                                      .copyWith(
                                                                          accentColor: Colors
                                                                              .green,
                                                                          checkboxTheme:
                                                                              CheckboxThemeData(
                                                                            fillColor:
                                                                                MaterialStateProperty.all(Colors.green),
                                                                            checkColor:
                                                                                MaterialStateProperty.all(Colors.white),
                                                                          )),
                                                                  child:
                                                                      Checkbox(
                                                                    value: actionListStore
                                                                        .transactionFilterStore
                                                                        .displayIncoming,
                                                                    onChanged: (value) =>
                                                                        actionListStore
                                                                            .transactionFilterStore
                                                                            .toggleIncoming(),
                                                                  ),
                                                                )
                                                              ]))),
                                              PopupMenuItem(
                                                  value: 1,
                                                  child: Observer(
                                                      builder: (_) => Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(S
                                                                    .of(context)
                                                                    .outgoing),
                                                                Theme(
                                                                  data: Theme.of(
                                                                          context)
                                                                      .copyWith(
                                                                          accentColor: Colors
                                                                              .green,
                                                                          checkboxTheme:
                                                                              CheckboxThemeData(
                                                                            fillColor:
                                                                                MaterialStateProperty.all(Colors.green),
                                                                            checkColor:
                                                                                MaterialStateProperty.all(Colors.white),
                                                                          )),
                                                                  child:
                                                                      Checkbox(
                                                                    value: actionListStore
                                                                        .transactionFilterStore
                                                                        .displayOutgoing,
                                                                    onChanged: (value) =>
                                                                        actionListStore
                                                                            .transactionFilterStore
                                                                            .toggleOutgoing(),
                                                                  ),
                                                                )
                                                              ]))),
                                              PopupMenuItem(
                                                  value: 2,
                                                  child: Text(S
                                                      .of(context)
                                                      .transactions_by_date)),
                                            ],
                                        onSelected: (item) async {
                                          print('item length --> $item');
                                          if (item == 2) {
                                            final picked =
                                                await date_rage_picker
                                                    .showDatePicker(
                                                        context: context,
                                                        initialFirstDate:
                                                            DateTime.now()
                                                                .subtract(
                                                                    Duration(
                                                                        days:
                                                                            1)),
                                                        initialLastDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2015),
                                                        lastDate:
                                                            DateTime.now());

                                            if (picked != null) {
                                              actionListStore
                                                  .transactionFilterStore
                                                  .changeStartDate(
                                                      picked.first);
                                              actionListStore
                                                  .transactionFilterStore
                                                  .changeEndDate(picked == null
                                                      ? null
                                                      : picked.last.add(
                                                          Duration(days: 1)));
                                            }
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          'assets/images/new-images/filter.svg',
                                          width: 18,
                                          height: 18,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .caption
                                              .color,
                                        ))),
                              )
                            ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                 color: settingsStore.isDarkTheme
                              ? Color(0xff272733)
                              : Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(10)
              ),
                margin: EdgeInsets.all(10),
              child: ListView.builder(
                  key: _listKey,
                  padding: EdgeInsets.only(bottom: 15),
                  itemCount: itemsCount,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container();
                    }

                    if (index == 1 && actionListStore.totalCount > 0) {
                      return Container();
                    }

                    index -= 2;

                    if (index < 0 || index >= items.length) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 2.6 / 3,
                        margin: EdgeInsets.only(
                            top: 8.0, bottom: 10.0, right: 15.0, left: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: settingsStore.isDarkTheme
                              ? Color(0xff272733)
                              : Color(0xffEDEDED), //Color(0xff24242F),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            settingsStore.isDarkTheme
                                ? SvgPicture.asset(
                                    'assets/images/new-images/notrans_black.svg')
                                : SvgPicture.asset(
                                    'assets/images/new-images/notrans_white.svg'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                S.of(context).no_trans_yet,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16.0),
                              ),
                            ),
                            Text(
                              'After your first transaction,\n you will be able to view it here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xff82828D)),
                            ),
                          ],
                        ),
                      );
                    }

                    final item = items[index];
                    if (item is DateSectionItem) {
                      return DateSectionRow(
                        date: item.date,
                        index: index,
                      );
                    }
                    if (item is TransactionListItem) {
                      final transaction = item.transaction;
                      final formattedAmount = transaction.amountFormatted();
                      final formattedFiatAmount = transaction.fiatAmount();
                      return TransactionRow(
                        onTap: () => Navigator.of(context).pushNamed(
                            Routes.transactionDetails,
                            arguments: transaction),
                        direction: transaction.direction,
                        formattedDate:
                            transactionDateFormat.format(transaction.date),
                        formattedAmount: formattedAmount,
                        formattedFiatAmount: formattedFiatAmount,
                        isPending: transaction.isPending,
                        transaction: transaction,
                        //isStake: transaction.isStake,
                      );
                    }

                    return Container();
                  }),
            ),
          );
        });
  }

  Future<bool> onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final settingsStore = Provider.of<SettingsStore>(context);
          return Dialog(
            elevation: 0,
            backgroundColor: settingsStore.isDarkTheme
                ? Color(0xff272733)
                : Color(0xffffffff),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).are_you_sure,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      S.of(context).do_you_want_to_exit_an_app,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: settingsStore.isDarkTheme
                                      ? Color(0xff333343)
                                      : Color(0xffDADADA)),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                S.of(context).no,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .caption
                                      .color,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Color(0xff0BA70F),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                S.of(context).yes,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class Item {
  Item({this.id, this.icon, this.text, this.amount, this.color});

  String id;
  IconData icon;
  String text;
  String amount;
  Color color;
}
