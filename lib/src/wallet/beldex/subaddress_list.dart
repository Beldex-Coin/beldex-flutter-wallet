import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:beldex_coin/subaddress_list.dart' as subaddress_list;
import 'package:beldex_wallet/src/wallet/beldex/subAddress.dart';

List<Subaddress> _getAllSubaddressesSync(void _) => subaddress_list
    .getAllSubaddresses()
    .map((subaddressRow) => Subaddress.fromRow(subaddressRow))
    .toList();

class SubaddressList {
  SubaddressList() :
    _isRefreshing = false,
    _isUpdating = false,
    _subaddress = BehaviorSubject<List<Subaddress>>();

  Stream<List<Subaddress>> get subaddresses => _subaddress.stream;

  final BehaviorSubject<List<Subaddress>> _subaddress;
  bool _isRefreshing;
  bool _isUpdating;

  Future update({required int accountIndex}) async {
    if (_isUpdating) {
      return;
    }

    try {
      _isUpdating = true;
      await refresh(accountIndex: accountIndex);
      final subaddresses = await getAllAsync();
      _subaddress.add(subaddresses);
      _isUpdating = false;
    } catch (e) {
      _isUpdating = false;
      rethrow;
    }
  }


  /// Reads the subaddresses on a background isolate so the native call cannot
  /// stall the UI thread.
  Future<List<Subaddress>> getAllAsync() =>
      compute<void, List<Subaddress>>(_getAllSubaddressesSync, null);

  Future addSubaddress({required int accountIndex, required String label}) async {
    await subaddress_list.addSubaddress(
        accountIndex: accountIndex, label: label);
    await update(accountIndex: accountIndex);
  }

  Future setLabelSubaddress(
      {required int accountIndex, required int addressIndex, required String label}) async {
    await subaddress_list.setLabelForSubaddress(
        accountIndex: accountIndex, addressIndex: addressIndex, label: label);
    await update(accountIndex: accountIndex);
  }

  Future refresh({required int accountIndex}) async {
    if (_isRefreshing) {
      return;
    }

    try {
      _isRefreshing = true;
      await subaddress_list.refreshSubaddresses(accountIndex: accountIndex);
      _isRefreshing = false;
    } on PlatformException catch (e) {
      _isRefreshing = false;
      print(e);
      rethrow;
    }
  }
}
