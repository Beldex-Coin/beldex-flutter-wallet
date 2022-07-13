import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_wallet.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:beldex_wallet/src/wallet/beldex/account_list.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/generated/l10n.dart';

part 'account_list_store.g.dart';

class AccountListStore = AccountListStoreBase with _$AccountListStore;

abstract class AccountListStoreBase with Store {
  AccountListStoreBase({@required WalletService walletService}) {
    accounts = [];
    isAccountCreating = false;

    if (walletService.currentWallet != null) {
      _onWalletChanged(walletService.currentWallet);
    }

    _onWalletChangeSubscription =
        walletService.onWalletChange.listen(_onWalletChanged);
  }

  @observable
  List<Account> accounts;

  @observable
  bool isValid;

  @observable
  String errorMessage;

  @observable
  bool isAccountCreating;

  AccountList _accountList;
  StreamSubscription<Wallet> _onWalletChangeSubscription;
  StreamSubscription<List<Account>> _onAccountsChangeSubscription;

//  @override
//  void dispose() {
//    _onWalletChangeSubscription.cancel();
//
//    if (_onAccountsChangeSubscription != null) {
//      _onAccountsChangeSubscription.cancel();
//    }
//
//    super.dispose();
//  }

  void updateAccountList() {
    _accountList.refresh();
    accounts = _accountList.getAll();
  }

  Future addAccount({String label}) async {
    try {
      isAccountCreating = true;
      await _accountList.addAccount(label: label);
      updateAccountList();
      isAccountCreating = false;
    } catch (e) {
      isAccountCreating = false;
    }
  }

  Future renameAccount({int index, String label}) async {
    await _accountList.setLabelSubaddress(accountIndex: index, label: label);
    updateAccountList();
  }

  Future _onWalletChanged(Wallet wallet) async {
    if (_onAccountsChangeSubscription != null) {
      await _onAccountsChangeSubscription.cancel();
    }

    if (wallet is BelDexWallet) {
      _accountList = wallet.getAccountList();
      _onAccountsChangeSubscription =
          _accountList.accounts.listen((accounts) => this.accounts = accounts);
      updateAccountList();

      return;
    }

    print('Incorrect wallet type for this operation (AccountList)');
  }

  void validateAccountName(String value) {
    const pattern = '^[a-zA-Z0-9_]{1,15}\$';
    final regExp = RegExp(pattern);
    isValid = regExp.hasMatch(value);
    errorMessage = isValid ? null : S.current.error_text_account_name;
  }
}
