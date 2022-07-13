import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_wallet.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress_list.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';

part 'subaddress_list_store.g.dart';

class SubaddressListStore = SubaddressListStoreBase with _$SubaddressListStore;

abstract class SubaddressListStoreBase with Store {
  SubaddressListStoreBase({@required WalletService walletService}) {
    subaddresses = ObservableList<Subaddress>();

    if (walletService.currentWallet != null) {
      _onWalletChanged(walletService.currentWallet);
    }

    _onWalletChangeSubscription =
        walletService.onWalletChange.listen(_onWalletChanged);
  }

  @observable
  ObservableList<Subaddress> subaddresses;

  SubaddressList _subaddressList;
  StreamSubscription<Wallet> _onWalletChangeSubscription;
  StreamSubscription<List<Subaddress>> _onSubaddressesChangeSubscription;
  StreamSubscription<Account> _onAccountChangeSubscription;
  Account _account;

//  @override
//  void dispose() {
//    if (_onSubaddressesChangeSubscription != null) {
//      _onSubaddressesChangeSubscription.cancel();
//    }
//
//    if (_onAccountChangeSubscription != null) {
//      _onAccountChangeSubscription.cancel();
//    }
//
//    _onWalletChangeSubscription.cancel();
//    super.dispose();
//  }

  Future<void> _updateSubaddressList({int accountIndex}) async {
    await _subaddressList.refresh(accountIndex: accountIndex);
    subaddresses = ObservableList.of(_subaddressList.getAll());
  }

  Future<void> _onWalletChanged(Wallet wallet) async {
    if (_onSubaddressesChangeSubscription != null) {
      await _onSubaddressesChangeSubscription.cancel();
    }

    if (wallet is BelDexWallet) {
      _account = wallet.account;
      _subaddressList = wallet.getSubaddress();
      _onSubaddressesChangeSubscription = _subaddressList.subaddresses
          .listen((subaddress) => subaddresses = ObservableList.of(subaddress));
      await _updateSubaddressList(accountIndex: _account.id);

      _onAccountChangeSubscription =
          wallet.onAccountChange.listen((account) async {
        _account = account;
        await _updateSubaddressList(accountIndex: account.id);
      });

      return;
    }

    print('Incorrect wallet type for this operation (SubaddressList)');
  }
}
