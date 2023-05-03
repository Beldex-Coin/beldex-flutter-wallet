import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:provider/provider.dart';

class DateSectionRow extends StatelessWidget {
  DateSectionRow({this.date, this.index});

  static final nowDate = DateTime.now();
  final DateTime date;
  final int index;
  @override
  Widget build(BuildContext context) {
    final diffDays = date.difference(nowDate).inDays;
    final isToday = nowDate.day == date.day &&
        nowDate.month == date.month &&
        nowDate.year == date.year;
    final settingsStore = Provider.of<SettingsStore>(context);
    final currentLanguage = settingsStore.languageCode;
    final dateSectionDateFormat = settingsStore.getCurrentDateFormat(
        formatUSA: 'MMM d', formatDefault: 'd MMM');
    var title = '';

    if (isToday) {
      title = S.of(context).today;
    } else if (diffDays == 0) {
      title = S.of(context).yesterday;
    } else if (diffDays > -7 && diffDays < 0) {
      final dateFormat = DateFormat.EEEE(currentLanguage);
      title = dateFormat.format(date);
    } else {
      title = dateSectionDateFormat.format(date);
    }

    return Container(
       padding: const EdgeInsets.only(top: 10, bottom: 0,left:10),
      margin: EdgeInsets.only(left:18,right:18),
       decoration: BoxDecoration(
                        borderRadius: index == 0 ? BorderRadius.only(topLeft: Radius.circular(8.0,),topRight: Radius.circular(8.0,)) : BorderRadius.circular(0),
                        color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED)
                      ),
        child: Text(title,
            style: TextStyle(fontSize: 16, color: Theme.of(context).primaryTextTheme.caption.color)));
  }
}
