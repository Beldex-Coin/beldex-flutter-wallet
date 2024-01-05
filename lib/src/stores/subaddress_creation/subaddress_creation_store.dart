import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_wallet.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress_list.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/stores/subaddress_creation/subaddress_creation_state.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';

part 'subaddress_creation_store.g.dart';

class SubadrressCreationStore = SubadrressCreationStoreBase
    with _$SubadrressCreationStore;

abstract class SubadrressCreationStoreBase with Store {
  SubadrressCreationStoreBase({required WalletService walletService}) {

    if (walletService.currentWallet != null) {
      _onWalletChanged(walletService.currentWallet!);
    }

    _onWalletChangeSubscription =
        walletService.onWalletChange.listen(_onWalletChanged);
  }

  SubaddressCreationState state = SubaddressCreationStateInitial();

  @observable
  bool isValid=false;

  @observable
  String? errorMessage;

  SubaddressList _subaddressList = SubaddressList();
  late StreamSubscription<Wallet> _onWalletChangeSubscription;
  StreamSubscription<Account>? _onAccountChangeSubscription;
  Account _account = Account(id: 0);

//  @override
//  void dispose() {
//    _onWalletChangeSubscription.cancel();
//
//    if (_onAccountChangeSubscription != null) {
//      _onAccountChangeSubscription.cancel();
//    }
//
//    super.dispose();
//  }

  Future<void> add({required String label}) async {
    try {
      state = SubaddressIsCreating();
      await _subaddressList.addSubaddress(
          accountIndex: _account.id, label: label);
      state = SubaddressCreatedSuccessfully();
    } catch (e) {
      state = SubaddressCreationFailure(error: e.toString());
    }
  }

  Future<void> _onWalletChanged(Wallet wallet) async {
    if (wallet is BelDexWallet) {
      _account = wallet.account;
      _subaddressList = wallet.getSubaddress();

      _onAccountChangeSubscription =
          wallet.onAccountChange.listen((account) async {
        _account = account;
        await _subaddressList.update(accountIndex: account.id);
      });
      return;
    }

    print('Incorrect wallet type for this operation (SubaddressList)');
  }

  void validateSubaddressName(String value) {
    const pattern = '''^[^`,'"]{1,20}\$''';
    final regExp = RegExp(pattern);
    isValid = regExp.hasMatch(value);
    errorMessage = isValid! ? null : 'Enter a valid name upto 20 characters'; //S.current.error_text_subaddress_name;
  }
}
