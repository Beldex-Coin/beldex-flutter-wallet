import 'package:flutter/material.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/stores/seed_language/seed_language_store.dart';
import 'package:beldex_wallet/src/widgets/present_picker.dart';

import '../../../../l10n.dart';
import '../../../stores/settings/settings_store.dart';

class SeedLanguagePicker extends StatelessWidget {
 /* final List<String> seedLocales = [
    S.current.seed_language_english,
    S.current.seed_language_chinese,
    S.current.seed_language_dutch,
    S.current.seed_language_german,
    S.current.seed_language_japanese,
    S.current.seed_language_portuguese,
    S.current.seed_language_russian,
    S.current.seed_language_spanish,
    S.current.seed_language_french,
    S.current.seed_language_italian
  ];*/
  List<String> getSeedLocales(AppLocalizations t){
    return [
      t.seed_language_english,
      'Chinese (simplified)',
      t.seed_language_dutch,
      t.seed_language_german,
      t.seed_language_japanese,
      t.seed_language_portuguese,
      t.seed_language_russian,
      t.seed_language_spanish,
      t.seed_language_french,
      t.seed_language_italian
    ];
  }


  @override
  Widget build(BuildContext context) {
    final seedLanguageStore = Provider.of<SeedLanguageStore>(context);
    final seedLocales = getSeedLocales(tr(context));
    final settingsStore = Provider.of<SettingsStore>(context);
    return Observer(
        builder: (_) => InkWell(
          onTap: () => _setSeedLanguage(context),
          child: Container(
            padding: EdgeInsets.all(8.0),
            //width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                    color: settingsStore.isDarkTheme?Color.fromRGBO(100, 115, 137, 0.5):Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Text(seedLocales[seedLanguages.indexOf(seedLanguageStore.selectedSeedLanguage)],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Palette.lightBlue),
            ),
          ),
        ));
  }

  Future<void> _setSeedLanguage(BuildContext context) async {
    final seedLanguageStore = context.read<SeedLanguageStore>();
    final seedLocales = getSeedLocales(tr(context));
    var selectedSeedLanguage = await presentPicker(context, seedLocales);

    if (selectedSeedLanguage != null) {
      selectedSeedLanguage = seedLanguages[seedLocales.indexOf(selectedSeedLanguage)];
      seedLanguageStore.setSelectedSeedLanguage(selectedSeedLanguage);
    }
  }
}
