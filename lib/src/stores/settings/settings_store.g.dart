// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on SettingsStoreBase, Store {
  final _$nodeAtom = Atom(name: 'SettingsStoreBase.node');

  @override
  Node get node {
    _$nodeAtom.reportRead();
    return super.node;
  }

  @override
  set node(Node value) {
    _$nodeAtom.reportWrite(value, super.node, () {
      super.node = value;
    });
  }

  final _$fiatCurrencyAtom = Atom(name: 'SettingsStoreBase.fiatCurrency');

  @override
  FiatCurrency get fiatCurrency {
    _$fiatCurrencyAtom.reportRead();
    return super.fiatCurrency;
  }

  @override
  set fiatCurrency(FiatCurrency value) {
    _$fiatCurrencyAtom.reportWrite(value, super.fiatCurrency, () {
      super.fiatCurrency = value;
    });
  }

  final _$transactionPriorityAtom =
      Atom(name: 'SettingsStoreBase.transactionPriority');

  @override
  BeldexTransactionPriority get transactionPriority {
    _$transactionPriorityAtom.reportRead();
    return super.transactionPriority;
  }

  @override
  set transactionPriority(BeldexTransactionPriority value) {
    _$transactionPriorityAtom.reportWrite(value, super.transactionPriority, () {
      super.transactionPriority = value;
    });
  }

  final _$balanceDisplayModeAtom =
      Atom(name: 'SettingsStoreBase.balanceDisplayMode');

  @override
  BalanceDisplayMode get balanceDisplayMode {
    _$balanceDisplayModeAtom.reportRead();
    return super.balanceDisplayMode;
  }

  @override
  set balanceDisplayMode(BalanceDisplayMode value) {
    _$balanceDisplayModeAtom.reportWrite(value, super.balanceDisplayMode, () {
      super.balanceDisplayMode = value;
    });
  }

  final _$balanceDetailAtom = Atom(name: 'SettingsStoreBase.balanceDetail');

  @override
  AmountDetail get balanceDetail {
    _$balanceDetailAtom.reportRead();
    return super.balanceDetail;
  }

  @override
  set balanceDetail(AmountDetail value) {
    _$balanceDetailAtom.reportWrite(value, super.balanceDetail, () {
      super.balanceDetail = value;
    });
  }

  final _$shouldSaveRecipientAddressAtom =
      Atom(name: 'SettingsStoreBase.shouldSaveRecipientAddress');

  @override
  bool get shouldSaveRecipientAddress {
    _$shouldSaveRecipientAddressAtom.reportRead();
    return super.shouldSaveRecipientAddress;
  }

  @override
  set shouldSaveRecipientAddress(bool value) {
    _$shouldSaveRecipientAddressAtom
        .reportWrite(value, super.shouldSaveRecipientAddress, () {
      super.shouldSaveRecipientAddress = value;
    });
  }

  final _$allowBiometricAuthenticationAtom =
      Atom(name: 'SettingsStoreBase.allowBiometricAuthentication');

  @override
  bool get allowBiometricAuthentication {
    _$allowBiometricAuthenticationAtom.reportRead();
    return super.allowBiometricAuthentication;
  }

  @override
  set allowBiometricAuthentication(bool value) {
    _$allowBiometricAuthenticationAtom
        .reportWrite(value, super.allowBiometricAuthentication, () {
      super.allowBiometricAuthentication = value;
    });
  }

  final _$enableFiatCurrencyAtom =
      Atom(name: 'SettingsStoreBase.enableFiatCurrency');

  @override
  bool get enableFiatCurrency {
    _$enableFiatCurrencyAtom.reportRead();
    return super.enableFiatCurrency;
  }

  @override
  set enableFiatCurrency(bool value) {
    _$enableFiatCurrencyAtom.reportWrite(value, super.enableFiatCurrency, () {
      super.enableFiatCurrency = value;
    });
  }

  final _$isDarkThemeAtom = Atom(name: 'SettingsStoreBase.isDarkTheme');

  @override
  bool get isDarkTheme {
    _$isDarkThemeAtom.reportRead();
    return super.isDarkTheme;
  }

  @override
  set isDarkTheme(bool value) {
    _$isDarkThemeAtom.reportWrite(value, super.isDarkTheme, () {
      super.isDarkTheme = value;
    });
  }

  final _$defaultPinLengthAtom =
      Atom(name: 'SettingsStoreBase.defaultPinLength');

  @override
  int get defaultPinLength {
    _$defaultPinLengthAtom.reportRead();
    return super.defaultPinLength;
  }

  @override
  set defaultPinLength(int value) {
    _$defaultPinLengthAtom.reportWrite(value, super.defaultPinLength, () {
      super.defaultPinLength = value;
    });
  }

  final _$setAllowBiometricAuthenticationAsyncAction =
      AsyncAction('SettingsStoreBase.setAllowBiometricAuthentication');

  @override
  Future<dynamic> setAllowBiometricAuthentication(
      {@required bool allowBiometricAuthentication}) {
    return _$setAllowBiometricAuthenticationAsyncAction.run(() => super
        .setAllowBiometricAuthentication(
            allowBiometricAuthentication: allowBiometricAuthentication));
  }

  final _$setEnableFiatCurrencyAsyncAction =
      AsyncAction('SettingsStoreBase.setEnableFiatCurrency');

  @override
  Future<dynamic> setEnableFiatCurrency({@required bool enableFiatCurrency}) {
    return _$setEnableFiatCurrencyAsyncAction.run(() =>
        super.setEnableFiatCurrency(enableFiatCurrency: enableFiatCurrency));
  }

  final _$saveDarkThemeAsyncAction =
      AsyncAction('SettingsStoreBase.saveDarkTheme');

  @override
  Future<dynamic> saveDarkTheme({@required bool isDarkTheme}) {
    return _$saveDarkThemeAsyncAction
        .run(() => super.saveDarkTheme(isDarkTheme: isDarkTheme));
  }

  final _$saveLanguageCodeAsyncAction =
      AsyncAction('SettingsStoreBase.saveLanguageCode');

  @override
  Future<dynamic> saveLanguageCode({@required String languageCode}) {
    return _$saveLanguageCodeAsyncAction
        .run(() => super.saveLanguageCode(languageCode: languageCode));
  }

  final _$setCurrentNodeAsyncAction =
      AsyncAction('SettingsStoreBase.setCurrentNode');

  @override
  Future<dynamic> setCurrentNode({@required Node node}) {
    return _$setCurrentNodeAsyncAction
        .run(() => super.setCurrentNode(node: node));
  }

  final _$setCurrentFiatCurrencyAsyncAction =
      AsyncAction('SettingsStoreBase.setCurrentFiatCurrency');

  @override
  Future<dynamic> setCurrentFiatCurrency({@required FiatCurrency currency}) {
    return _$setCurrentFiatCurrencyAsyncAction
        .run(() => super.setCurrentFiatCurrency(currency: currency));
  }

  final _$setCurrentTransactionPriorityAsyncAction =
      AsyncAction('SettingsStoreBase.setCurrentTransactionPriority');

  @override
  Future<dynamic> setCurrentTransactionPriority(
      {@required BeldexTransactionPriority priority}) {
    return _$setCurrentTransactionPriorityAsyncAction
        .run(() => super.setCurrentTransactionPriority(priority: priority));
  }

  final _$setCurrentBalanceDisplayModeAsyncAction =
      AsyncAction('SettingsStoreBase.setCurrentBalanceDisplayMode');

  @override
  Future<dynamic> setCurrentBalanceDisplayMode(
      {@required BalanceDisplayMode balanceDisplayMode}) {
    return _$setCurrentBalanceDisplayModeAsyncAction.run(() => super
        .setCurrentBalanceDisplayMode(balanceDisplayMode: balanceDisplayMode));
  }

  final _$setCurrentBalanceDetailAsyncAction =
      AsyncAction('SettingsStoreBase.setCurrentBalanceDetail');

  @override
  Future<dynamic> setCurrentBalanceDetail(
      {@required AmountDetail balanceDetail}) {
    return _$setCurrentBalanceDetailAsyncAction
        .run(() => super.setCurrentBalanceDetail(balanceDetail: balanceDetail));
  }

  final _$setSaveRecipientAddressAsyncAction =
      AsyncAction('SettingsStoreBase.setSaveRecipientAddress');

  @override
  Future<dynamic> setSaveRecipientAddress(
      {@required bool shouldSaveRecipientAddress}) {
    return _$setSaveRecipientAddressAsyncAction.run(() => super
        .setSaveRecipientAddress(
            shouldSaveRecipientAddress: shouldSaveRecipientAddress));
  }

  final _$setDefaultPinLengthAsyncAction =
      AsyncAction('SettingsStoreBase.setDefaultPinLength');

  @override
  Future<dynamic> setDefaultPinLength({@required int pinLength}) {
    return _$setDefaultPinLengthAsyncAction
        .run(() => super.setDefaultPinLength(pinLength: pinLength));
  }

  @override
  String toString() {
    return '''
node: ${node},
fiatCurrency: ${fiatCurrency},
transactionPriority: ${transactionPriority},
balanceDisplayMode: ${balanceDisplayMode},
balanceDetail: ${balanceDetail},
shouldSaveRecipientAddress: ${shouldSaveRecipientAddress},
allowBiometricAuthentication: ${allowBiometricAuthentication},
enableFiatCurrency: ${enableFiatCurrency},
isDarkTheme: ${isDarkTheme},
defaultPinLength: ${defaultPinLength}
    ''';
  }
}
