import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:provider/provider.dart';
import '../../../l10n.dart';
extension RelativeDateHelpers on DateTime {
  bool isToday([DateTime? now]) {
    now ??= DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday([DateTime? now]) {
    now ??= DateTime.now();
    return isToday(now.subtract(Duration(days: 1)));
  }

  bool isPastWeek([DateTime? now]) {
    now ??= DateTime.now();
    // diffDays gives us the integer days difference, but that is a pain because a value of 6 could
    // be anywhere from 6.00 to 6.99 days ago, while the date 6 days before now will only partially
    // overlap with that range, so we have to muck around a bit to deal with those edge cases.
    final diffDays = difference(now).inDays;
    if (diffDays >= -5 && diffDays <= -1) {
      return true;
    }
    if (diffDays == 0) {
      // if diff is 0 then this is anywhere from -0.99 to 0.99: allow yesterday and today but not tomorrow
      return isToday(now) || isYesterday(now);
    }
    if (diffDays == -6) {
      // if -6 then allow the date that was 6 days ago but not the one that was 7 days ago
      return isToday(now.subtract(Duration(days: 6)));
    }
    return false;
  }
}

class DateSectionRow extends StatelessWidget {
  DateSectionRow({required this.date, required this.index});

  static final nowDate = DateTime.now();
  final DateTime date;
  final int index;
  @override
  Widget build(BuildContext context) {
    final t = tr(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    String title;
    if (date.isToday()) {
      title = t.today;
    } else if (date.isYesterday()) {
      title = t.yesterday;
    } else if (date.isPastWeek()) {
      title = DateFormat.EEEE(t.localeName).format(date);
    } else if (date.isAfter(DateTime.now().subtract(Duration(days: 304)))) {
      title = DateFormat.MMMd(t.localeName).format(date);
    } else {
      title = DateFormat.yMMMd(t.localeName).format(date);
    }

    return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 0,left:10),
        margin: EdgeInsets.only(left:18,right:18),
        decoration: BoxDecoration(
            borderRadius: index == 0 ? BorderRadius.only(topLeft: Radius.circular(8.0,),topRight: Radius.circular(8.0,)) : BorderRadius.circular(0),
            color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED)
        ),
        child: Text(title,
            style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700, color: Theme.of(context).primaryTextTheme.caption?.color)));
  }
}