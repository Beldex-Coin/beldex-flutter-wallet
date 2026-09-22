import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:beldex_coin/account_list.dart' as account_list;
import 'package:beldex_wallet/src/wallet/beldex/account.dart';

List<Account> _getAllAccountsSync(void _) => account_list
    .getAllAccount()
    .map((accountRow) => Account.fromRow(accountRow))
    .toList();

class AccountList {
  AccountList() :
    _isRefreshing = false,
    _isUpdating = false,
    _accounts = BehaviorSubject<List<Account>>();

  Stream<List<Account>> get accounts => _accounts.stream;

  final BehaviorSubject<List<Account>> _accounts;
  bool _isRefreshing;
  bool _isUpdating;

  Future update() async {
    if (_isUpdating) {
      return;
    }

    try {
      _isUpdating = true;
      await refresh();
      final accounts = await getAllAsync();
      _accounts.add(accounts);
      _isUpdating = false;
    } catch (e) {
      _isUpdating = false;
      rethrow;
    }
  }


  /// Reads the accounts on a background isolate so the native call cannot
  /// stall the UI thread.
  Future<List<Account>> getAllAsync() =>
      compute<void, List<Account>>(_getAllAccountsSync, null);

  Future addAccount({required String label}) async {
    await account_list.addAccount(label: label);
    await update();
  }

  Future setLabelSubaddress({required int accountIndex, required String label}) async {
    await account_list.setLabelForAccount(
        accountIndex: accountIndex, label: label);
    await update();
  }

  Future refresh() async {
    if (_isRefreshing) {
      return;
    }

    try {
      _isRefreshing = true;
      await account_list.refreshAccounts();
      _isRefreshing = false;
    } catch (e) {
      _isRefreshing = false;
      print(e);
      rethrow;
    }
  }
}
