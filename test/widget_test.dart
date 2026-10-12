import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/theme_changer.dart';
import 'package:beldex_wallet/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class _TestPage extends BasePage {
  @override
  String getTitle(AppLocalizations t) => 'Language';

  @override
  Widget trailing(BuildContext context) => const SizedBox.shrink();

  @override
  Widget? leading(BuildContext context) => null;

  @override
  Widget body(BuildContext context) => const SizedBox.shrink();
}

void main() {
  testWidgets('page title does not apply a background color', (tester) async {
    final themeChanger = ThemeChanger(Themes.darkTheme);

    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeChanger>.value(
        value: themeChanger,
        child: MaterialApp(
          theme: Themes.darkTheme,
          home: _TestPage(),
        ),
      ),
    );

    final title = tester.widget<Text>(find.text('Language'));
    expect(title.style?.backgroundColor, isNull);
  });
}
