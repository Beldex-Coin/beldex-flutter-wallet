import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';

class FaqPage extends BasePage {
  @override
  String get title => S.current.faq;

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

  @override
  Widget body(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        final faqItems = jsonDecode(snapshot.data.toString()) as List;

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final itemTitle = faqItems[index]['question'].toString();
            final itemChild = faqItems[index]['answer'].toString();

            return Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.green,textSelectionTheme: TextSelectionThemeData(
                selectionColor: Colors.green
              )),
              child: ExpansionTile(
                title: Text(itemTitle),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          itemChild,
                          textAlign: TextAlign.justify,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (_, __) =>
              Divider(color: Theme.of(context).dividerTheme.color, height: 1.0),
          itemCount: faqItems == null ? 0 : faqItems.length,
        );
      },
      future: rootBundle.loadString(getFaqPath(context)),
    );
  }

  String getFaqPath(BuildContext context) {
    final settingsStore = context.read<SettingsStore>();

    switch (settingsStore.languageCode) {
      case 'en':
        return 'assets/faq/faq_en.json';
      case 'de':
        return 'assets/faq/faq_de.json';
      default:
        return 'assets/faq/faq_en.json';
    }
  }
}
