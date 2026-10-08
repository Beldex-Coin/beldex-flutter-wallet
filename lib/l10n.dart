import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
export 'l10n/app_localizations.dart' show AppLocalizations;

AppLocalizations tr(BuildContext ctx) {
  return AppLocalizations.of(ctx) ?? lookupAppLocalizations(Locale('en', ''));
}

class LanguageName {
  final String code;
  final String name;
  const LanguageName(this.code, this.name);
}

const languageNames = <LanguageName>[
  LanguageName('ar', 'عربي (Arabic)'),
  LanguageName('zh', '中文 (Chinese (Simplified))'),
  LanguageName('en', 'English'),
  LanguageName('fr', 'Français (French)'),
  LanguageName('de', 'Deutsch (German)'),
  LanguageName('ja', '日本 (Japanese)'),
  LanguageName('ko', '한국어 (Korean)'),
  LanguageName('pt', 'Português (Portuguese (Brazil))'),
  LanguageName('ru', 'Русский (Russian)'),
  LanguageName('es', 'Español (Spanish)'),
  LanguageName('tr', 'Türkçe (Turkish)'),
  LanguageName('vi', 'Vietnam (Vietnamese)')
];

class LanguageNotifier with ChangeNotifier {
  LanguageNotifier();
  void trigger() { notifyListeners(); }
}