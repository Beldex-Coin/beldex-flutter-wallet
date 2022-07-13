// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seed_language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SeedLanguageStore on SeedLanguageStoreBase, Store {
  final _$selectedSeedLanguageAtom =
      Atom(name: 'SeedLanguageStoreBase.selectedSeedLanguage');

  @override
  String get selectedSeedLanguage {
    _$selectedSeedLanguageAtom.reportRead();
    return super.selectedSeedLanguage;
  }

  @override
  set selectedSeedLanguage(String value) {
    _$selectedSeedLanguageAtom.reportWrite(value, super.selectedSeedLanguage,
        () {
      super.selectedSeedLanguage = value;
    });
  }

  final _$SeedLanguageStoreBaseActionController =
      ActionController(name: 'SeedLanguageStoreBase');

  @override
  void setSelectedSeedLanguage(String seedLanguage) {
    final _$actionInfo = _$SeedLanguageStoreBaseActionController.startAction(
        name: 'SeedLanguageStoreBase.setSelectedSeedLanguage');
    try {
      return super.setSelectedSeedLanguage(seedLanguage);
    } finally {
      _$SeedLanguageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedSeedLanguage: ${selectedSeedLanguage}
    ''';
  }
}
