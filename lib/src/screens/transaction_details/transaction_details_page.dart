import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_info.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/screens/transaction_details/standart_list_item.dart';
import 'package:beldex_wallet/src/screens/transaction_details/standart_list_row.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class TransactionDetailsPage extends BasePage {
  TransactionDetailsPage({required this.transactionInfo});

  final TransactionInfo transactionInfo;

  @override
  String getTitle(AppLocalizations t) => t.transaction_details_title;

  @override
  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);

    return TransactionDetailsForm(
        transactionInfo: transactionInfo, settingsStore: settingsStore);
  }
}

class TransactionDetailsForm extends StatefulWidget {
  TransactionDetailsForm(
      {required this.transactionInfo, required this.settingsStore});

  final TransactionInfo transactionInfo;
  final SettingsStore settingsStore;

  @override
  TransactionDetailsFormState createState() => TransactionDetailsFormState();
}

class TransactionDetailsFormState extends State<TransactionDetailsForm> {
  final _items = <StandartListItem>[];

  /*final _dateFormat = widget.settingsStore.getCurrentDateFormat(
        formatUSA: 'yyyy.MM.dd, HH:mm', formatDefault: 'dd.MM.yyyy, HH:mm');*/
  List<StandartListItem> getItems(AppLocalizations t) {
    final _dateFormat = DateFormat.yMMMMEEEEd(t.localeName).add_jm();
    final items = [
      StandartListItem(
          title: t.transaction_details_transaction_id,
          value: widget.transactionInfo.id),
      StandartListItem(
          title: t.transaction_details_date,
          value: _dateFormat.format(widget.transactionInfo.date)),
      StandartListItem(
          title: t.transaction_details_height,
          value: '${widget.transactionInfo.height}'),
      StandartListItem(
          title: t.transaction_details_amount,
          value: widget.transactionInfo.amountFormatted())
    ];

    if (widget.settingsStore.shouldSaveRecipientAddress &&
        widget.transactionInfo.recipientAddress != null) {
      items.add(StandartListItem(
          title: t.transaction_details_recipient_address,
          value: widget.transactionInfo.recipientAddress!));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    ToastContext().init(context);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 15, top: 10, bottom: 10),
      child: ListView.separated(
          separatorBuilder: (context, index) => Container(
                height: 1,
                color: Theme.of(context).dividerTheme.color,
              ),
          padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 15),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];

            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  final url = 'https://explorer.beldex.io/tx/${item.value}';
                  _launchUrl(url);
                } else {
                  Clipboard.setData(ClipboardData(text: item.value));
                  Toast.show(
                    tr(context).transaction_details_copied(item.title),
                    duration: Toast.lengthShort,
                    gravity: Toast.bottom,
                    textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white), // Text color
                                backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,
                  );

                  // Scaffold.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(
                  //         S.of(context).transaction_details_copied(item.title)),
                  //     backgroundColor: Colors.green,
                  //     duration: Duration(milliseconds: 1500),
                  //   ),
                  // );
                }
              },
              child:
                  StandartListRow(title: '${item.title}:', value: item.value),
            );
          }),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) await launch(url);
  }
}
