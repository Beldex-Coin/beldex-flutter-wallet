import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('qr scanner uses the active locale for its labels', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ru'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Builder(
          builder: (context) {
            final options = buildScanOptions(context);
            final translations = tr(context);

            return Scaffold(
              body: Text(
                '${options.android.appBarTitle}|${options.strings['cancel']}|${options.strings['flash_on']}|${translations.transaction_priority_blink}',
              ),
            );
          },
        ),
      ),
    );

    final text = tester.widget<Text>(find.byType(Text));
    expect(text.data, contains('Кошелёк Beldex'));
    expect(text.data, contains('Отмена'));
    expect(text.data, contains('Flash'));
  });
}
